#ifndef TIMER
#define TIMER

#include "GPIO_Drivers/GPIO.h"

#define CPU_CLOCK 16000000
#define ENABLE 0
#define INTER 1
#define TIMER_CLK 2
#define COUNT 16


#define RELOAD STRELOAD
#define CURRENT STCURRENT
#define CONTROL_STATUS STCTRL

void TimerInit();
void SetTime_ms(uint32_t time);
void StartTimer();
void StopTimer();
void WaitTimerTimeout();
void delay_ms(uint32_t delay);
void delay_s(uint32_t delay);

#endif

