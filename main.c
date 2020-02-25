#include <stdint.h>
#include "LCD/lcd.h"
#include "Keypad/keypad.h"
#include "tm4c123gh6pm.h"
#include "UART/uart.h" 

/*************************** FUNCTION DECLRATIONS *************************/ 
void test_LCD();
void UART_Config(); 
void test_LCD();
void password_approved();
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
	UART4_init(&huart);
	keypad_Init();
	LCD_Init();
	/*   CODE BEGIN 0    */
	password_approved();
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

void password_approved(){
	LCD_Write_Command(0b01000000); //set CGRAM address
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(1);
	LCD_Write_Char(2);
	LCD_Write_Char(4);
	LCD_Write_Char(8);
	LCD_Write_Char(48);
	LCD_Write_Command(0b1000000); //first place in lcd
	LCD_Write_Char(0);
	
	LCD_Write_Command(0b01000001); //set CGRAM address
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(31);
	LCD_Write_Command(0b1000001); //first place in lcd
	LCD_Write_Char(1);
	
	LCD_Write_Command(0b01000010); //set CGRAM address
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(4);
	LCD_Write_Char(5);
	LCD_Write_Char(4);
	LCD_Write_Char(5);
	LCD_Write_Char(60);
	LCD_Write_Command(0b1000010); //first place in lcd
	LCD_Write_Char(2);
	
	LCD_Write_Command(0b01000011); //set CGRAM address
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(6);
	LCD_Write_Char(177);
	LCD_Write_Char(81);
	LCD_Write_Char(210);
	LCD_Write_Char(124);
	LCD_Write_Command(0b1000011); //first place in lcd
	LCD_Write_Char(3);
	
	LCD_Write_Command(0b01000100); //set CGRAM address
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(18);
	LCD_Write_Char(17);
	LCD_Write_Char(1);
	LCD_Write_Char(49);
	LCD_Write_Char(2);
	LCD_Write_Command(0b1000100); //first place in lcd
	LCD_Write_Char(4);
}