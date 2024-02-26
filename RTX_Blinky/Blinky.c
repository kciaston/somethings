/*----------------------------------------------------------------------------
 * Name:    Blinky.c
 * Purpose: CMSIS-RTOS2 example program
 * Note(s): possible defines set in "options for target - C/C++ - Define"
 *            __USE_LCD    - enable Output on GLCD
 *----------------------------------------------------------------------------*/

#include "cmsis_os2.h"                  /* ::CMSIS:RTOS2 */
#include "RTE_Components.h"             /* Component selection */
#include CMSIS_device_header


typedef struct
{
  uint32_t SR;         /*!< USART Status register,                   Address offset: 0x00 */
  uint32_t DR;         /*!< USART Data register,                     Address offset: 0x04 */
  uint32_t BRR;        /*!< USART Baud rate register,                Address offset: 0x08 */
  uint32_t CR1;        /*!< USART Control register 1,                Address offset: 0x0C */
  uint32_t CR2;        /*!< USART Control register 2,                Address offset: 0x10 */
  uint32_t CR3;        /*!< USART Control register 3,                Address offset: 0x14 */
  uint32_t GTPR;       /*!< USART Guard time and prescaler register, Address offset: 0x18 */
} USART_TypeDef;


volatile USART_TypeDef * const UART0 = (USART_TypeDef *)0x40013800;


void print_uart0(const char *s)
{
    while(*s != '\0') 
    {
        UART0->DR = (unsigned int)(*s);
        s++;
    }
}


void test_task (void *argument)
{

  for(;;)
	{
		
		print_uart0("Hello world from TASK !!\n");
		
		osDelay(1000);
	}
}


int main (void) 
{
  //SystemCoreClockUpdate();
	print_uart0("Hello world from KEIL !!\n");

  osKernelInitialize();                     /* Initialize CMSIS-RTOS */
  osThreadNew(test_task, NULL, NULL);        /* Create application main thread */
  if (osKernelGetState() == osKernelReady) 
	{
    osKernelStart();                        /* Start thread execution */
  }

  while(1);
}
