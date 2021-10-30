#include "generator.h"
#include <ctime>
#include <random>
#include <functional>
#include <iostream>

Generator::Generator()
{
    status.length = -1;
}

void Generator::set(int length, bool upper, bool lower, bool numeric, bool speical)
{
    status.length = length;
    status.upper = upper;
    status.lower = lower;
    status.numeric = numeric;
    status.speical = speical;
}

QString Generator::generate()
{
    if (status.length <= 0)
    {
        return "错误: 未初始化 status";
    }
    QString alphabet;
    if (status.upper)
    {
        alphabet += this->upper;
    }
    if (status.lower)
    {
        alphabet += this->lower;
    }
    if (status.numeric)
    {
        alphabet += this->numeric;
    }
    if (status.speical)
    {
        alphabet += this->speical;
    }

    auto mtrand = std::bind(std::uniform_real_distribution<float>(0, 1), std::mt19937(time(0)));
    while (true)
    {
        QString password;
        for (auto i = 0; i < status.length; i++)
        {
            auto r1 = mtrand();
            auto r2 = mtrand();
            auto pos = int(r1 * r2 * alphabet.length());
            password += alphabet[pos];
        }
        if (check(password))
        {
            return password;
        }
    }
}

bool Generator::check(const QString &s)
{
    struct status current;
    current.length = s.length();
    for (auto i = 0; i < s.length(); i++)
    {
        auto c = s[i];
        if (c.isUpper())
        {
            current.upper = true;
        }
        else if (c.isLower())
        {
            current.lower = true;
        }
        else if (c.isDigit())
        {
            current.numeric = true;
        }
        else if (speical.contains(c))
        {
            current.speical = true;
        }
    }
    if ((current.length != status.length) ||
        (current.upper != status.upper) ||
        (current.lower != status.lower) ||
        (current.numeric != status.numeric) ||
        (current.speical != status.speical))
    {
        return false;
    }
    return true;
}
