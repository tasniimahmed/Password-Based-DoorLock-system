//#include <stdint.h>
#include "LCD/lcd.h"
#include "Keypad/keypad.h"
#include "tm4c123gh6pm.h"
#include "GPIO_Drivers/GPIO.h"
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
int Login_Validation(char * pw_arr , char* pw_true);
void EEPROM_FillPassword(char* password);

/************************** HANDLE STRUCTS ********************************/ 
//UART_HandleTypedef huart ; 


/************************** GLOBAL VARIABLES *******************************/

char pw_true[PASSWORD_SIZE]= {'1','2','3','4'};
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
	
	/* LOCAL VARIABLES */ 
	uint8_t mesg[10] = "HELLO\n\r" ; 
	/* CALL Config FUNCTIONS */
	//UART_Config();
	/* CALL INITS FUNCTIONS   */
	//UART4_init(&huart);
	keypad_Init();
	LCD_Init();
	/*   CODE BEGIN 0    */
	
	//char pw_true[4]= {'1','2','3','4'};
	
	
	/*LCD_Write_Command(0b01000000); //set CGRAM address
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(0);
	LCD_Write_Char(4);
	LCD_Write_Char(5);
	LCD_Write_Char(4);
	LCD_Write_Char(5);
	LCD_Write_Char(60);
	LCD_Write_Command(0b10000000); //first place in lcd
	LCD_Write_Char(0);*/
	//password_approved();
	//test_LCD();
	/* START OF WHILE LOOP*/ 
	uint16_t flag=1;
	char pw_arr[4];
	while(1)
	{
		
		//password_approved();
		//UART4_trasnmitString(mesg);
//		GPIO_PORTA_APB_DATA_PIN2 = 0x04;
		
				LCD_Write_String("Enter Password");
				LCD_Set_Cursor_Position(1,6);
        getPassword(pw_arr);
	
				int valid = Login_Validation(pw_arr,pw_true);
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



int Login_Validation(char * pw_arr , char* pw_true)
{
	
	for ( uint16_t j=0; j<PASSWORD_SIZE; j++){
				if(pw_arr[j] != pw_true[j]){
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
	LCD_Write_Command(0b10000000); //first place in lcd
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