/*
 * @Author       : GZTimeWalker
 * @Date         : 2021-10-19 20:43:02
 * @LastEditTime : 2021-10-29 05:41:23
 */
#include <iostream>
#include <fstream>
#include <future>
#include <iostream>
#include <thread>
#include <vector>
using namespace std;
const char* words[600] = {"ability", "access", "account", "action", "active", "activity", "addition", "address", "advantage", "advertising", "advice", "affect", "alternative", "amount", "analysis", "animal", "answer", "anything", "apartment", "appearance", "application", "area", "army", "article", "association", "attempt", "attention", "audience", "author", "average", "back", "balance", "ball", "bank", "base", "basis", "beautiful", "beginning", "being", "benefit", "beyond", "bird", "birth", "black", "blood", "board", "boat", "body", "book", "boss", "bottom", "boyfriend", "brain", "break", "broad", "brown", "brush", "budget", "building", "business", "button", "call", "camera", "capital", "card", "care", "career", "case", "cash", "category", "cause", "cell", "challenge", "chance", "change", "charge", "check", "chemistry", "chicken", "child", "choice", "cigarette", "city", "class", "classic", "click", "coast", "cold", "combination", "comfortable", "commercial", "common", "community", "company", "competition", "complex", "computer", "concept", "concern", "condition", "contact", "context", "control", "cook", "cost", "country", "county", "couple", "course", "cover", "craft", "creative", "credit", "culture", "current", "customer", "cycle", "damage", "dance", "data", "date", "deal", "dealer", "death", "debate", "decision", "deep", "definition", "demand", "department", "depth", "design", "desire", "development", "difference", "direction", "discipline", "discount", "discussion", "disease", "disk", "display", "distance", "drive", "driver", "earth", "economics", "economy", "education", "effect", "effective", "effort", "energy", "environment", "equipment", "estate", "event", "exam", "example", "exchange", "excuse", "exercise", "exit", "experience", "expression", "face", "fact", "fail", "failure", "fall", "familiar", "family", "feature", "feel", "feeling", "field", "figure", "file", "film", "final", "finding", "finish", "fire", "fish", "fishing", "flight", "flow", "focus", "following", "food", "foot", "force", "form", "foundation", "frame", "freedom", "friend", "front", "function", "future", "gain", "game", "garden", "general", "gift", "give", "glad", "goal", "good", "government", "grandmother", "great", "green", "ground", "group", "growth", "guard", "guide", "half", "hand", "handle", "head", "health", "heart", "heat", "heavy", "hello", "help", "high", "history", "hold", "home", "hope", "house", "housing", "human", "idea", "image", "impact", "importance", "income", "increase", "independent", "individual", "industry", "inflation", "influence", "information", "inside", "instance", "insurance", "interest", "internet", "investment", "issue", "item", "junior", "keep", "kind", "knowledge", "lack", "lake", "language", "lead", "leading", "leave", "length", "lesson", "level", "library", "life", "lift", "light", "line", "link", "list", "listen", "literature", "living", "local", "location", "long", "look", "love", "machine", "magazine", "main", "major", "make", "management", "many", "market", "marketing", "marriage", "material", "math", "matter", "maybe", "meaning", "meat", "media", "medicine", "medium", "meet", "member", "message", "metal", "method", "middle", "might", "mind", "minute", "model", "moment", "money", "month", "mood", "morning", "most", "mouse", "move", "movie", "music", "name", "nation", "national", "natural", "nature", "necessary", "negative", "network", "news", "newspaper", "night", "normal", "north", "note", "nothing", "notice", "number", "object", "objective", "offer", "office", "officer", "official", "opinion", "opportunity", "order", "original", "other", "outside", "oven", "page", "paint", "painting", "pair", "paper", "part", "particular", "past", "payment", "people", "performance", "period", "person", "personal", "perspective", "phase", "philosophy", "phone", "photo", "physical", "physics", "pick", "picture", "piece", "place", "plan", "plant", "plastic", "play", "player", "point", "policy", "politics", "population", "position", "positive", "possible", "post", "potential", "power", "practice", "present", "president", "press", "pressure", "price", "primary", "private", "problem", "process", "produce", "product", "profit", "program", "property", "public", "purchase", "purpose", "quality", "question", "radio", "rain", "range", "rate", "reach", "read", "reading", "reality", "reason", "recipe", "record", "reference", "register", "regular", "release", "remove", "rent", "report", "research", "reserve", "rest", "result", "return", "review", "rich", "ride", "rise", "risk", "road", "rock", "role", "room", "rule", "safe", "safety", "salt", "save", "savings", "scale", "scene", "school", "science", "screen", "search", "second", "secret", "section", "security", "self", "sell", "sense", "series", "serve", "service", "shape", "share", "shoot", "shopping", "shot", "show", "side", "sign", "simple", "single", "site", "situation", "size", "skill", "society", "software", "soil", "sound", "soup", "source", "space", "special", "specific", "speed", "spend", "sport", "spot", "spread", "spring", "square", "staff", "stage", "stand", "standard", "star", "start", "state", "statement", "stay", "step", "stick", "still", "stock", "stop", "store", "story", "strategy", "stress", "structure", "student", "studio", "study", "style", "subject", "success", "sugar", "summer", "support", "system", "table", "talk", "target", "task", "taste", "teach", "teacher", "teaching", "technology", "television", "tell", "temperature", "term", "test", "text", "thanks", "theme", "theory", "thing", "thought", "time", "title", "today", "tonight", "tool", "topic", "touch", "tough", "track", "trade", "training", "travel", "trouble", "truth", "turn", "type", "unique", "unit", "university", "user", "valuable", "value", "variety", "video", "view", "visit", "visual", "voice", "wait", "walk", "wall", "watch", "water", "wealth", "weather", "week", "western", "while", "white", "whole", "will", "wind", "wing", "woman", "wood", "word", "work", "working", "world", "worry", "worth", "writing", "year", "young"};

