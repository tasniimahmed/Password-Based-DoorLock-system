#ifndef UART_H
#define UART_H

#include <stdio.h>
#include "A:/Some Requirements/Keil/tm4c123gh6pm.h"
#include "A:/Password-Based-DoorLock-system/UART/std_types.h"

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
UART_STOPBITS_0=0 ,
UART_STOPBITS_1=1
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


		/***************** FUNCTION APIs *****************/
void UART_Init(UART0_HandleTypedef * const);
#endif 

