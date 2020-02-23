

#include "uart.h"

void UART_Init(UART0_HandleTypedef * const uartConfig){
	
	
	switch(uartConfig->ParitySelect)
	{
		case ODD_PARITY: UART0_LCRH_R &= ~(UART_LCRH_EPS); break ;
		case EVEN_PARITY: UART0_LCRH_R |= UART_LCRH_EPS; break;
	}
	switch(uartConfig->HighSpeed)
	{
		case HIGH_SPEED_ENABLE: UART0_CTL_R |= UART_CTL_HSE; break;
		case HIGH_SPEED_DISABLE: UART0_CTL_R &= ~(UART_CTL_HSE); break;
	}
	switch(uartConfig->TransmitEnable)
	{
		case TRANSMIT_ENABLE: UART0_CTL_R |= UART_CTL_TXE; break;
		case TRANSMIT_DISABLE: UART0_CTL_R &= ~(UART_CTL_TXE); break;
	}
	switch(uartConfig->ReceiveEnable)
	{
		case RECEIVE_ENABLE: UART0_CTL_R |= UART_CTL_RXE; break;
		case RECEIVE_DISABLE: UART0_CTL_R &= ~(UART_CTL_RXE); break;
	}
	
	
}



