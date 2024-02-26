/******************************************************************************
 * @file     startup_CMSDK_CM0plus.S
 * @brief    CMSIS Startup File for CMSDK_CM0plus Device
 ******************************************************************************/
/* Copyright (c) 2022 ARM LIMITED

   All rights reserved.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:
   - Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   - Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.
   - Neither the name of ARM nor the names of its contributors may be used
     to endorse or promote products derived from this software without
     specific prior written permission.
   *
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   ARE DISCLAIMED. IN NO EVENT SHALL COPYRIGHT HOLDERS AND CONTRIBUTORS BE
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.
   ---------------------------------------------------------------------------*/


                .syntax  unified
                .arch    armv6-m

                #define __INITIAL_SP     Image$$ARM_LIB_STACK$$ZI$$Limit
                #define __STACK_LIMIT    Image$$ARM_LIB_STACK$$ZI$$Base

                .section RESET
                .align   2
                .globl   __Vectors
                .globl   __Vectors_End
                .globl   __Vectors_Size
__Vectors:
                .long    __INITIAL_SP                       /*     Initial Stack Pointer */
                .long    Reset_Handler                      /*     Reset Handler */
                .long    NMI_Handler                        /* -14 NMI Handler */
                .long    HardFault_Handler                  /* -13 Hard Fault Handler */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    SVC_Handler                        /*  -5 SVC Handler */
                .long    0                                  /*     Reserved */
                .long    0                                  /*     Reserved */
                .long    PendSV_Handler                     /*  -2 PendSV Handler */
                .long    SysTick_Handler                    /*  -1 SysTick Handler */

                /* Interrupts */
                .long    UART0RX_Handler                    /*   0 UART 0 receive interrupt */
                .long    UART0TX_Handler                    /*   1 UART 0 transmit interrupt */
                .long    UART1RX_Handler                    /*   2 UART 1 receive interrupt */
                .long    UART1TX_Handler                    /*   3 UART 1 transmit interrupt */
                .long    UART2RX_Handler                    /*   4 UART 2 receive interrupt */
                .long    UART2TX_Handler                    /*   5 UART 2 transmit interrupt */
                .long    GPIO0ALL_Handler                   /*   6 GPIO 0 combined interrupt */
                .long    GPIO1ALL_Handler                   /*   7 GPIO 1 combined interrupt */
                .long    TIMER0_Handler                     /*   8 Timer 0 interrupt */
                .long    TIMER1_Handler                     /*   9 Timer 1 interrupt */
                .long    DUALTIMER_Handler                  /*  10 Dual Timer interrupt */
                .long    SPI_0_1_Handler                    /*  11 SPI 0, 1 interrupt */
                .long    UART_0_1_2_OVF_Handler             /*  12 UART overflow (0, 1 & 2) interrupt */
                .long    ETHERNET_Handler                   /*  13 Ethernet interrupt */
                .long    I2S_Handler                        /*  14 Audio I2S interrupt */
                .long    TOUCHSCREEN_Handler                /*  15 Touch Screen interrupt */
                .long    GPIO2_Handler                      /*  16 GPIO 2 combined interrupt */
                .long    GPIO3_Handler                      /*  17 GPIO 3 combined interrupt */
                .long    UART3RX_Handler                    /*  18 UART 3 receive interrupt */
                .long    UART3TX_Handler                    /*  19 UART 3 transmit interrupt */
                .long    UART4RX_Handler                    /*  20 UART 4 receive interrupt */
                .long    UART4TX_Handler                    /*  21 UART 4 transmit interrupt */
                .long    SPI_2_Handler                      /*  22 SPI 2 interrupt */
                .long    SPI_3_4_Handler                    /*  23 SPI 3, 4 interrupt */
                #if defined CMSDK_CM0plus_VHT
                .long    ARM_VSI0_Handler                   /*  24 VSI 0 interrupt */
                .long    ARM_VSI1_Handler                   /*  25 VSI 1 interrupt */
                .long    ARM_VSI2_Handler                   /*  26 VSI 2 interrupt */
                .long    ARM_VSI3_Handler                   /*  27 VSI 3 interrupt */
                .long    ARM_VSI4_Handler                   /*  28 VSI 4 interrupt */
                .long    ARM_VSI5_Handler                   /*  29 VSI 5 interrupt */
                .long    ARM_VSI6_Handler                   /*  30 VSI 6 interrupt */
                .long    ARM_VSI7_Handler                   /*  31 VSI 7 interrupt */
                #else
                .long    GPIO0_0_Handler                    /*  24 GPIO 0 individual interrupt ( 0) */
                .long    GPIO0_1_Handler                    /*  25 GPIO 0 individual interrupt ( 1) */
                .long    GPIO0_2_Handler                    /*  26 GPIO 0 individual interrupt ( 2) */
                .long    GPIO0_3_Handler                    /*  27 GPIO 0 individual interrupt ( 3) */
                .long    GPIO0_4_Handler                    /*  28 GPIO 0 individual interrupt ( 4) */
                .long    GPIO0_5_Handler                    /*  29 GPIO 0 individual interrupt ( 5) */
                .long    GPIO0_6_Handler                    /*  30 GPIO 0 individual interrupt ( 6) */
                .long    GPIO0_7_Handler                    /*  31 GPIO 0 individual interrupt ( 7) */
                #endif
