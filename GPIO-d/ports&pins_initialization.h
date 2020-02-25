#ifndef ports_and_pins_initializations
#define ports_and_pins_initializations



/*
*	PORT D  APB PERIPHERAL IDENTIFICATION
*/
#define GPIO_PORTD_PeriphID4_APB (*((volatile uint32_t *)0x40007FD0))
#define GPIO_PORTD_PeriphID5_APB (*((volatile uint32_t *)0x40007FD4))
#define GPIO_PORTD_PeriphID6_APB (*((volatile uint32_t *)0x40007FD8))
#define GPIO_PORTD_PeriphID7_APB (*((volatile uint32_t *)0x40007FDC))
#define GPIO_PORTD_PeriphID0_APB (*((volatile uint32_t *)0x40007FE0))
#define GPIO_PORTD_PeriphID1_APB (*((volatile uint32_t *)0x40007FE4))
#define GPIO_PORTD_PeriphID2_APB (*((volatile uint32_t *)0x40007FE8))
#define GPIO_PORTD_PeriphID3_APB (*((volatile uint32_t *)0x40007FEC))


/*
*	PORT D  AHB PERIPHERAL IDENTIFICATION
*/
#define GPIO_PORTD_PeriphID4_AHB (*((volatile uint32_t *)0x4005BFD0))
#define GPIO_PORTD_PeriphID5_AHB (*((volatile uint32_t *)0x4005BFD4))
#define GPIO_PORTD_PeriphID6_AHB (*((volatile uint32_t *)0x4005BFD8))
#define GPIO_PORTD_PeriphID7_AHB (*((volatile uint32_t *)0x4005BFDC))
#define GPIO_PORTD_PeriphID0_AHB (*((volatile uint32_t *)0x4005BFE0))
#define GPIO_PORTD_PeriphID1_AHB (*((volatile uint32_t *)0x4005BFE4))
#define GPIO_PORTD_PeriphID2_AHB (*((volatile uint32_t *)0x4005BFE8))
#define GPIO_PORTD_PeriphID3_AHB (*((volatile uint32_t *)0x4005BFEC))

/*		
*			Pins of port D initialization
*			APB bits addressing
*/

#define PD0_APB (*((volatile uint32_t *)0x40007004))
#define PD1_APB (*((volatile uint32_t *)0x40007008))
#define PD2_APB (*((volatile uint32_t *)0x40007010))
#define PD3_APB (*((volatile uint32_t *)0x40007020))
#define PD4_APB (*((volatile uint32_t *)0x40007040))
#define PD5_APB (*((volatile uint32_t *)0x40007080))
#define PD6_APB (*((volatile uint32_t *)0x40007100))
#define PD7_APB (*((volatile uint32_t *)0x40007200))


/*		
*			Pins of port D initialization
*			AHB bits addressing
*/

#define PD0_AHB (*((volatile uint32_t *)0x4005B004))
#define PD1_AHB (*((volatile uint32_t *)0x4005B008))
#define PD2_AHB (*((volatile uint32_t *)0x4005B010))
#define PD3_AHB (*((volatile uint32_t *)0x4005B020))
#define PD4_AHB (*((volatile uint32_t *)0x4005B040))
#define PD5_AHB (*((volatile uint32_t *)0x4005B080))
#define PD6_AHB (*((volatile uint32_t *)0x4005B100))
#define PD7_AHB (*((volatile uint32_t *)0x4005B200))



/*
*	PORT E APB PERIPHERAL IDENTIFICATION
*/
#define GPIO_PORTE_PeriphID4_APB (*((volatile uint32_t *)0x40024FD0))
#define GPIO_PORTE_PeriphID5_APB (*((volatile uint32_t *)0x40024FD4))
#define GPIO_PORTE_PeriphID6_APB (*((volatile uint32_t *)0x40024FD8))
#define GPIO_PORTE_PeriphID7_APB (*((volatile uint32_t *)0x40024FDC))
#define GPIO_PORTE_PeriphID0_APB (*((volatile uint32_t *)0x40024FE0))
#define GPIO_PORTE_PeriphID1_APB (*((volatile uint32_t *)0x40024FE4))
#define GPIO_PORTE_PeriphID2_APB (*((volatile uint32_t *)0x40024FE8))
#define GPIO_PORTE_PeriphID3_APB (*((volatile uint32_t *)0x40024FEC))


