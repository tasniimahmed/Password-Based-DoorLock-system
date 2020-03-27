#include "mapreader.h"

extern QMap<QString,QString> mapToRaye2;

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

    connect(this,SIGNAL(configrationGenerated()),this,SLOT(copyMap()));
}

QVariantMap MapReader::readModes()
{
    return pinmodes;
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
}

void MapReader::copyMap()
{
    QVariant map(pinmodes);
    mapToRaye2["PA2"] = map.toMap()["PA2"].toString();
    mapToRaye2["PA3"] = map.toMap()["PA3"].toString();
    mapToRaye2["PA4"] = map.toMap()["PA4"].toString();
    mapToRaye2["PA5"] = map.toMap()["PA5"].toString();
    mapToRaye2["PA6"] = map.toMap()["PA6"].toString();
    mapToRaye2["PA7"] = map.toMap()["PA7"].toString();

    mapToRaye2["PB0"] = map.toMap()["PB0"].toString();
    mapToRaye2["PB1"] = map.toMap()["PB1"].toString();
    mapToRaye2["PB2"] = map.toMap()["PB2"].toString();
    mapToRaye2["PB3"] = map.toMap()["PB3"].toString();
    mapToRaye2["PB4"] = map.toMap()["PB4"].toString();
    mapToRaye2["PB5"] = map.toMap()["PB5"].toString();
    mapToRaye2["PB6"] = map.toMap()["PB6"].toString();
    mapToRaye2["PB7"] = map.toMap()["PB7"].toString();

    mapToRaye2["PC4"] = map.toMap()["PC4"].toString();
    mapToRaye2["PC5"] = map.toMap()["PC5"].toString();
    mapToRaye2["PC6"] = map.toMap()["PC6"].toString();
    mapToRaye2["PC7"] = map.toMap()["PC7"].toString();

    mapToRaye2["PD0"] = map.toMap()["PD0"].toString();
    mapToRaye2["PD1"] = map.toMap()["PD1"].toString();
    mapToRaye2["PD2"] = map.toMap()["PD2"].toString();
    mapToRaye2["PD3"] = map.toMap()["PD3"].toString();
    mapToRaye2["PD4"] = map.toMap()["PD4"].toString();
    mapToRaye2["PD6"] = map.toMap()["PD6"].toString();
    mapToRaye2["PD7"] = map.toMap()["PD7"].toString();

    mapToRaye2["PE0"] = map.toMap()["PE0"].toString();
    mapToRaye2["PE1"] = map.toMap()["PE0"].toString();
    mapToRaye2["PE2"] = map.toMap()["PE0"].toString();
    mapToRaye2["PE3"] = map.toMap()["PE0"].toString();
    mapToRaye2["PE4"] = map.toMap()["PE0"].toString();
    mapToRaye2["PE5"] = map.toMap()["PE0"].toString();

    mapToRaye2["PF0"] = map.toMap()["PF0"].toString();
    mapToRaye2["PF1"] = map.toMap()["PF1"].toString();
    mapToRaye2["PF2"] = map.toMap()["PF2"].toString();
    mapToRaye2["PF3"] = map.toMap()["PF3"].toString();
    mapToRaye2["PF4"] = map.toMap()["PF4"].toString();
}
