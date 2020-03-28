#include "mapreader.h"
#include <QDebug>
#include "notifier.h"

extern map<string,string> mapToRaye2;
extern Notifier notify;

MapReader::MapReader(QObject *parent) : QObject(parent)
{
    pinmodes["PA2"] = "NULL";
    pinmodes["PA3"] = "NULL";
    pinmodes["PA4"] = "NULL";
    pinmodes["PA5"] = "NULL";
    pinmodes["PA6"] = "NULL";
    pinmodes["PA7"] = "NULL";

    pinmodes["PB0"] = "NULL";
    pinmodes["PB1"] = "NULL";
    pinmodes["PB2"] = "NULL";
    pinmodes["PB3"] = "NULL";
    pinmodes["PB4"] = "NULL";
    pinmodes["PB5"] = "NULL";
    pinmodes["PB6"] = "NULL";
    pinmodes["PB7"] = "NULL";

    pinmodes["PC4"] = "NULL";
    pinmodes["PC5"] = "NULL";
    pinmodes["PC6"] = "NULL";
    pinmodes["PC7"] = "NULL";

    pinmodes["PD0"] = "NULL";
    pinmodes["PD1"] = "NULL";
    pinmodes["PD2"] = "NULL";
    pinmodes["PD3"] = "NULL";
    pinmodes["PD4"] = "NULL";
    pinmodes["PD6"] = "NULL";
    pinmodes["PD7"] = "NULL";

    pinmodes["PE0"] = "NULL";
    pinmodes["PE1"] = "NULL";
    pinmodes["PE2"] = "NULL";
    pinmodes["PE3"] = "NULL";
    pinmodes["PE4"] = "NULL";
    pinmodes["PE5"] = "NULL";

    pinmodes["PF0"] = "NULL";
    pinmodes["PF1"] = "NULL";
    pinmodes["PF2"] = "NULL";
    pinmodes["PF3"] = "NULL";
    pinmodes["PF4"] = "NULL";

    pinmodes["UART_BoudRate"] = "NULL";
    pinmodes["UART_FIFO"] = "NULL";
    pinmodes["UART_HighSpeed"] = "NULL";
    pinmodes["UART_Parity"] = "NULL";
    pinmodes["UART_StopBits"] = "NULL";

    connect(this,SIGNAL(configrationGenerated()),this,SLOT(copyMap()));
    connect(this,SIGNAL(readyToLoadEditor()),&notify,SLOT(callEditor()));
}

QVariantMap MapReader::readModes()
{
    return pinmodes;
}

string MapReader::qstringToString(QString str)
{
    return str.toUtf8().constData();
}

void MapReader::setModes(QVariantMap qmlMap)
{
    pinmodes["PA2"] = qmlMap["PA2"];
    pinmodes["PA3"] = qmlMap["PA3"];
    pinmodes["PA4"] = qmlMap["PA4"];
    pinmodes["PA5"] = qmlMap["PA5"];
    pinmodes["PA6"] = qmlMap["PA6"];
    pinmodes["PA7"] = qmlMap["PA7"];

    pinmodes["PB0"] = qmlMap["PB0"];
    pinmodes["PB1"] = qmlMap["PB1"];
    pinmodes["PB2"] = qmlMap["PB2"];
    pinmodes["PB3"] = qmlMap["PB3"];
    pinmodes["PB4"] = qmlMap["PB4"];
    pinmodes["PB5"] = qmlMap["PB5"];
    pinmodes["PB6"] = qmlMap["PB6"];
    pinmodes["PB7"] = qmlMap["PB7"];

    pinmodes["PC4"] = qmlMap["PC4"];
    pinmodes["PC5"] = qmlMap["PC5"];
    pinmodes["PC6"] = qmlMap["PC6"];
    pinmodes["PC7"] = qmlMap["PC7"];

    pinmodes["PD0"] = qmlMap["PD0"];
    pinmodes["PD1"] = qmlMap["PD1"];
    pinmodes["PD2"] = qmlMap["PD2"];
    pinmodes["PD3"] = qmlMap["PD3"];
    pinmodes["PD4"] = qmlMap["PD4"];
    pinmodes["PD6"] = qmlMap["PD6"];
    pinmodes["PD7"] = qmlMap["PD7"];

    pinmodes["PE0"] = qmlMap["PE0"];
    pinmodes["PE1"] = qmlMap["PE0"];
    pinmodes["PE2"] = qmlMap["PE0"];
    pinmodes["PE3"] = qmlMap["PE0"];
    pinmodes["PE4"] = qmlMap["PE0"];
    pinmodes["PE5"] = qmlMap["PE0"];

    pinmodes["PF0"] = qmlMap["PF0"];
    pinmodes["PF1"] = qmlMap["PF1"];
    pinmodes["PF2"] = qmlMap["PF2"];
    pinmodes["PF3"] = qmlMap["PF3"];
    pinmodes["PF4"] = qmlMap["PF4"];

    pinmodes["UART_BoudRate"] = qmlMap["UART_BoudRate"];
    pinmodes["UART_FIFO"] = qmlMap["UART_FIFO"];
    pinmodes["UART_HighSpeed"] = qmlMap["UART_HighSpeed"];
    pinmodes["UART_Parity"] = qmlMap["UART_Parity"];
    pinmodes["UART_StopBits"] = qmlMap["UART_StopBits"];
}