__Vectors_End:
                .equ     __Vectors_Size, __Vectors_End - __Vectors
                .size    __Vectors, . - __Vectors


                .thumb
                .section .text
                .align   2

                .thumb_func
                .type    Reset_Handler, %function
                .globl   Reset_Handler
                .fnstart
Reset_Handler:
                bl       SystemInit
                bl       __main

                .fnend
                .size    Reset_Handler, . - Reset_Handler


/* The default macro is not used for HardFault_Handler
 * because this results in a poor debug illusion.
 */
                .thumb_func
                .type    HardFault_Handler, %function
                .weak    HardFault_Handler
                .fnstart
HardFault_Handler:
                b        .
                .fnend
                .size    HardFault_Handler, . - HardFault_Handler

                .thumb_func
                .type    Default_Handler, %function
                .weak    Default_Handler
                .fnstart
Default_Handler:
                b        .
                .fnend
                .size    Default_Handler, . - Default_Handler

/* Macro to define default exception/interrupt handlers.
 * Default handler are weak symbols with an endless loop.
 * They can be overwritten by real handlers.
 */
                .macro   Set_Default_Handler  Handler_Name
                .weak    \Handler_Name
                .set     \Handler_Name, Default_Handler
                .endm


/* Default exception/interrupt handler */

                Set_Default_Handler  NMI_Handler
                Set_Default_Handler  SVC_Handler
                Set_Default_Handler  PendSV_Handler
                Set_Default_Handler  SysTick_Handler

                Set_Default_Handler  UART0RX_Handler
                Set_Default_Handler  UART0TX_Handler
                Set_Default_Handler  UART1RX_Handler
                Set_Default_Handler  UART1TX_Handler
                Set_Default_Handler  UART2RX_Handler
                Set_Default_Handler  UART2TX_Handler
                Set_Default_Handler  GPIO0ALL_Handler
                Set_Default_Handler  GPIO1ALL_Handler
                Set_Default_Handler  TIMER0_Handler
                Set_Default_Handler  TIMER1_Handler
                Set_Default_Handler  DUALTIMER_Handler
                Set_Default_Handler  SPI_0_1_Handler
                Set_Default_Handler  UART_0_1_2_OVF_Handler
                Set_Default_Handler  ETHERNET_Handler
                Set_Default_Handler  I2S_Handler
                Set_Default_Handler  TOUCHSCREEN_Handler
                Set_Default_Handler  GPIO2_Handler
                Set_Default_Handler  GPIO3_Handler
                Set_Default_Handler  UART3RX_Handler
                Set_Default_Handler  UART3TX_Handler
                Set_Default_Handler  UART4RX_Handler
                Set_Default_Handler  UART4TX_Handler
                Set_Default_Handler  SPI_2_Handler
                Set_Default_Handler  SPI_3_4_Handler
                #if defined CMSDK_CM0plus_VHT
                Set_Default_Handler  ARM_VSI0_Handler
                Set_Default_Handler  ARM_VSI1_Handler
                Set_Default_Handler  ARM_VSI2_Handler
                Set_Default_Handler  ARM_VSI3_Handler
                Set_Default_Handler  ARM_VSI4_Handler
                Set_Default_Handler  ARM_VSI5_Handler
                Set_Default_Handler  ARM_VSI6_Handler
                Set_Default_Handler  ARM_VSI7_Handler
                #else
                Set_Default_Handler  GPIO0_0_Handler
                Set_Default_Handler  GPIO0_1_Handler
                Set_Default_Handler  GPIO0_2_Handler
                Set_Default_Handler  GPIO0_3_Handler
                Set_Default_Handler  GPIO0_4_Handler
                Set_Default_Handler  GPIO0_5_Handler
                Set_Default_Handler  GPIO0_6_Handler
                Set_Default_Handler  GPIO0_7_Handler
                #endif

                .end
