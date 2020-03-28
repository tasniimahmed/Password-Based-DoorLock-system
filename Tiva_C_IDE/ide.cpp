#include "ide.h"
#include "notifier.h"
#include <QDebug>

extern Notifier notify;
extern map<string,string> mapToRaye2;

IDE::IDE(QGuiApplication* mainApp,int argc, char *argv[],QObject* parent) : QObject(parent)
{
    interfaceEngine = new QQmlApplicationEngine;
    app = new QGuiApplication(argc,argv);
    app = mainApp;
    const QUrl urlInterface(QStringLiteral("qrc:/main_interface.qml"));
    connect(interfaceEngine, &QQmlApplicationEngine::objectCreated,
                     app, [urlInterface](QObject *obj, const QUrl &objUrl) {
        if (!obj && urlInterface == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<MapReader>("QMap",1,0,"MapQML");

    interfaceEngine->load(urlInterface);

    connect(&notify,SIGNAL(qmlGenerated()),this,SLOT(loadEditor()));
}

void IDE::loadEditor()
{
    editorEngine = new QQmlApplicationEngine;
    this->controller = new Controller(editorEngine);
    controller->generate(mapToRaye2);
    const QUrl urlEditor(QStringLiteral("qrc:/main_editor.qml"));
    editorEngine = new QQmlApplicationEngine;
    connect(editorEngine, &QQmlApplicationEngine::objectCreated,
                     app, [urlEditor](QObject *obj, const QUrl &objUrl) {
        if (!obj && urlEditor == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    editorEngine->load(urlEditor);
}
