#ifndef MAPREADER_H
#define MAPREADER_H

#include <QObject>
#include <QVariantMap>
#include <string>
using namespace std;

class MapReader : public QObject
{
    Q_OBJECT
public:
    explicit MapReader(QObject *parent = nullptr);
    Q_PROPERTY(QVariantMap PinModes READ readModes WRITE setModes)
    Q_INVOKABLE void setModes(QVariantMap);
    QVariantMap readModes();

private:
    QVariantMap pinmodes;
    string qstringToString(QString);
signals:
    void configrationGenerated();
    Q_INVOKABLE void readyToLoadEditor();

private slots:
    void copyMap();

};

#endif // MAPREADER_H
