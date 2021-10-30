#include "mainwidget.h"

void delay()
{
    QTime dieTime = QTime::currentTime().addSecs(1);
    while (QTime::currentTime() < dieTime)
        QCoreApplication::processEvents(QEventLoop::AllEvents, 100);
}

void MainWidget::changeStatus(bool status) {
    passwordEdit->setDisabled(status);
    lengthBox->setDisabled(status);
    upperBox->setDisabled(status);
    lowerBox->setDisabled(status);
    numericBox->setDisabled(status);
    speicalBox->setDisabled(status);
    generateButton->setDisabled(status);
    copyButton->setDisabled(status);
}

MainWidget::MainWidget(QWidget *parent)
    : QWidget(parent),
      passwordEdit{new QLineEdit},
      upperBox{new QCheckBox("大写字母")},
      lowerBox{new QCheckBox("小写字母")},
      numericBox{new QCheckBox("数字")},
      speicalBox{new QCheckBox("特殊字符")},
      lengthBox{new QSpinBox},
      generateButton{new QPushButton("生成")},
      copyButton{new QPushButton("复制到剪贴板")},
      generator{new Generator},
      clipboard{QGuiApplication::clipboard()}
{
    passwordEdit = new QLineEdit();
    passwordEdit->setAlignment(Qt::AlignCenter);

    auto *hLayout = new QHBoxLayout;
    hLayout->addWidget(lengthBox);
    lengthBox->setValue(16);
    lengthBox->setMaximum(128);
    lengthBox->setMinimum(4);
    hLayout->addWidget(upperBox);
    upperBox->setChecked(true);
    hLayout->addWidget(lowerBox);
    lowerBox->setChecked(true);
    hLayout->addWidget(numericBox);
    numericBox->setChecked(true);
    hLayout->addWidget(speicalBox);
    speicalBox->setChecked(true);

    auto *vLayout = new QVBoxLayout;
    vLayout->addWidget(generateButton);
    vLayout->addWidget(copyButton);

    clipboard = QGuiApplication::clipboard();

    QObject::connect(generateButton, &QPushButton::clicked, [this](bool)
                     {
                         if (!(upperBox->isChecked() || lowerBox->isChecked() ||
                               numericBox->isChecked() || speicalBox->isChecked()))
                         {
                             QMessageBox::critical(this, "错误", "请选择至少一项作为字母表！");
                             return;
                         }
                         passwordEdit->setText("生成中");
                         changeStatus(true);
                         delay();
                         passwordEdit->setText(generator->generate(
                             lengthBox->value(), upperBox->isChecked(), lowerBox->isChecked(),
                             numericBox->isChecked(), speicalBox->isChecked()));
                         changeStatus(false);
                     });

    QObject::connect(copyButton, &QPushButton::clicked, [this](bool)
                     {
                         auto password = passwordEdit->text();
                         clipboard->setText(password);
                     });

    auto *mainLayout = new QVBoxLayout;

    mainLayout->addWidget(passwordEdit);
    mainLayout->addLayout(hLayout);
    mainLayout->addLayout(vLayout);

    setLayout(mainLayout);
    setWindowTitle("密码生成器");
}
