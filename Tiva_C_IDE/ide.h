#ifndef IDE_H
#define IDE_H

#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QObject>
#include <QMap>
#include "qqml.h"
#include "mapreader.h"
#include "controller.h"


class IDE : public QObject
{
    Q_OBJECT
public:
    explicit IDE(QGuiApplication*,int argc, char *argv[],QObject *parent = nullptr);

private:
    QQmlApplicationEngine* interfaceEngine;
    QQmlApplicationEngine* editorEngine;
    QGuiApplication* app;
    Controller* controller;
private slots:
    void loadEditor();

};

#endif // IDE_H
