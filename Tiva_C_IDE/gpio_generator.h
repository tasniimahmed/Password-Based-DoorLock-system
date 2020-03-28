#ifndef GPIO_GENERATOR_H
#define GPIO_GENERATOR_H
#include "abstractgenerator.h"
#include <QString>
#include <string>
using namespace std;

class GPIO_Generator : public AbstractGenerator
{
private:
    map<string,bool> foundPorts;
    map<string,bool> flagPorts;
    map<string,string> BasePort;
    void generatePin(string port ,int pinNum,string state);
    void generatePort(string port,string state);
    bool checkPort(string port, map<string,string> ports);
    void checkFoundPort(map<string,string> ports);
public:
    GPIO_Generator();
    GeneratedCode generate(map<string, string> tivaC_Data) override;
};

#endif // GPIO_GENERATOR_H
