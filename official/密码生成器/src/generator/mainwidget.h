#ifndef MAINWIDGET_H
#define MAINWIDGET_H

#include <QWidget>
#include <QPushButton>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QCheckBox>
#include <QLineEdit>
#include <QSpinBox>
#include <QDebug>
#include <QClipboard>
#include <QGuiApplication>
#include <QThread>
#include <QTime>
#include <QMessageBox>

#include "generator.h"



class MainWidget : public QWidget
{
    Q_OBJECT
public:
    explicit MainWidget(QWidget *parent = nullptr);
    void changeStatus(bool status);
signals:
private:
    QLineEdit *passwordEdit;

    QCheckBox *upperBox;
    QCheckBox *lowerBox;
    QCheckBox *numericBox;
    QCheckBox *speicalBox;
    QSpinBox *lengthBox;

    QPushButton *generateButton;
    QPushButton *copyButton;

    Generator *generator;
    QClipboard *clipboard;
};

#endif // MAINWIDGET_H
