#include "gpio_generator.h"
#define PORTS 6
// GPIO_A1 : Output
// GPIO_B2 : Input
GPIO_Generator::GPIO_Generator() : AbstractGenerator()
{
    this->name = "GPIO";
    // map to check that we need using port generation instead of pin generation
    this->flagPorts["A"] = false;
    this->flagPorts["B"] = false;
    this->flagPorts["C"] = false;
    this->flagPorts["D"] = false;
    this->flagPorts["E"] = false;
    this->flagPorts["F"] = false;

    // to check whether this is an existed port or not
    this->foundPorts["A"] = false;
    this->foundPorts["B"] = false;
    this->foundPorts["C"] = false;
    this->foundPorts["D"] = false;
    this->foundPorts["E"] = false;
    this->foundPorts["F"] = false;

    // for base address for generation
    this->BasePort["A"] = "GPIO_PORTA_APB_BASE";
    this->BasePort["B"] = "GPIO_PORTB_APB_BASE";
    this->BasePort["C"] = "GPIO_PORTC_APB_BASE";
    this->BasePort["D"] = "GPIO_PORTD_APB_BASE";
    this->BasePort["E"] = "GPIO_PORTE_APB_BASE";
    this->BasePort["F"] = "GPIO_PORTF_APB_BASE";

    this->generatedCode.FunctionName = "init_GPIO()";
    this->generatedCode.includes = "#include \"GPIO.h\" " ;
    this->generatedCode.dot_h_Path += "GPIO.h";
    this->generatedCode.dot_c_Path += "GPIO.c";

}

void GPIO_Generator::generatePin(string port , int pinNum, string state)
{
    if(state != "Output" && state != "Input")
        return;

    this->generatedCode.code.push_back("// ********* GPIO Initialization " + port + to_string(pinNum) + "  ***********");
    string pinHandler = "_port" + port + "pin" + to_string(pinNum);
    string init = "GPIO_HandlingPin " + pinHandler + ";" ;                      this->generatedCode.code.push_back(init);
    string portBase = pinHandler + ".PortBase = " + this->BasePort[port]+";";   this->generatedCode.code.push_back(portBase);
    string digital = pinHandler + ".DigitalEnable = 1;";                        this->generatedCode.code.push_back(digital);
    string State = pinHandler + ".Direction = " + state+";";                    this->generatedCode.code.push_back(State);
    string PinNumber = pinHandler + ".PinNumber = " +to_string(pinNum) +";";    this->generatedCode.code.push_back(PinNumber);
    string initialPin = "GPIO_InitialPin(&" + pinHandler + ");";                this->generatedCode.code.push_back(initialPin);
    this->generatedCode.code.push_back("\n");
    this->generatedCode.code.push_back("\n");
}

void GPIO_Generator::generatePort(string port,string state)
{
    if(state != "Output" && state != "Input")
        return;

    this->generatedCode.code.push_back("// ********* GPIO Initialization Port " + port + " *********" );
    string portHandler = "_port" + port ;
    string init = "GPIO_HandlingPort " + portHandler + ";" ;                     this->generatedCode.code.push_back(init);
    string portBase = portHandler + ".PortBase = " + this->BasePort[port]+";";   this->generatedCode.code.push_back(portBase);
    string digital = portHandler + ".DigitalEnable = 1;";                        this->generatedCode.code.push_back(digital);
    string State = portHandler + ".Direction = " + state+";";                    this->generatedCode.code.push_back(State);
    string initialPin = "GPIO_InitialPin(&" + portHandler + ");";                this->generatedCode.code.push_back(initialPin);
    this->generatedCode.code.push_back("\n");
    this->generatedCode.code.push_back("\n");
}

bool GPIO_Generator::checkPort(string port, map<string, string> ports)
{
    string portStatus;
    bool foundFirstTime = false;
    // for counting the pins in the port to make sure that all of them exist
    int count = 0;
    auto i = ports.begin();
    for(; i != ports.end(); i++)
    {
        // select only the wanted cheking port
        int pos = i->first.find("_"+port);
        if(pos == string::npos) continue;
        count++;
        // check for finding the port @ first time , then store that status
        if( ! foundFirstTime)
        {
            // to not entering again
            foundFirstTime = true;
            // for storing the status that we will compare it always (input / output / undefined )
            portStatus = i->second;
            continue;
        }
        // if there is one pin is different so this is not a port
        if (i->second != portStatus)
            return false;
    }
    cout << "port "<< port << "= " << count << endl;
    if(count != 8)
        return false;
    return true;
}

void GPIO_Generator::checkFoundPort(map<string, string> ports)
{
    // loop over all ports
    for(auto j = this->foundPorts.begin(); j!= this->foundPorts.end(); j++)
    {
        // for each port loop over all tiva c data
        for(auto i = ports.begin(); i!= ports.end(); i++)
        {
            // if you find the GPIO_[PORT_NAME] then set the foundPorts boolean and return , it is exist !
            if(i->first.find("GPIO_"+j->first) != string::npos)
            {
                this->foundPorts[j->first] = true;
                break;
            }
        }
    }
}


GeneratedCode GPIO_Generator::generate(map<string, string> tivaC_Data)
{
    // check if ports are not found
    this->checkFoundPort(tivaC_Data);


    // loop over all ports and check if you will need to generate all port once instead of 8 pins
    for(auto i = this->flagPorts.begin(); i != this->flagPorts.end(); i++)
    {
        // skip the unfounded ports
        if( ! this->foundPorts[i->first] )
            continue;
        i->second = this->checkPort(i->first,tivaC_Data);
        // if port .. call the port generation function and pass to it any of the equaled values of the port (we use 1 but we could use any of them)
        if(i->second)
            this->generatePort(i->first,tivaC_Data["GPIO_"+i->first+"1" ]);
    }

    for(auto i = tivaC_Data.begin(); i!= tivaC_Data.end(); i++)
    {
        string port_pin = i->first;
        // delete the " GPIO_ "
        port_pin.erase(0,5);
        // the remain string will be for example "A2" A=port , 2 = pin
        string port =  port_pin.substr(0,1);
        string pin =   port_pin.substr(1,1);
        // if this port is already generated as Port .. skip it
        if (this->flagPorts[port])
            continue;
        this->generatePin(port,stoi(pin),i->second);
    }
    this->generatedCode.code.push_back("}");
    this->collectConfigCode();
    return this->generatedCode;
}
