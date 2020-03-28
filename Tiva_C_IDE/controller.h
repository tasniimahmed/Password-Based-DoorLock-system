#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <bits/stdc++.h>
#include <QObject>
#include <QModelIndex>
#include <QFileSystemModel>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>
#include <QFile>
#include <QMap>
#include <QString>
#include <QIODevice>
#include <QByteArray>
#include <QTextStream>
#include "abstractgenerator.h"
#include "gpio_generator.h"
#include "generatedcode.h"
#include "adapterpattern.h"
#include "uart_generator.h"

using namespace std;

class Controller : public QObject
{
    Q_OBJECT
private:
    QQmlApplicationEngine* engine;
    QFileSystemModel* FileSystem;
    void initFileSystem();
    void RegisterQML();

    QFile file;
    QString textFileContent;
    vector<string> supportedExtentions;
    void initExtentions();
    bool readFile(QString);
    bool setFilePath(QString path);

    vector<AdapterPattern*> generatorsAdapter;
    vector<GeneratedCode> generatorsCodes;
    QString mainFile;
    map<string,string> tivaC;
    void initGenerators();
    void initTiva();
    void generateMainFunction();


public:
    Controller(QQmlApplicationEngine* Engine,QObject* parent=nullptr);
    Q_INVOKABLE QString getFileContent();
    Q_INVOKABLE QString getFileName();
    Q_INVOKABLE bool fileSelected(QModelIndex index);
    Q_INVOKABLE void setRootPathFileSystemPath(QString path);
    Q_INVOKABLE bool saveFile(QString path , QString content);
    void generate(map<string, string>);
signals:
    void addTab(QString titleTab, QString textContent );

};

#endif // CONTROLLER_H
