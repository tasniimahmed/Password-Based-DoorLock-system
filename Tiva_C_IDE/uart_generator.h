#ifndef UART_GENERATOR_H
#define UART_GENERATOR_H
#include "generatedcode.h"
#include "abstractgenerator.h"





class UART_Generator : public AbstractGenerator
{
private:
    string RX;
    string TX;
    map<string,string> defaultValues;

    GeneratedCode clearGeneratedCode();
    void initDefaultValues();
public:
    UART_Generator();
    GeneratedCode generate(map<string, string> tivaC_Data) override;
};

#endif // UART_GENERATOR_H
