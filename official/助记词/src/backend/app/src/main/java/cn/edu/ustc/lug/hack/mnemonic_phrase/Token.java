package cn.edu.ustc.lug.hack.mnemonic_phrase;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.Security;
import java.security.Signature;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Consumer;
import java.util.regex.Pattern;

public sealed interface Token permits Token.User, Token.Guest
{
    static Token from(Map<String, List<String>> sessionParameters)
    {
        var tokens = Objects.requireNonNull(sessionParameters).getOrDefault("token", List.of());
        if (tokens.size() == 1)
        {
            var token = tokens.iterator().next();
            var matcher = User.TOKEN_PATTERN.matcher(token);
            if (matcher.matches())
            {
                try
                {
                    var sig = matcher.group(2);
                    var user = matcher.group(1);
                    return new User(User.checked(user, sig), token);
                }
                catch (GeneralSecurityException | IllegalArgumentException ignored)
                {
                    // fall through
                }
            }
        }
        return Guest.INSTANCE;
    }

    String user();

    void addFlag(int index, Consumer<Object> callback);

    enum Guest implements Token
    {
        INSTANCE;

        @Override
        public String user()
        {
            return "";
        }

        @Override
        public void addFlag(int index, Consumer<Object> callback)
        {
            Objects.requireNonNull(callback).accept(true);
        }
    }

    record User(String user, String token) implements Token
    {
        private static final Pattern TOKEN_PATTERN = Pattern.compile("(0|[1-9][0-9]*):([A-Za-z0-9+/]+=*)");

        private static final Certificate CERTIFICATE;

        private static final MessageDigest DIGEST;

        static
        {
            Security.addProvider(new BouncyCastleProvider()); // secp256k1 is not supported since java 15
            try (var stream = User.class.getResourceAsStream("/assets/mnemonic_phrase/cert.pem"))
            {
                CERTIFICATE = CertificateFactory.getInstance("X.509", "BC").generateCertificate(stream);
                DIGEST = MessageDigest.getInstance("SHA-256", "BC");
            }
            catch (GeneralSecurityException | IOException e)
            {
                throw new RuntimeException(e);
            }
        }

        private static String checked(String user, String sig) throws IllegalArgumentException, GeneralSecurityException
        {
            var signature = Signature.getInstance("SHA256withECDSA", "BC");
            var userBytes = user.getBytes(StandardCharsets.UTF_8);
            var sigBytes = Base64.getDecoder().decode(sig);
            signature.initVerify(CERTIFICATE);
            signature.update(userBytes);

            if (!signature.verify(sigBytes))
            {
                throw new IllegalArgumentException("Illegal signature for user " + user + ": " + sig);
            }
            return user;
        }

        @Override
        public void addFlag(int index, Consumer<Object> callback)
        {
            var prefix = System.getenv("MNEMONIC_PHRASE_FLAG_PREFIX_" + index);
            var input = System.getenv("MNEMONIC_PHRASE_SECRET_" + index) + ":" + this.token;
            var digest = ByteBuffer.wrap(DIGEST.digest(input.getBytes(StandardCharsets.UTF_8)));
            Objects.requireNonNull(callback).accept(String.format("flag{%s-%016x}", prefix, digest.getLong()));
        }
    }
}
