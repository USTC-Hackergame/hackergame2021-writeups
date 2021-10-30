#include <QApplication>
#include "mainwidget.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    // Create a widget
    auto *w = new MainWidget;

    // Display
    w->show();

    // Event loop
    return a.exec();
}
