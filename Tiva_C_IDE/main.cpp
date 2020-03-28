#include <QGuiApplication>
#include "ide.h"
#include "notifier.h"
#include <string>
using namespace std;

Notifier notify;
map<string,string> mapToRaye2;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc,argv);

    IDE ide(&app,argc,argv);

    return app.exec();
}
