
#include <stdio.h>
#include <stdint.h>


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

int puts(const char* str)
{
    print_uart0(str);
}

volatile int test = 0;

int main(void)
{
    print_uart0("He he he ale zrobilem program !!!!\n");

    printf("no i printf'em tez wyswietlane !!\n");

    for(;;)
    {
        test++;
        test += 2;
        test += 4;
    }
}

