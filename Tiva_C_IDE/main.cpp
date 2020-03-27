#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMap>
#include "qqml.h"
#include "mapreader.h"

QMap<QString,QString> mapToRaye2;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<MapReader>("QMap",1,0,"MapQML");

    engine.load(url);


    return app.exec();
}
