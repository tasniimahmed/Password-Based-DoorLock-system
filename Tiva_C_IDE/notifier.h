#ifndef NOTIFIER_H
#define NOTIFIER_H

#include <QObject>

class Notifier : public QObject
{
   Q_OBJECT
public:
    Notifier(QObject *parent = nullptr);

signals:
    void qmlGenerated();
public slots:
    void callEditor();

};

#endif // NOTIFIER_H
