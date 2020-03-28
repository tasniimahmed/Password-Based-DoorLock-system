#ifndef ADAPTERPATTERN_H
#define ADAPTERPATTERN_H
#include <bits/stdc++.h>
using namespace std;
#include "abstractgenerator.h"

class AdapterPattern
{
private:
    AbstractGenerator* generator;
    map<string,string> generatorInput;
    void Adapt(map<string,string>);
public:
    AdapterPattern(AbstractGenerator* );
    GeneratedCode generateCode(map<string,string> ControllerOutput);
};

#endif // ADAPTERPATTERN_H
