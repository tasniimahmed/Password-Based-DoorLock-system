#include "lcd.h"

void delay_m(int n){
int i,j;
for(i=0;i<n;i++)
for(j=0;j<3180;j++)
{}
}

void delay_u(int n){
int i,j;
for(i=0;i<n;i++)
for(j=0;j<3;j++)
{}
}


void LCD_Delay() {	
/* Commands take a delay of time so when we send command (in Send_Command function or LCD_init function) 
	 we need to make sure that the command has finished so we have 2 ways 
			1- waiting for the Busy-Flag Bit (DB7 bit in the Data Port Register (only when RS = 0) )
			2- Delay with the longest command time (max time for commands is 1.53 ms )*/	
//	while(DATA_PORT & (1<< DB7) );
	delay_m(2);
} 



void LCD_Init(void){
	SYSCTL_RCGCGPIO_R |= 0x03;            //clk for portA and portB
/******Portb data pins******/
	CTRL_PORT_AFSEL=0; 
	CTRL_PORT_PCTL=0;
	CTRL_PORT_AMSEL=0;
	DATA_PORT_DIR=0xFF;               //all port output D0->D7
	DATA_PORT_DEN=0xFF;               //all port digital
/******Porta control pins*****/
	DATA_PORT_AFSEL=0;
	DATA_PORT_PCTL=0;
	DATA_PORT_AMSEL=0;
	CTRL_PORT_DIR |= (1<<RS) | (1<<RW) | (1<<E) ;                 //last 3 pins output rs,rw,E
	CTRL_PORT_DEN |= (1<<RS) | (1<<RW) | (1<<E) ;                 //last 3 pins output rs,rw,E

	
/******Intializing lcd*****/
	delay_m(40);
	LCD_Write_Command(TWO_LINE_LCD_Eight_BIT_MODE);           //intializing 2 lines of lcd and 5x8 blocks   
	delay_u(50);
	LCD_Write_Command(CURSOR_ON);           //display data,on for the cursol, no blink cursol
	delay_u(50);
	LCD_Write_Command(CLEAR_COMMAND);           //clear lcd
	delay_m(2);

// for the problem of missing first charachter 
	LCD_Delay();
	delay_m(2);
}


void LCD_Write_Command(char cmd){
	CTRL_PORT &= ~(1<<RS);         //control pins set to 0 rs=0 for command
	CTRL_PORT &= ~(1<<RW);
	DATA_PORT = cmd;
	CTRL_PORT |= (1<<E);        	 //E=1
	delay_m(2);
	CTRL_PORT &= ~(1<<E);          //E=0
}

void LCD_Write_Char(char data){
	CTRL_PORT |= (1<<RS);          //rs=1 for writing data data
	CTRL_PORT &= ~(1<<RW);
	DATA_PORT = data;
	CTRL_PORT |= (1<<E);      	   //E=1
	delay_m(2);
	CTRL_PORT &= ~(1<<E);          //E=0
}

void LCD_Write_String(char* string)
{
	uint8_t i = 0;
	// loop until you reach the null character as an indication for the end of the string
	while ( string[i] != '\0' )
	{		
		LCD_Write_Char(string[i] );
		i++ ;
	}	
}
void LCD_Clear()
{
	LCD_Write_Command(CLEAR_COMMAND);
	LCD_Delay(); // for the problem of missing first charachter 
}
void LCD_Set_Cursor_Position(uint8_t row, uint8_t col )
{
	uint8_t Address ;
	if (row == 0)
		Address = 0x80 + col; // 80 is address of first line
	else if (row == 1)			
		Address = 0xc0 + col; // c0 is address of seconed line
	
	if( (row != 0 && row != 1 ) || col < 0 || col > 15 )
	{
		LCD_Clear();
		LCD_Write_String("ERROR");
		LCD_Blink();
	}
	
	LCD_Write_Command(Address); // set the Cursor Position Command
	LCD_Delay();

}
void LCD_Write_Char_Position(uint8_t row, uint8_t col , char c)
{
	LCD_Set_Cursor_Position(row,col);
	LCD_Write_Char(c);
}
void LCD_Write_String_Position( uint8_t row, uint8_t col , char* string)
{
	LCD_Set_Cursor_Position(row,col);
	LCD_Write_String(string);
}

void LCD_CursorDir_Forward()
{
	LCD_Write_Command(SET_CURSOR_DIR_FORWARD);
	LCD_Delay();
}
void LCD_CursorDir_Backword()
{
	LCD_Write_Command(SET_CURSOR_DIR_BACKWORD);	
	LCD_Delay();
}
void LCD_Shift_Cursor_Left()
{
	LCD_Write_Command(SHIFT_CURSOR_LEFT);
	LCD_Delay();
}
void LCD_Shift_Cursor_Right()
{
	LCD_Write_Command(SHIFT_CURSOR_RIGHT);
	LCD_Delay();
}

void LCD_Back()
{
	LCD_Shift_Cursor_Left();
	LCD_Write_Char(' ');
	LCD_Shift_Cursor_Left();
}
void LCD_Blink()
{
	for(int i = 0 ; i < 3 ; i ++)
	{
		delay_m(BLINK_TIME_ms);
		LCD_Write_Command(LCD_OFF);
		delay_m(BLINK_TIME_ms);
		LCD_Write_Command(LCD_ON);
	}
	LCD_Write_Command(LCD_ON);
}


char LCD_Read_Char()
{
		CLEAR_BIT(CTRL_PORT,RS);
		SET_BIT(CTRL_PORT,RW);
		delay_m(2);
		while(DATA_PORT & (1<< DB7);
		return DATA_PORT & 0b01111111;	// cancel the last bit ( the Busy flag bit )
}


char LCD_Read_Cursor_Position(uint8_t row , uint8_t col)
{
		LCD_Set_Cursor_Position(row,col);

		CLEAR_BIT(CTRL_PORT,RS);
		SET_BIT(CTRL_PORT,RW);
			
		return LCD_Read_Char();
}