#include "Timer.h"

void TimerInit()
{
	// TIVA C Clock
	CONTROL_STATUS = 0;
	Set_bit(CONTROL_STATUS, TIMER_CLK);
	
}

void SetTime_ms(uint32_t time)
{
	if(time <= 1000)
	{
		RELOAD = (time/1000) * (CPU_CLOCK);
		CURRENT = 0;

	}
	else
	{
//		StopTimer();
	}	
}

void StartTimer()
{
	Set_bit(CONTROL_STATUS, ENABLE);
}

void StopTimer()
{
		Reset_bit(CONTROL_STATUS,ENABLE);
}
void WaitTimerTimeout()
{
	while(! GPIO_PinRead(CONTROL_STATUS,COUNT) );
	
}
void delay_ms(uint32_t delay)
{
		SetTime_ms(delay);
		StartTimer();
  	while(! GPIO_PinRead(CONTROL_STATUS,COUNT) );
}
void delay_s(uint32_t delay)
{
		for(uint16_t i = 0 ; i < delay ; i++)
				delay_ms(1000); // delay 1 seconed (1000 ms)
}
