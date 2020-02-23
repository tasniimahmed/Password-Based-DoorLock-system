#include <stdint.h>
#include "LCD/lcd.h"

int main()
{
	
	LCD_Init();

	char * x0 = "Ray2" ;
	char * x1 = "Amr" ;
	char * x2 = "Elsersy" ;
	char * x3 = "Tasnim" ;

	LCD_Write_String_Position(0,0,x0);
	LCD_Write_String_Position(0,6,x3);
	

	char x = LCD_Read_Cursor_Position(0,7);
	LCD_Write_Char_Position(1,0,x);
	




	delay_m(100000);		
	for (int i = 0 ; i < 2 ; i ++ )
	{
		for(int j = 0 ; j < 14; j ++ )
		{
				delay_m(1000);
				LCD_Write_Char_Position(i,j,'y');
		}
	}
	
	
	
	
	while(1){
		
	}
}