#include "notifier.h"

Notifier::Notifier(QObject *parent) : QObject(parent)
{

}

void Notifier::callEditor()
{
    emit qmlGenerated();
}
