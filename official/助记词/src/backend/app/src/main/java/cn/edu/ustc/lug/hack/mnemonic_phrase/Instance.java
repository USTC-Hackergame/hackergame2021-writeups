package cn.edu.ustc.lug.hack.mnemonic_phrase;

import fi.iki.elonen.NanoHTTPD;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

public final class Instance extends NanoHTTPD
{
    private static final String PORT = System.getenv().getOrDefault("MNEMONIC_PHRASE_PORT", "8080");

    private static final String INDEX_PATH = "/assets/mnemonic_phrase/index.html";
    private static final String FAVICON_PATH = "/assets/mnemonic_phrase/favicon.ico";
    private static final String MNEMONICS_PATH = "/assets/mnemonic_phrase/mnemonics.txt";
    private static final String SOURCE_PATH = System.getenv("MNEMONIC_PHRASE_SOURCE_ZIP");

    private static final String ERROR_RESPONSE = "SERVER INTERNAL ERROR: Not Found";

    private static final String MIME_ICO = "image/x-icon";
    private static final String MIME_ZIP = "application/zip";
    private static final String MIME_JSON = "application/json";

    private static final int JSON_INDENT = 2;
    private static final int MAX_PHRASES = 32;
    private static final int FLAG1_DURATION_MILLIS = 600;
    private static final int FLAG2_DURATION_MILLIS = 9000;

    public static void main(String[] args) throws Exception
    {
        new Instance().start(NanoHTTPD.SOCKET_READ_TIMEOUT, false);
        System.out.println("Mnemonic phrase server now started at localhost:" + PORT);
        Thread.currentThread().join(); // just make itself deadlocked for running forever
    }

    private Instance()
    {
        super(Integer.parseInt(PORT));
    }

    @Override
    public Response serve(IHTTPSession session)
    {
        var time = Instant.now();
        var uri = session.getUri();
        var method = session.getMethod();
        var response = switch (method)
        {
            case DELETE -> switch (uri)
            {
                case "/phrases" -> this.delete(session);
                default -> this.error();
            };
            case POST -> switch (uri)
            {
                case "/phrases" -> this.post(session);
                default -> this.error();
            };
            case GET -> switch (uri)
            {
                case "/mnemonics.txt" -> this.source(() -> Instance.class.getResourceAsStream(MNEMONICS_PATH), MIME_PLAINTEXT);
                case "/mnemonic-phrase-source.zip" -> this.source(() -> Files.newInputStream(Path.of(SOURCE_PATH)), MIME_ZIP);
                case "/", "/index.html" -> this.source(() -> Instance.class.getResourceAsStream(INDEX_PATH), MIME_HTML);
                case "/favicon.ico" -> this.source(() -> Instance.class.getResourceAsStream(FAVICON_PATH), MIME_ICO);
                case "/phrases" -> this.get(session);
                default -> this.error();
            };
            default -> this.error();
        };
        var query = session.getQueryParameterString();
        var status = response.getStatus().getRequestStatus();
        System.out.printf("%d | %s %s%s at %s\n", status, method, uri, query == null ? "" : "?" + query, time);
        return response;
    }

    private final ZoneId zone = ZoneId.systemDefault();

    private final Map<String, Set<Phrase>> phrases = new ConcurrentHashMap<>();

    private final Set<String> mnemonics = new BufferedReader(new InputStreamReader(Objects.requireNonNull(Instance.class
            .getResourceAsStream(MNEMONICS_PATH)), StandardCharsets.UTF_8)).lines().collect(Collectors.toUnmodifiableSet());

    private Response delete(IHTTPSession session)
    {
        try
        {
            var output = new JSONObject();
            var token = Token.from(session.getParameters());
            var phrases = this.phrases.computeIfAbsent(token.user(), k -> new LinkedHashSet<>());
            synchronized (Objects.requireNonNull(phrases))
            {
                output.put("modified", phrases.size());
                output.put("user", token.user());
                phrases.clear();
            }
            return newFixedLengthResponse(Response.Status.OK, MIME_JSON, output.toString(JSON_INDENT));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return this.error();
        }
    }

    private Response post(IHTTPSession session)
    {
        try
        {
            var output = new JSONObject();
            var token = Token.from(session.getParameters());
            var phrases = this.phrases.computeIfAbsent(token.user(), k -> new LinkedHashSet<>());
            var input = new JSONArray(new JSONTokener(new InputStreamReader(session.getInputStream(), StandardCharsets.UTF_8)));
            synchronized (Objects.requireNonNull(phrases))
            {
                var modified = 0;
                var before = System.nanoTime();
                for (var i = 0; i < input.length() && i < MAX_PHRASES && phrases.size() < MAX_PHRASES; ++i)
                {
                    var text = input.optString(i, "").toLowerCase(Locale.ENGLISH);
                    modified += phrases.add(Phrase.create(this.mnemonics, text, token)) ? 1 : 0;
                }
                var after = System.nanoTime();
                var duration = TimeUnit.MILLISECONDS.convert(after - before, TimeUnit.NANOSECONDS);
                if (duration > FLAG1_DURATION_MILLIS)
                {
                    token.addFlag(1, flag -> output.put("flag1", flag));
                }
                if (duration > FLAG2_DURATION_MILLIS)
                {
                    token.addFlag(2, flag -> output.put("flag2", flag));
                }
                output.put("modified", modified);
                output.put("user", token.user());
            }
            return newFixedLengthResponse(Response.Status.OK, MIME_JSON, output.toString(JSON_INDENT));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return this.error();
        }
    }

    private Response get(IHTTPSession session)
    {
        try
        {
            var output = new JSONArray();
            var token = Token.from(session.getParameters());
            var phrases = this.phrases.computeIfAbsent(token.user(), k -> new LinkedHashSet<>());
            synchronized (Objects.requireNonNull(phrases))
            {
                for (Phrase phrase : phrases)
                {
                    var child = new JSONObject();
                    child.put("time", DateTimeFormatter.RFC_1123_DATE_TIME.format(phrase.time().atZone(this.zone)));
                    child.put("phrase", phrase.text());
                    child.put("user", token.user());
                    output.put(child);
                }
            }
            return newFixedLengthResponse(Response.Status.OK, MIME_JSON, output.toString(JSON_INDENT));
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return this.error();
        }
    }

    private Response error()
    {
        return newFixedLengthResponse(Response.Status.INTERNAL_ERROR, MIME_PLAINTEXT, ERROR_RESPONSE);
    }

    private Response source(Callable<InputStream> source, String mimeType)
    {
        try
        {
            return newChunkedResponse(Response.Status.OK, mimeType, source.call());
        }
        catch (Exception e)
        {
            e.printStackTrace();
            return this.error();
        }
    }
}
