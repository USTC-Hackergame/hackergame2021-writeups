#ifndef GENERATOR_H
#define GENERATOR_H

#include <QString>

struct status {
    int length = -1;
    bool upper = false;
    bool lower = false;
    bool numeric = false;
    bool speical = false;
};

class Generator
{
public:
    Generator();
    QString generate();
    bool check(const QString &s);
    void set(int length, bool upper, bool lower, bool numeric, bool speical);
private:
    QString upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    QString lower = "abcdefghijklmnopqrstuvwxyz";
    QString numeric = "1234567890";
    QString speical = "~!@#$%^&*()_+`-=[]\\{}|;':\",./<>?";

    status status;
};

#endif // GENERATOR_H
