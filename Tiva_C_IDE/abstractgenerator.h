#ifndef ABSTRACTGENERATOR_H
#define ABSTRACTGENERATOR_H

#include <bits/stdc++.h>
using namespace std;
#include "generatedcode.h"


class AbstractGenerator
{
protected:
    GeneratedCode generatedCode;
    string name;
    void collectConfigCode();

public:
    //
    AbstractGenerator();
    string getName() {return this->name;}
    virtual GeneratedCode generate(map<string,string> tivaC_Data) = 0;
};

#endif // ABSTRACTGENERATOR_H
