package cn.edu.ustc.lug.hack.mnemonic_phrase;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.TimeUnit;

public record Phrase(String text, Instant time, String user)
{
    private static final int EQUALS_DURATION_MILLIS = 20;

    public static Phrase create(Set<String> mnemonics, String text, Token token)
    {
        var user = Objects.requireNonNull(token).user();
        var parts = List.of(Objects.requireNonNull(text).split(" ", 4));
        if (parts.size() != 4 || !Objects.requireNonNull(mnemonics).containsAll(parts))
        {
            throw new IllegalArgumentException("Invalid mnemonics phrase: " + text);
        }
        return new Phrase(text, Instant.now().truncatedTo(ChronoUnit.SECONDS), user);
    }

    @Override
    public boolean equals(Object o)
    {
        if (o instanceof Phrase that)
        {
            try
            {
                TimeUnit.MILLISECONDS.sleep(EQUALS_DURATION_MILLIS); // TODO: remove it since it is for debugging
            }
            catch (InterruptedException e)
            {
                throw new RuntimeException(e);
            }
            return that.text.equals(this.text) && that.time.equals(this.time) && that.user.equals(this.user);
        }
        return false;
    }

    @Override
    public int hashCode()
    {
        return Objects.hash(this.text, this.time, this.user);
    }
}
