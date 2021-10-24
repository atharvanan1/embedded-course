#include "uart.h"
// UART Line Control Register
// UARTLCR_H
// Bit 4 - 0 for disabled, 1 for enable

// UART Control Register
// UARTCR
// Bit 9 - RXE Receive Enable 1 for enable, 0 for disable
// Bit 8 - TXE Transmit Enable 1 for enable, 0 for disable
// Bit 0 - UARTEN 0 for disable, 1 for enable

// UART Raw Interrupt Status Register
// UARTRIS
// Bit 5 - TX Interrupt status
// HIGH if FIFO is not at the desired level
// Bit 4 - RX Interrupt status
// HIGH if the FIFO is at the desired level

// UART Interrupt FIFO Level Select Register
// UARTIFLS
// Bit 5:3 = b000 for 1/8 full
// Bit 2:0 = b100 for 7/8 full

volatile unsigned int* const UARTDR     = (unsigned int *) UARTDR_ADDRESS;
volatile unsigned int* const UARTLCRH   = (unsigned int *) UARTLCRH_ADDRESS;
volatile unsigned int* const UARTCR     = (unsigned int *) UARTCR_ADDRESS;
volatile unsigned int* const UARTIFLS   = (unsigned int *) UARTIFLS_ADDRESS;
volatile unsigned int* const UARTFR    = (unsigned int *) UARTFR_ADDRESS;
volatile unsigned int* const UARTICR    = (unsigned int *) UARTICR_ADDRESS;
volatile unsigned int* const UARTRIS    = (unsigned int *) UARTRIS_ADDRESS;

void setup_uart0(void)
{
    // Disable UART
    // Clear Bit 0
    // b0000 0000 0000 0001 (NOT)
    // b1111 1111 1111 1110 (AND)
    *UARTCR &= ~(0x0001);
    // Set Interrupt Level for UART to RX 1/8th and TX 7/8th
    *UARTIFLS = 0x04; // b00 000 100 = b0000 0100
    // Enable FIFO
    *UARTLCRH |= 0x10; // b0001 0000
    // Clear all interrupts
    *UARTICR = 0xFFFF;
    // Enable UART, TX, RX
    *UARTCR |= 0x0301; // b0000 0011 0000 0001
}

int getch(void)
{
    while(!(*UARTRIS & 0x0010));  //b0000 0000 0001 0000
    return *UARTDR & 0x00FF;
}

void putch(int character)
{
    if(!(*UARTFR & 0x0080))
        while(!(*UARTFR & 0x0080));
    *UARTDR = (unsigned int)(character);
}

void puts(char* str)
{
    char* str_char = str;
    while(*str_char != '\0') {
        putch(*str_char);
        str_char++;
    }
}

int main(void)
{
    setup_uart0();
    puts("Hello, World!\n");
    puts("This program will repeat the characters\n");
    int c;
    while ((c = getch())) {
        if (c == '\r') {
            putch('\n');
        }
        putch(c);
    }
    while(1);
    return 0;
}
