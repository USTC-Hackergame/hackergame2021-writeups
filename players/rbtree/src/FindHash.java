import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class FindHash {

    private static final String[] WORDS = new String[] {"ability", "access", "account", "action", "active", "activity", "addition", "address", "advantage", "advertising", "advice", "affect", "alternative", "amount", "analysis", "animal", "answer", "anything", "apartment", "appearance", "application", "area", "army", "article", "association", "attempt", "attention", "audience", "author", "average", "back", "balance", "ball", "bank", "base", "basis", "beautiful", "beginning", "being", "benefit", "beyond", "bird", "birth", "black", "blood", "board", "boat", "body", "book", "boss", "bottom", "boyfriend", "brain", "break", "broad", "brown", "brush", "budget", "building", "business", "button", "call", "camera", "capital", "card", "care", "career", "case", "cash", "category", "cause", "cell", "challenge", "chance", "change", "charge", "check", "chemistry", "chicken", "child", "choice", "cigarette", "city", "class", "classic", "click", "coast", "cold", "combination", "comfortable", "commercial", "common", "community", "company", "competition", "complex", "computer", "concept", "concern", "condition", "contact", "context", "control", "cook", "cost", "country", "county", "couple", "course", "cover", "craft", "creative", "credit", "culture", "current", "customer", "cycle", "damage", "dance", "data", "date", "deal", "dealer", "death", "debate", "decision", "deep", "definition", "demand", "department", "depth", "design", "desire", "development", "difference", "direction", "discipline", "discount", "discussion", "disease", "disk", "display", "distance", "drive", "driver", "earth", "economics", "economy", "education", "effect", "effective", "effort", "energy", "environment", "equipment", "estate", "event", "exam", "example", "exchange", "excuse", "exercise", "exit", "experience", "expression", "face", "fact", "fail", "failure", "fall", "familiar", "family", "feature", "feel", "feeling", "field", "figure", "file", "film", "final", "finding", "finish", "fire", "fish", "fishing", "flight", "flow", "focus", "following", "food", "foot", "force", "form", "foundation", "frame", "freedom", "friend", "front", "function", "future", "gain", "game", "garden", "general", "gift", "give", "glad", "goal", "good", "government", "grandmother", "great", "green", "ground", "group", "growth", "guard", "guide", "half", "hand", "handle", "head", "health", "heart", "heat", "heavy", "hello", "help", "high", "history", "hold", "home", "hope", "house", "housing", "human", "idea", "image", "impact", "importance", "income", "increase", "independent", "individual", "industry", "inflation", "influence", "information", "inside", "instance", "insurance", "interest", "internet", "investment", "issue", "item", "junior", "keep", "kind", "knowledge", "lack", "lake", "language", "lead", "leading", "leave", "length", "lesson", "level", "library", "life", "lift", "light", "line", "link", "list", "listen", "literature", "living", "local", "location", "long", "look", "love", "machine", "magazine", "main", "major", "make", "management", "many", "market", "marketing", "marriage", "material", "math", "matter", "maybe", "meaning", "meat", "media", "medicine", "medium", "meet", "member", "message", "metal", "method", "middle", "might", "mind", "minute", "model", "moment", "money", "month", "mood", "morning", "most", "mouse", "move", "movie", "music", "name", "nation", "national", "natural", "nature", "necessary", "negative", "network", "news", "newspaper", "night", "normal", "north", "note", "nothing", "notice", "number", "object", "objective", "offer", "office", "officer", "official", "opinion", "opportunity", "order", "original", "other", "outside", "oven", "page", "paint", "painting", "pair", "paper", "part", "particular", "past", "payment", "people", "performance", "period", "person", "personal", "perspective", "phase", "philosophy", "phone", "photo", "physical", "physics", "pick", "picture", "piece", "place", "plan", "plant", "plastic", "play", "player", "point", "policy", "politics", "population", "position", "positive", "possible", "post", "potential", "power", "practice", "present", "president", "press", "pressure", "price", "primary", "private", "problem", "process", "produce", "product", "profit", "program", "property", "public", "purchase", "purpose", "quality", "question", "radio", "rain", "range", "rate", "reach", "read", "reading", "reality", "reason", "recipe", "record", "reference", "register", "regular", "release", "remove", "rent", "report", "research", "reserve", "rest", "result", "return", "review", "rich", "ride", "rise", "risk", "road", "rock", "role", "room", "rule", "safe", "safety", "salt", "save", "savings", "scale", "scene", "school", "science", "screen", "search", "second", "secret", "section", "security", "self", "sell", "sense", "series", "serve", "service", "shape", "share", "shoot", "shopping", "shot", "show", "side", "sign", "simple", "single", "site", "situation", "size", "skill", "society", "software", "soil", "sound", "soup", "source", "space", "special", "specific", "speed", "spend", "sport", "spot", "spread", "spring", "square", "staff", "stage", "stand", "standard", "star", "start", "state", "statement", "stay", "step", "stick", "still", "stock", "stop", "store", "story", "strategy", "stress", "structure", "student", "studio", "study", "style", "subject", "success", "sugar", "summer", "support", "system", "table", "talk", "target", "task", "taste", "teach", "teacher", "teaching", "technology", "television", "tell", "temperature", "term", "test", "text", "thanks", "theme", "theory", "thing", "thought", "time", "title", "today", "tonight", "tool", "topic", "touch", "tough", "track", "trade", "training", "travel", "trouble", "truth", "turn", "type", "unique", "unit", "university", "user", "valuable", "value", "variety", "video", "view", "visit", "visual", "voice", "wait", "walk", "wall", "watch", "water", "wealth", "weather", "week", "western", "while", "white", "whole", "will", "wind", "wing", "woman", "wood", "word", "work", "working", "world", "worry", "worth", "writing", "year", "young"};
    private static final int LUCKY_HASH_NUMBER = -1314084409;

    private static record Phrase(String text, Instant time, String user) {

        @Override
        public boolean equals(Object o) {
            if (o instanceof Phrase that) {
                return that.text.equals(this.text) && that.time.equals(this.time) && that.user.equals(this.user);
            }
            return false;
        }

        @Override
        public int hashCode() {
            return Objects.hash(this.text, this.time, this.user);
        }
    }

    private static int hash(Object key) {
        int h;
        return (key == null) ? 0 : (h = key.hashCode()) ^ (h >>> 16);
    }

    public static void main(String[] args) {

        System.err.println("started");

        List<List<String>> phrasesHashList = new ArrayList<>();
        Instant[] instants = new Instant[9];

        Instant instant = Instant.now().truncatedTo(ChronoUnit.SECONDS);
        for (int i = 0; i < 9; i++) {
            instants[i] = instant;
            phrasesHashList.add(new ArrayList<>());
            instant = instant.plusSeconds(1);
            System.err.println("instant " + i + ": " + instant.hashCode());
        }

        int availableThreads = Runtime.getRuntime().availableProcessors();
        ExecutorService threadPool = new ThreadPoolExecutor(
            availableThreads, 128,
            0L, TimeUnit.MILLISECONDS,
            new LinkedBlockingDeque<>()
        );

        for (String word1 : WORDS) {
            threadPool.submit(() -> {
                System.err.println("New thread started, id: " + Thread.currentThread().getId());
                for (String word2 : WORDS) for (String word3 : WORDS) for (String word4 : WORDS) {
                    String phraseString = word1 + " " + word2 + " " + word3 + " " + word4;
                    for (int t = 0; t < 9; t++) {
                        Phrase phrase = new Phrase(phraseString, instants[t], "");
                        if (hash(phrase) == LUCKY_HASH_NUMBER) {
                            System.err.println("found: " + t + " @ `" + phrase.text() + "`");
                            System.out.println("(" + t + ", '" + phrase.text() + "')");
                            synchronized (phrasesHashList) {
                                phrasesHashList.get(t).add(phrase.text());
                            }
                        }
                    }

                    if (phrasesHashList.stream().allMatch(strings -> strings.size() > 20)) {
                        for (List<String> list : phrasesHashList) {
                            System.out.println(list);
                        }
                        System.exit(0);
                    }
                }
            });
        }
    }
}
