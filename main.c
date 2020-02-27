//#include <stdint.h>
#include "LCD/lcd.h"
#include "Keypad/keypad.h"
#include "tm4c123gh6pm.h"
#include "GPIO_Drivers/GPIO.h"
#include "GPIO_Drivers/EEPROM.h"
#include "GPIO_Drivers/Data_Type.h"
//#include "UART/uart.h" 
#define PASSWORD_SIZE 4

/*************************** FUNCTION DECLRATIONS *************************/ 
void test_LCD();
void UART_Config(); 
void test_LCD();
void password_approved();
void Login();
void getPassword(char * pw_arr);
bool Login_Validation(char * pw_arr , char* pw_true);
void EEPROM_FillPassword(char* password);
void uint32_tToChar(char*,uint8_t,uint32_t);
uint32_t Pow(uint32_t,uint32_t);
int32_t charToint(char * arr);

/************************** HANDLE STRUCTS ********************************/ 
//UART_HandleTypedef huart ; 


/************************** GLOBAL VARIABLES *******************************/

char pw_true[PASSWORD_SIZE];
/************************** MAIN FUNCTION ************************************/

int main()
{  
	GPIO_HandlingPin portApin2;
  portApin2.PortBase = GPIO_PORTA_APB_BASE;
	portApin2.AlternateFunctionSelect = 0;
	portApin2.AnalogModeSelect = 0;
	portApin2.Commit = 1;
	portApin2.DigitalEnable = 1;
	portApin2.Direction = Output;
	portApin2.Lock = 1;
	portApin2.PinNumber = 2;
	portApin2.PullDownSelect = 0;
	portApin2.PullUpSelect = 0;
	portApin2.PortControl = 0;
	
	
	GPIO_InitialPin(&portApin2);
	
	GPIO_HandlingPin portDpin3;
  portDpin3.PortBase = GPIO_PORTD_APB_BASE;
	portDpin3.AlternateFunctionSelect = 0;
	portDpin3.AnalogModeSelect = 0;
	portDpin3.Commit = 1;
	portDpin3.DigitalEnable = 1;
	portDpin3.Direction = Output;
	portDpin3.PinNumber = 3;
	portDpin3.PullDownSelect = 0;
	portDpin3.PullUpSelect = 0;
	portDpin3.PortControl = 0;
	
	GPIO_InitialPin(&portDpin3);
	
	keypad_Init();
	LCD_Init();
	EEPROM_Init(0);
	EEPROM_WriteData(0,0,1234);
	uint16_t flag=1;
	char pw_arr[4];
	while(1)
	{
				LCD_Write_String("Enter Password");
				LCD_Set_Cursor_Position(1,6);
        getPassword(pw_arr);
			  int32_t data = EEPROM_ReadData(0,0);
				uint32_tToChar(pw_true,4,data);
				//uint32_tToChar(pw_true,4,load_pass);
				bool valid = Login_Validation(pw_arr,pw_true);
				if(valid)
				{
					LCD_Clear();
					LCD_Write_String_Position(0,3,"MABROOK");
					LCD_Blink();
					delay_m(500);
					Login();
				}
				else 
				{
					LCD_Clear();					
					LCD_Write_String_Position(0,3,"INCORRECT");		
					GPIO_PORTD_APB_DATA_PIN3 = 0x08;
					LCD_Blink();
					LCD_Clear();
					GPIO_PORTD_APB_DATA_PIN3 = 0x00;
					delay_m(5000);
					GPIO_PORTD_APB_DATA_PIN3 = 0x08;
          delay_m(5000);
					GPIO_PORTD_APB_DATA_PIN3 = 0x00;					
				}
				
				
	}
}



