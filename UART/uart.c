 /********************************************************************************
 * Module : UART
 *
 * File Name : uart.c
 *
 * Description : Source File for UART Module
 *
 * Author : Shreef Mohamed & Ayman Nasr 
 *
 * Created on: Feb 23, 2020
 *
 ********************************************************************************/
 
#include "uart.h" 




	/*
	 *           UART_init Function 
	 * Takes: address of "UART0_HandleTypedef" to make configuration 
	 * Return:  No thing  
	 * Steps of Initializtaions UART:
	 * 1. call function to enable clk for both UART and its PORT
	 * 2. Disable UART Module till finishing the initializations
	 * 3. Make your Configurations in the UART Registers 
	 * 4. Enable UART Module 
	*/

/**
  * @brief  UART_init Function definition
  */
void UART_init(UART0_HandleTypedef *const uartConfig)
{
	/* Variables  */ 
		 float32_t baudRateDivisor;
	   uint16_t intBRD;
	/* 1. Calling the Function to initialize the clk */ 

	/* 2. Disable UART Module */
		UART0_CTL_R &= ~(UART_CTL_UARTEN);
	/* 3. Make your Configurations in the UART Registers */
	
		/* 3.1 Configuration of UART0 CTL Register */
		UART0_CTL_R=0 ; 

    /* Configuring the baud rate of UART transmitting & receiving
         if UART is configured to high speed so we divide by 8 else
         diving by 16.
         Seperating the integer part & fractional part of baud rate
         divisor into 2 vars and assigning UART IntegerBRD & FracBRD
    */
    if(uartConfig->HighSpeed == HIGH_SPEED_ENABLE)
    {
        baudRateDivisor = F_CPU / (8 * uartConfig->BaudRate);
        intBRD = baudRateDivisor;
        baudRateDivisor = ( baudRateDivisor - (float32_t)intBRD ) * 100;
        UART0_IBRD_R = intBRD;
        UART0_FBRD_R = (uint8_t)((baudRateDivisor*64)+0.5 );
    }
    else
    {    
        baudRateDivisor = F_CPU / (16 * uartConfig->BaudRate);
        intBRD = baudRateDivisor;
        baudRateDivisor = ( baudRateDivisor - (float32_t)intBRD ) * 100;
        UART2_IBRD_R = intBRD;
        UART0_FBRD_R = (uint8_t)((baudRateDivisor*64)+0.5 );
    }
    
    /* Configuring High Speed Bit
         0 ==> The UART is clocked using the system clock divided by 16
         1 ==> The UART is clocked using the system clock divided by 8
    */
    switch(uartConfig->HighSpeed)
    {
        case HIGH_SPEED_ENABLE: UART0_CTL_R |= UART_CTL_HSE; break;
        case HIGH_SPEED_DISABLE: UART0_CTL_R &= ~(UART_CTL_HSE); break;
    }
    /* UART Transmit Enable/Disable*/
    switch(uartConfig->TransmitEnable)
    {
        case TRANSMIT_ENABLE: UART0_CTL_R |= UART_CTL_TXE; break;
        case TRANSMIT_DISABLE: UART0_CTL_R &= ~(UART_CTL_TXE); break;
    }
    /* UART Receive Enable/Disable*/
    switch(uartConfig->ReceiveEnable)
    {
        case RECEIVE_ENABLE: UART0_CTL_R |= UART_CTL_RXE; break;
        case RECEIVE_DISABLE: UART0_CTL_R &= ~(UART_CTL_RXE); break;
    }
   
	
	/* 3.2 Configuration of UART0 LCRH Register */ 
		UART0_LCRH_R=0; 
	// configure the word length of the Data check this enum >> UART_WordLength
	switch(uartConfig->WordLength) 
	{
		case UART_WORDLENGTH_5B: 
				 UART0_LCRH_R |=UART_LCRH_WLEN_5; 
				 break ;
		case UART_WORDLENGTH_6B: 
				 UART0_LCRH_R |=UART_LCRH_WLEN_6; 
				 break ;
		case UART_WORDLENGTH_7B: 
				 UART0_LCRH_R |=UART_LCRH_WLEN_7; 
				 break ;
		case UART_WORDLENGTH_8B: 
				 UART0_LCRH_R |=UART_LCRH_WLEN_8; 
				 break ;		
	}
	//Configure number of FIFOs used if we enable it , FIFO will carry up to 16 element
	// check this enum >> UART_ParityEnable
	switch(uartConfig->FIFO)
	{
		case FIFO_ENABLE : 
				 UART0_LCRH_R |= UART_LCRH_FEN;
					break ; 
		case FIFO_DISABLE : 
				 UART0_LCRH_R &= ~(UART_LCRH_FEN);
					break ; 
	}
	//Enable or Disable Parity check this enum >> UART_ParityEnable
	switch(uartConfig->ParityEnable)
	{
		case PARITY_ENABLE: 
				 UART0_LCRH_R |= UART_LCRH_PEN ;
				 break;
		case PARITY_DISABLE:
				 UART0_LCRH_R &= ~(UART_LCRH_PEN) ;
				 break; 
	}
	//Configure either one stop bit or 2 stop bits 
	// check this enum >> UART_StopBits
	switch(uartConfig->StopBits)
	{
		case UART_STOPBITS_2: 
				 UART0_LCRH_R |= UART_LCRH_STP2;
				 break; 
		case UART_STOPBITS_1: 
				 UART0_LCRH_R &= ~(UART_LCRH_STP2);
				 break; 
	}
		/* Configuring Parity Error bit either odd or even check */
    switch(uartConfig->ParitySelect)
    {
        case ODD_PARITY: UART0_LCRH_R &= ~(UART_LCRH_EPS); break ;
        case EVEN_PARITY: UART0_LCRH_R |= UART_LCRH_EPS; break;
    }
		
		/* 4. Enable UART Module */ 
		UART0_CTL_R |= UART_CTL_UARTEN; 

}
	
	


