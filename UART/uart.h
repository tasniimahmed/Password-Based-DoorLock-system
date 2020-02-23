#ifndef UART_H_
#define UART_H_

#ifndef F_CPU
#define F_CPU 1000000UL
#endif

/****************************includes***************************/
#include "D:/std_types.h"
#include "C:/Keil_v5/EE319KwareSpring2020/inc/tm4c123gh6pm.h"




/************************** Enums & Structs ***************************/ 
typedef enum
{
	PARITY_ENABLE=1, 
	PARITY_DISABLE=0 
}UART_ParityEnable;

typedef enum 
{
	FIFO_ENABLE =1 , 
	FIFO_DISABLE=0
}UART_FIFO;

typedef enum 
{
	UART_WORDLENGTH_5B=0x0, 
	UART_WORDLENGTH_6B=0x1,
	UART_WORDLENGTH_7B=0x2,
	UART_WORDLENGTH_8B=0x3
}UART_WordLength;

typedef enum 
{
	UART_STOPBITS_1=0 , 
	UART_STOPBITS_2=1
}UART_StopBits;

typedef enum{
    ODD_PARITY = 1,
    EVEN_PARITY =0
}UART_ParitySelect;

typedef enum{
    HIGH_SPEED_ENABLE = 1,
    HIGH_SPEED_DISABLE = 0
}UART_HighSpeed;

typedef enum{
    TRANSMIT_ENABLE = 1,
    TRANSMIT_DISABLE = 0
}UART_TransmitEnable;

typedef enum{
    RECEIVE_ENABLE = 1,
    RECEIVE_DISABLE = 0
}UART_ReceiveEnable;


/**
  * @brief  UART handle Structure definition
  */
typedef struct
{
	uint32_t BaudRate; 	
	UART_WordLength WordLength; 
	UART_StopBits StopBits;
	UART_FIFO FIFO; 
	UART_ParityEnable ParityEnable;
	UART_ParitySelect ParitySelect;
	UART_HighSpeed HighSpeed ; 
	UART_ReceiveEnable ReceiveEnable; 
	UART_TransmitEnable TransmitEnable ; 
	
}UART0_HandleTypedef;


/*****************************FUNCTION DECLARATIONS*************************************/ 
void UART_init(UART0_HandleTypedef *const uartConfig);

#endif