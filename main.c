#include <stdint.h>
#include "LCD/lcd.h"
#include "Keypad/keypad.h"
#include "tm4c123gh6pm.h"
#include "UART/uart.h" 

/*************************** FUNCTION DECLRATIONS *************************/ 
void test_LCD();
void UART_Config(); 
void test_LCD();
/************************** HANDLE STRUCTS ********************************/ 
UART_HandleTypedef huart ; 


/************************** GLOBAL VARIABLES *******************************/

/************************** MAIN FUNCTION ************************************/

int main()
{  
	/* LOCAL VARIABLES */ 
	uint8_t mesg[10] = "HELLO\n\r" ; 
	/* CALL Config FUNCTIONS */
	UART_Config();
	/* CALL INITS FUNCTIONS   */
	UART_Config();
	UART4_init(&huart);
	keypad_Init();
	LCD_Init();
	/* START OF WHILE LOOP*/ 
	while(1)
	{
		UART4_trasnmitString(mesg);
		char x=KeyPad_getPressedKey();
		LCD_Write_Char(x);
		delay_m(2000);
	}
}


/*************************** FUNCTION DEFINITIONS *************************/ 
void UART_Config()
{

	huart.BaudRate = 9600 ;
	huart.FIFO = FIFO_ENABLE ; 
	huart.HighSpeed = HIGH_SPEED_DISABLE ; 
	huart.ParityEnable= PARITY_DISABLE ; 
	huart.StopBits = UART_STOPBITS_1; 
	huart.WordLength= UART_WORDLENGTH_8B ; 
	huart.TransmitEnable= TRANSMIT_ENABLE ;
}

void test_LCD()
{
		LCD_Init();

	char * x0 = "Ray2" ;
	char * x1 = "Amr" ;
	char * x2 = "Door-Lock" ;
	char * x3 = "Tasnim" ;
	
	LCD_Set_Cursor_Position(0,3);
	delay_m(1000);
	LCD_Write_String(x0);
	delay_m(1000);
	for(int i = 0 ; i<3 ; i++)
	{LCD_Shift_Cursor_Right(); delay_m(1000); }
	for(int i = 0 ; i<2 ; i++)
	{LCD_Shift_Cursor_Left(); delay_m(1000); }
	delay_m(1000);
	LCD_Shift_Cursor_Down();
	delay_m(1000);
	LCD_Write_String("ABC");
	delay_m(1000);
	LCD_Back(); 	delay_m(1000); LCD_Back();
	delay_m(1000);
	LCD_Shift_Cursor_Up(); 	delay_m(1000);
	LCD_Blink();
	LCD_Set_Cursor_Position(0,13);
	delay_m(1000);
	LCD_Write_String(x2);
		
	for (int i = 0 ; i < 2 ; i ++ )
	{
		for(int j = 0 ; j < 14; j ++ )
		{
				delay_m(1000);
				LCD_Write_Char_Position(i,j,' ');
		}
	}

}