struct pack{
int a;
int b;
int c;
int d;
pack(int a, int b, int c, int d): a(a), b(b), c(c), d(d) {}
};

int wanted = 681972539;
int wanted_upper = wanted + 12;

int java_hash(int a, int b, int c, int d) {
    int h = 0;

    const char* p = words[a];
    while(*p)
        h = h * 31 + *(p++);
    h = h * 31 + 32;
    p = words[b];
    while(*p)
        h = h * 31 + *(p++);
    h = h * 31 + 32;
    p = words[c];
    while(*p)
        h = h * 31 + *(p++);
    h = h * 31 + 32;
    p = words[d];
    while(*p)
        h = h * 31 + *(p++);
    return h;
}

vector<pack> get_hash(int times)
{
    vector<pack> res;
    int tmp;
    times *= 20;
    for(int a = times; a < times + 20; ++a)
        for(int b = 0; b < 600; ++b)
            for(int c = 0; c < 600; ++c)
                for(int d = 0; d < 600; ++d)
                {
                    tmp = java_hash(a,b,c,d) * 31;
                    if(tmp >= wanted && tmp <= wanted_upper)
                    {
                        res.push_back(pack(a,b,c,d));
                        cout << tmp << ": " << words[a] << " " << words[b] << " " << words[c] << " " << words[d] << endl;
                    }
                }
    return res;
}

int main(){
    cout << "Begin..." << endl;
    vector<std::future<vector<pack>>> futures;
    vector<pack> results;

    for (int i = 0; i < 30; ++i)
    {
        cout << ".";
        futures.push_back(std::async(std::launch::async, get_hash, i));
    }

    cout << "\nWaiting..." << endl;
    for(int i = 0; i < 30; ++i)
    {
        cout << ".";
        vector<pack> part = futures[i].get();
        results.insert(results.end(), part.begin(), part.end());
    }
    cout << "\nFinished." << endl;
    ofstream fout("ans.txt");
    for (auto &k: results)
        fout << words[k.a] << " " << words[k.b] << " " << words[k.c] << " " << words[k.d] << endl;
    return 0;
}
