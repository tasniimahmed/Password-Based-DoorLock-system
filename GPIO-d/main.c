#include "stdint.h"
#include "tm4c123gh6pm.h"
#include "ports&pins_initialization.h"

void SystemInit(){}
	
	

/* 		setting and clearing pin values		*/

#define set_pin(variable,pin_num) variable|=(1<<pin_num)
#define clear_pin(variable,pin_num) variable &= ~(1<<pin_num)


/*		Getting pin value 	*/

#define get_pin(variable,pin_num) ((variable>>pin_num)&1)


/*		
			setting pin direction	
			when the required pin is set i.e. ==1; it is set to be an output
*/

#define set_pin_dir(variable,pin_num) variable|=(1<<pin_num)


/*		setting port value		*/
//#define set_port_value(variable, new_val) variable=new_val 


/*		
			setting port direction		
			when the required port is set i.e. ==1; it is set to be an output
*/

#define set_port_direction(variable) variable=1


	

	int main()
	{
	
	}