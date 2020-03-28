#include "uart_generator.h"

UART_Generator::UART_Generator() : AbstractGenerator()
{
    this->name = "UART";
    this->generatedCode.FunctionName = "UART_Config()";
    this->generatedCode.includes = "#include \"uart.h\" " ;
    this->generatedCode.dot_h_Path += "uart.h";
    this->generatedCode.dot_c_Path += "uart.c";

    this->RX = "GPIO_C4";
    this->TX = "GPIO_C5";
    this->initDefaultValues();
}

GeneratedCode UART_Generator::generate(map<string, string> tivaC_Data)
{
    if(tivaC_Data[this->RX] != "UART_RX" || tivaC_Data[this->TX] != "UART_TX")
    {
        cout << "UART is not Enabled ! :[RX:" << tivaC_Data[this->RX] << ",TX:" << tivaC_Data[this->TX] <<"]" << endl;
        return this->clearGeneratedCode();
    }

    // if there is any element dosn't exist , set it to the default value
    for(auto i =this->defaultValues.begin(); i!= this->defaultValues.end() ; i++)
    {
        // if the key (uart option) dosn't exist in the map ... set the default value
        if(! tivaC_Data.count(i->first))
            tivaC_Data[i->first] = i->second;
    }



    this->generatedCode.code.push_back("// **** UART Initialization ****");
    string uart = "huart";
    this->generatedCode.code.push_back("UART_HandleTypedef "+ uart +";");
    this->generatedCode.code.push_back(uart +".BaudRate = " + tivaC_Data["UART_BaudRate"] + ";");
    this->generatedCode.code.push_back(uart +".FIFO = "  +  tivaC_Data["UART_FIFO"]  + ";");
    this->generatedCode.code.push_back(uart +".HighSpeed = " + tivaC_Data["UART_HighSpeed"]+  ";");
    this->generatedCode.code.push_back(uart +".ParityEnable =" + tivaC_Data["UART_ParityEnable"]+ ";");
    this->generatedCode.code.push_back(uart +".StopBits =" + tivaC_Data["UART_StopBits"]+";");
    this->generatedCode.code.push_back(uart +".WordLength= " + tivaC_Data["UART_WordLength"]+";");
    this->generatedCode.code.push_back(uart +".TransmitEnable = " + tivaC_Data["UART_TransmitEnable"]+ ";");
    this->generatedCode.code.push_back("\n");

    this->generatedCode.code.push_back("}");

    this->collectConfigCode();
    return this->generatedCode;
}



GeneratedCode UART_Generator::clearGeneratedCode()
{
    this->generatedCode.FunctionName ="";
    this->generatedCode.includes = "";
    this->generatedCode.dot_c_Path = "";
    this->generatedCode.dot_h_Path = "";
    this->generatedCode.code.clear();

    return this->generatedCode;
}

void UART_Generator::initDefaultValues()
{
    this->defaultValues["UART_BaudRate"] = "9600";
    this->defaultValues["UART_FIFO"] = "FIFO_ENABLE";
    this->defaultValues["UART_HighSpeed"] = "HIGH_SPEED_DISABLE";
    this->defaultValues["UART_ParityEnable"] = "PARITY_DISABLE";
    this->defaultValues["UART_StopBits"] = "UART_STOPBITS_1";
    this->defaultValues["UART_WordLength"] = "UART_WORDLENGTH_8B";
    this->defaultValues["UART_TransmitEnable"] = "TRANSMIT_ENABLE";

}
