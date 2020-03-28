#include "adapterpattern.h"


AdapterPattern::AdapterPattern(AbstractGenerator* Generator)
{
    this->generator = Generator;
}

GeneratedCode AdapterPattern::generateCode(map<string, string> ControllerOutput)
{
    this->Adapt(ControllerOutput);
    return this->generator->generate(this->generatorInput);
}


void AdapterPattern::Adapt(map<string,string> ControllerOutput)
{
    string name = this->generator->getName();
    if(name == "GPIO" )
    {
        for(auto i = ControllerOutput.begin(); i!= ControllerOutput.end(); i ++)
        {
            string property = i->first;
            int pos = property.find("GPIO");

            // if pos != -1 >>> if you found GPIO then add it to the map of GPIOs
            if(pos != string ::npos)
                this->generatorInput[i->first] = i->second;
        }
    }


    else if (name == "UART")
    {
        for(auto i = ControllerOutput.begin(); i!= ControllerOutput.end(); i ++)
        {
            string property = i->first;
            string mode = i->second;
            int pos1 = property.find("UART");
            int pos2 = mode.find("UART");

            // if pos != -1 >>> if you found GPIO then add it to the map of GPIOs
            if(pos1 != string ::npos || pos2 != string::npos)
                this->generatorInput[i->first] = i->second;
        }

    }
    else
    {
        this->generatorInput = ControllerOutput;
    }
}