bool Login_Validation(char * pw_arr , char* pw_true)
{
	
	for ( uint8_t j=0; j<PASSWORD_SIZE; j++){
				if(pw_arr[j] != pw_true[j]){
					GPIO_PORTD_APB_DATA_PIN3 = 0x08;
					return 0;
				}
		}
	return 1;
}
void getPassword(char * pw_arr)
{	
	uint16_t i=0;
	char space_counter = 0; 
	while(1)
	{			
			char x=KeyPad_getPressedKey();
			if (x == '+' && i == PASSWORD_SIZE )
			{
				if(space_counter < PASSWORD_SIZE )
				{
					LCD_Clear();
					LCD_Write_String("Invalid Password");
					LCD_Set_Cursor_Position(1,6);					
					i=0;
					space_counter = 0;
				}
				else
					return;
			}
			
			else if (x =='.'&& i > 0 )
			{
				LCD_Shift_Cursor_Left();
				i--;
			}
			else if ( x== '=' &&  i < PASSWORD_SIZE )
			{
				LCD_Shift_Cursor_Right();
				i ++;
			}
			else if (x=='/' && i > 0 &&  i <= PASSWORD_SIZE)
			{
				LCD_Back(); 
				--i ;
				space_counter --;
			}

			else if( ( x >= '0' && x <= '9' ) && i < PASSWORD_SIZE  ) 
			{
				LCD_Write_Char(x);
				pw_arr[i]=x;
				i++; 
				space_counter++;
			}

			delay_m(1000);
	}
}

void Login()
{
		LCD_Clear();
		LCD_Write_String_Position(0,0,"1-Open");
		LCD_Write_String_Position(0,8,"2-Close");
		LCD_Write_String_Position(1,0,"3-Reset Password");
	
		while(1)
		{
			char c = KeyPad_getPressedKey();
			if (c =='1'){
				GPIO_PORTA_APB_DATA_PIN2 = 0x04;
			}
			else if ( c == '2')
			{
				GPIO_PORTA_APB_DATA_PIN2 = 0x00;				
			}
			else if(c == '3')
			{
					char password1[PASSWORD_SIZE] , password2[PASSWORD_SIZE];
					
					// get the password first time ... clear, write in the first line , set the cursor to the password position , get the password
					LCD_Clear();
					LCD_Write_String("NewPassword:");
					LCD_Set_Cursor_Position(1,6);
					getPassword(password1);
				
					// re enter the password
					LCD_Clear();
					LCD_Write_String("ReEnter Password");
					LCD_Set_Cursor_Position(1,6);
					getPassword(password2);

					if( Login_Validation(password1,password2) )
					{
								EEPROM_FillPassword(password1); // because password1 is ray2 
								LCD_Clear();
								LCD_Write_String("Password Changed!");
								LCD_Blink();
								LCD_Clear();
								return;
					}
					else
					{
								LCD_Clear();
								LCD_Write_String("Passwords is not Matched");
								LCD_Blink();
								LCD_Clear();
								LCD_Write_String_Position(0,0,"1-Open");
								LCD_Write_String_Position(0,8,"2-Close");
								LCD_Write_String_Position(1,0,"3-Reset Password");								
					}
									
			}

		}
}

void EEPROM_FillPassword(char* password)
{
	for(int i =0 ; i < PASSWORD_SIZE ; i++)
	{
		pw_true[i] = password[i];
	}
	EEPROM_WriteData(0,0,charToint(password) );
}
/*************************** FUNCTION DEFINITIONS *************************/ 
/*void UART_Config()
{

	huart.BaudRate = 9600 ;
	huart.FIFO = FIFO_ENABLE ; 
	huart.HighSpeed = HIGH_SPEED_DISABLE ; 
	huart.ParityEnable= PARITY_DISABLE ; 
	huart.StopBits = UART_STOPBITS_1; 
	huart.WordLength= UART_WORDLENGTH_8B ; 
	huart.TransmitEnable= TRANSMIT_ENABLE ;
}*/



void uint32_tToChar(char* arr,uint8_t size,uint32_t data)
{
	for(uint8_t i = 0; i<size;i=i+1)
	{
		arr[i] = (data/(Pow((size-i-1),10))) + '0';
		data = data%(Pow((size-i-1),10));
	}
}

uint32_t Pow(uint32_t power,uint32_t base)
{
	uint32_t x = 1;
	for(uint32_t i = 0;i<power;i=i+1)
	{
		x = x * base;
	}
	return x;
}

int32_t charToint(char * arr)
{
	int32_t data = 0 ;
	
	for(uint8_t i =0;i<PASSWORD_SIZE;i++)
	{
		data += (arr[i] - '0')*(Pow((PASSWORD_SIZE-i-1),10));
	}

	return data;
	
}