/*
*	PORT E AHB PERIPHERAL IDENTIFICATION
*/
#define GPIO_PORTE_PeriphID4_AHB (*((volatile uint32_t *)0x4005CFD0))
#define GPIO_PORTE_PeriphID5_AHB (*((volatile uint32_t *)0x4005CFD4))
#define GPIO_PORTE_PeriphID6_AHB (*((volatile uint32_t *)0x4005CFD8))
#define GPIO_PORTE_PeriphID7_AHB (*((volatile uint32_t *)0x4005CFDC))
#define GPIO_PORTE_PeriphID0_AHB (*((volatile uint32_t *)0x4005CFE0))
#define GPIO_PORTE_PeriphID1_AHB (*((volatile uint32_t *)0x4005CFE4))
#define GPIO_PORTE_PeriphID2_AHB (*((volatile uint32_t *)0x4005CFE8))
#define GPIO_PORTE_PeriphID3_AHB (*((volatile uint32_t *)0x4005CFEC))


/*		
*			Pins of port E initialization (6 BITS ONLY)
*			APB bits addressing
*/

#define PE0_APB (*((volatile uint32_t *)0x40024004))
#define PE1_APB (*((volatile uint32_t *)0x40024008))
#define PE2_APB (*((volatile uint32_t *)0x40024010))
#define PE3_APB (*((volatile uint32_t *)0x40024020))
#define PE4_APB (*((volatile uint32_t *)0x40024040))
#define PE5_APB (*((volatile uint32_t *)0x40024080))
#define PE6_APB (*((volatile uint32_t *)0x40024100))



/*		
*			Pins of port E initialization (6 BITS ONLY)
*			AHB bits addressing
*/

#define PE0_AHB (*((volatile uint32_t *)0x4005C004))
#define PE1_AHB (*((volatile uint32_t *)0x4005C008))
#define PE2_AHB (*((volatile uint32_t *)0x4005C010))
#define PE3_AHB (*((volatile uint32_t *)0x4005C020))
#define PE4_AHB (*((volatile uint32_t *)0x4005C040))
#define PE5_AHB (*((volatile uint32_t *)0x4005C080))
#define PE6_AHB (*((volatile uint32_t *)0x4005C100))



/*
*	PORT F APB PERIPHERAL IDENTIFICATION
*/
#define GPIO_PORTF_PeriphID4_APB (*((volatile uint32_t *)0x40025FD0))
#define GPIO_PORTF_PeriphID5_APB (*((volatile uint32_t *)0x40025FD4))
#define GPIO_PORTF_PeriphID6_APB (*((volatile uint32_t *)0x40025FD8))
#define GPIO_PORTF_PeriphID7_APB (*((volatile uint32_t *)0x40025FDC))
#define GPIO_PORTF_PeriphID0_APB (*((volatile uint32_t *)0x40025FE0))
#define GPIO_PORTF_PeriphID1_APB (*((volatile uint32_t *)0x40025FE4))
#define GPIO_PORTF_PeriphID2_APB (*((volatile uint32_t *)0x40025FE8))
#define GPIO_PORTF_PeriphID3_APB (*((volatile uint32_t *)0x40025FEC))


/*
*	PORT F AHB PERIPHERAL IDENTIFICATION
*/
#define GPIO_PORTF_PeriphID4_AHB (*((volatile uint32_t *)0x4005DFD0))
#define GPIO_PORTF_PeriphID5_AHB (*((volatile uint32_t *)0x4005DFD4))
#define GPIO_PORTF_PeriphID6_AHB (*((volatile uint32_t *)0x4005DFD8))
#define GPIO_PORTF_PeriphID7_AHB (*((volatile uint32_t *)0x4005DFDC))
#define GPIO_PORTF_PeriphID0_AHB (*((volatile uint32_t *)0x4005DFE0))
#define GPIO_PORTF_PeriphID1_AHB (*((volatile uint32_t *)0x4005DFE4))
#define GPIO_PORTF_PeriphID2_AHB (*((volatile uint32_t *)0x4005DFE8))
#define GPIO_PORTF_PeriphID3_AHB (*((volatile uint32_t *)0x4005DFEC))

/*		
*			Pins of port F initialization (5 BITS ONLY)
*			APB bits addressing
*/

#define PF0_APB (*((volatile uint32_t *)0x40025004))
#define PF1_APB (*((volatile uint32_t *)0x40025008))
#define PF2_APB (*((volatile uint32_t *)0x40025010))
#define PF3_APB (*((volatile uint32_t *)0x40025020))
#define PF4_APB (*((volatile uint32_t *)0x40025040))
#define PF5_APB (*((volatile uint32_t *)0x40025080))



/*		
*			Pins of port F initialization (5 BITS ONLY)
*			AHB bits addressing
*/

#define PF0_AHB (*((volatile uint32_t *)0x4005D004))
#define PF1_AHB (*((volatile uint32_t *)0x4005D008))
#define PF2_AHB (*((volatile uint32_t *)0x4005D010))
#define PF3_AHB (*((volatile uint32_t *)0x4005D020))
#define PF4_AHB (*((volatile uint32_t *)0x4005D040))
#define PF5_AHB (*((volatile uint32_t *)0x4005D080))


#endif