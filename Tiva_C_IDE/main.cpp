#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QVariantMap>
#include <QQuickView>
#include <QVariant>
#include <QMetaObject>
#include <QObject>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

//    QQuickView view(QUrl::fromLocalFile("main.qml"));
//    QVariantMap map;
//    map.insert("PA2","NULL");
//    map.insert("PB2","NULL");
//    QMetaObject::invokeMethod(view.rootObject(),"readValues",Q_ARG(QVariant, QVariant::fromValue(map)));



    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