void MapReader::copyMap()
{
    QVariant map(pinmodes);

    mapToRaye2["GPIO_A2"] = qstringToString(map.toMap()["PA2"].toString());
    mapToRaye2["GPIO_A3"] = qstringToString(map.toMap()["PA3"].toString());
    mapToRaye2["GPIO_A4"] = qstringToString(map.toMap()["PA4"].toString());
    mapToRaye2["GPIO_A5"] = qstringToString(map.toMap()["PA5"].toString());
    mapToRaye2["GPIO_A6"] = qstringToString(map.toMap()["PA6"].toString());
    mapToRaye2["GPIO_A7"] = qstringToString(map.toMap()["PA7"].toString());

    mapToRaye2["GPIO_B0"] = qstringToString(map.toMap()["PB0"].toString());
    mapToRaye2["GPIO_B1"] = qstringToString(map.toMap()["PB1"].toString());
    mapToRaye2["GPIO_B2"] = qstringToString(map.toMap()["PB2"].toString());
    mapToRaye2["GPIO_B3"] = qstringToString(map.toMap()["PB3"].toString());
    mapToRaye2["GPIO_B4"] = qstringToString(map.toMap()["PB4"].toString());
    mapToRaye2["GPIO_B5"] = qstringToString(map.toMap()["PB5"].toString());
    mapToRaye2["GPIO_B6"] = qstringToString(map.toMap()["PB6"].toString());
    mapToRaye2["GPIO_B7"] = qstringToString(map.toMap()["PB7"].toString());

    mapToRaye2["GPIO_C4"] = qstringToString(map.toMap()["PC4"].toString());
    mapToRaye2["GPIO_C5"] = qstringToString(map.toMap()["PC5"].toString());
    mapToRaye2["GPIO_C6"] = qstringToString(map.toMap()["PC6"].toString());
    mapToRaye2["GPIO_C7"] = qstringToString(map.toMap()["PC7"].toString());

    mapToRaye2["GPIO_D0"] = qstringToString(map.toMap()["PD0"].toString());
    mapToRaye2["GPIO_D1"] = qstringToString(map.toMap()["PD1"].toString());
    mapToRaye2["GPIO_D2"] = qstringToString(map.toMap()["PD2"].toString());
    mapToRaye2["GPIO_D3"] = qstringToString(map.toMap()["PD3"].toString());
    mapToRaye2["GPIO_D4"] = qstringToString(map.toMap()["PD4"].toString());
    mapToRaye2["GPIO_D6"] = qstringToString(map.toMap()["PD6"].toString());
    mapToRaye2["GPIO_D7"] = qstringToString(map.toMap()["PD7"].toString());

    mapToRaye2["GPIO_E0"] = qstringToString(map.toMap()["PE0"].toString());
    mapToRaye2["GPIO_E1"] = qstringToString(map.toMap()["PE0"].toString());
    mapToRaye2["GPIO_E2"] = qstringToString(map.toMap()["PE0"].toString());
    mapToRaye2["GPIO_E3"] = qstringToString(map.toMap()["PE0"].toString());
    mapToRaye2["GPIO_E4"] = qstringToString(map.toMap()["PE0"].toString());
    mapToRaye2["GPIO_E5"] = qstringToString(map.toMap()["PE0"].toString());

    mapToRaye2["GPIO_F0"] = qstringToString(map.toMap()["PF0"].toString());
    mapToRaye2["GPIO_F1"] = qstringToString(map.toMap()["PF1"].toString());
    mapToRaye2["GPIO_F2"] = qstringToString(map.toMap()["PF2"].toString());
    mapToRaye2["GPIO_F3"] = qstringToString(map.toMap()["PF3"].toString());
    mapToRaye2["GPIO_F4"] = qstringToString(map.toMap()["PF4"].toString());

    mapToRaye2["UART_BoudRate"] = qstringToString(map.toMap()["UART_BoudRate"].toString());
    mapToRaye2["UART_FIFO"] = qstringToString(map.toMap()["UART_FIFO"].toString()) == "Disable" ? "FIFO_DISABLE" : "FIFO_ENABLE";
    mapToRaye2["UART_HighSpeed"] = qstringToString(map.toMap()["UART_HighSpeed"].toString()) == "Disable" ? "HIGHSPEED_DISABLE" : "HIGHSPEED_ENABLE";
    mapToRaye2["UART_Parity"] = qstringToString(map.toMap()["UART_Parity"].toString()) == "Disable" ? "PARITY_DISABLE" : "PARITY_ENABLE";
    mapToRaye2["UART_StopBits"] = "UART_STOPBITS_" + qstringToString(map.toMap()["UART_StopBits"].toString());

//    QMapIterator<QString,QString> i(mapToRaye2);
//    while (i.hasNext())
//    {
//        i.next();
//        qDebug() << i.key() << i.value();
//    }
    emit readyToLoadEditor();
}
