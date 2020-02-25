#include "GPIO.h"

int main (void)
{
	GPIO_HandlingPin portFpin0;
	portFpin0.AlternateFunctionSelect = 0;
	portFpin0.AnalogModeSelect = 0;
	portFpin0.Commit = 1;
	portFpin0.DigitalEnable = 1;
	portFpin0.Lock = 1;
	portFpin0.PortBase = GPIO_PORTF_APB_BASE;
	portFpin0.PortControl = 0;
	portFpin0.PullDownSelect = 0;
	portFpin0.PullUpSelect = 1;
	portFpin0.PinNumber = 0;
	portFpin0.Direction = Input;
	
	GPIO_HandlingPin portFpin1;
	portFpin1.AlternateFunctionSelect = 0;
	portFpin1.AnalogModeSelect = 0;
	portFpin1.Commit = 1;
	portFpin1.DigitalEnable = 1;
	portFpin1.Lock = 1;
	portFpin1.PortBase = GPIO_PORTF_APB_BASE;
	portFpin1.PortControl = 0;
	portFpin1.PullDownSelect = 0;
	portFpin1.PullUpSelect = 0;
	portFpin1.PinNumber = 1;
	portFpin1.Direction = Output;
	
	GPIO_HandlingPin portFpin2;
	portFpin2.AlternateFunctionSelect = 0;
	portFpin2.AnalogModeSelect = 0;
	portFpin2.Commit = 1;
	portFpin2.DigitalEnable = 1;
	portFpin2.Lock = 1;
	portFpin2.PortBase = GPIO_PORTF_APB_BASE;
	portFpin2.PortControl = 0;
	portFpin2.PullDownSelect = 0;
	portFpin2.PullUpSelect = 0;
	portFpin2.PinNumber = 2;
	portFpin2.Direction = Output;
	
	GPIO_HandlingPin portFpin3;
	portFpin3.AlternateFunctionSelect = 0;
	portFpin3.AnalogModeSelect = 0;
	portFpin3.Commit = 1;
	portFpin3.DigitalEnable = 1;
	portFpin3.Lock = 1;
	portFpin3.PortBase = GPIO_PORTF_APB_BASE;
	portFpin3.PortControl = 0;
	portFpin3.PullDownSelect = 0;
	portFpin3.PullUpSelect = 0;
	portFpin3.PinNumber = 3;
	portFpin3.Direction = Output;
	
	GPIO_HandlingPin portFpin4;
	portFpin4.AlternateFunctionSelect = 0;
	portFpin4.AnalogModeSelect = 0;
	portFpin4.Commit = 1;
	portFpin4.DigitalEnable = 1;
	portFpin4.Lock = 1;
	portFpin4.PortBase = GPIO_PORTF_APB_BASE;
	portFpin4.PortControl = 0;
	portFpin4.PullDownSelect = 0;
	portFpin4.PullUpSelect = 1;
	portFpin4.PinNumber = 4;
	portFpin4.Direction = Input;
	
	
	GPIO_InitialPin(&portFpin0);
	GPIO_InitialPin(&portFpin1);
	GPIO_InitialPin(&portFpin2);
	GPIO_InitialPin(&portFpin3);
	GPIO_InitialPin(&portFpin4);
	
	
	
	while(1)
	{
		if(!GPIO_PinRead(GPIO_PORTF_APB_DATA_R,0))
		{
			Reset_bit(GPIO_PORTF_APB_DATA_R,1);
			Reset_bit(GPIO_PORTF_APB_DATA_R,2);
			GPIO_PinWrite(&GPIO_PORTF_APB_DATA_R,3,1);  //Green
		}
		if(!GPIO_PinRead(GPIO_PORTF_APB_DATA_R,4))
		{			
			Reset_bit(GPIO_PORTF_APB_DATA_R,2);
			Reset_bit(GPIO_PORTF_APB_DATA_R,3);
			GPIO_PinWrite(&GPIO_PORTF_APB_DATA_R,1,1);  //Red
		}
		if(!GPIO_PinRead(GPIO_PORTF_APB_DATA_R,0) && !GPIO_PinRead(GPIO_PORTF_APB_DATA_R,4))
		{
			Reset_bit(GPIO_PORTF_APB_DATA_R,1);
			Reset_bit(GPIO_PORTF_APB_DATA_R,3);
			GPIO_PinWrite(&GPIO_PORTF_APB_DATA_R,2,1);  //Blue
		}
	}
}
