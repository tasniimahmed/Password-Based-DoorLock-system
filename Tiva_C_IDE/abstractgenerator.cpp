#include "abstractgenerator.h"

void AbstractGenerator::collectConfigCode()
{
    // clear the string for multiple use times
    this->generatedCode.configCode.clear();
    for(int i =0 ; i< this->generatedCode.code.size(); i++)
    {
        // tab + code + new line
        this->generatedCode.configCode +=  "    " + this->generatedCode.code[i] + "\n";
    }
}

AbstractGenerator::AbstractGenerator()
{

}
