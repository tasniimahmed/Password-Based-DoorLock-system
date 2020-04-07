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
        controller->generate(mapToRaye2);
        const QUrl urlEditor(QStringLiteral("qrc:/main_editor.qml"));
        editorEngine->load(urlEditor);
    }
    else if(editorEngine != nullptr)
    {
        for(int i = 0; i < editorEngine->rootObjects().size();i++)
        {
            QObject* object = editorEngine->rootObjects()[i];
            QQuickWindow* runningEditor = qobject_cast<QQuickWindow*>(object);
            runningEditor->close();
        }
        delete controller;
        controller = new Controller(editorEngine);
        controller->generate(mapToRaye2);
        const QUrl urlEditor(QStringLiteral("qrc:/main_editor.qml"));
        editorEngine->load(urlEditor);
    }
}
