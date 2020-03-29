#include "ide.h"
#include "notifier.h"
#include <QQuickWindow>

extern Notifier notify;
extern map<string,string> mapToRaye2;

IDE::IDE(QGuiApplication* mainApp,int argc, char *argv[],QObject* parent) : QObject(parent)
{
    interfaceEngine = new QQmlApplicationEngine;
    app = new QGuiApplication(argc,argv);
    app = mainApp;
    const QUrl urlInterface(QStringLiteral("qrc:/main_interface.qml"));
//    connect(interfaceEngine, &QQmlApplicationEngine::objectCreated,
//                     app, [urlInterface](QObject *obj, const QUrl &objUrl) {
//        if (!obj && urlInterface == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);

    qmlRegisterType<MapReader>("QMap",1,0,"MapQML");

    interfaceEngine->load(urlInterface);

    connect(&notify,SIGNAL(qmlGenerated()),this,SLOT(loadEditor()));
}

void IDE::loadEditor()
{
    if(editorEngine == nullptr)
    {
        editorEngine = new QQmlApplicationEngine;
        controller = new Controller(editorEngine);
        qDebug() << "entered";
        controller->generate(mapToRaye2);
        const QUrl urlEditor(QStringLiteral("qrc:/main_editor.qml"));
        editorEngine->load(urlEditor);
    }
    else if(editorEngine != nullptr)
    {
        QObject* pRootObject = editorEngine->rootObjects().first();
        QQuickWindow* pMainWindow = qobject_cast<QQuickWindow*>(pRootObject);
        pMainWindow->close();
        delete controller;
        controller = new Controller(editorEngine);
        controller->generate(mapToRaye2);
        const QUrl urlEditor(QStringLiteral("qrc:/main_editor.qml"));
        editorEngine->load(urlEditor);
    }
}
