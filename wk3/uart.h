#ifndef _UART_H_
#define _UART_H_

#define UART_BASE               0x09000000
#define UARTDR_OFFSET           0x00000000
#define UARTLCRH_OFFSET         0x0000002c
#define UARTCR_OFFSET           0x00000030
#define UARTIFLS_OFFSET         0x00000034
#define UARTFR_OFFSET           0x00000018
#define UARTRIS_OFFSET          0x0000003c
#define UARTICR_OFFSET          0x00000044
#define UARTDR_ADDRESS          (UART_BASE + UARTDR_OFFSET)
#define UARTLCRH_ADDRESS        (UART_BASE + UARTLCRH_OFFSET)
#define UARTCR_ADDRESS          (UART_BASE + UARTCR_OFFSET)
#define UARTIFLS_ADDRESS        (UART_BASE + UARTIFLS_OFFSET)
#define UARTFR_ADDRESS          (UART_BASE + UARTFR_OFFSET)
#define UARTICR_ADDRESS         (UART_BASE + UARTICR_OFFSET)
#define UARTRIS_ADDRESS         (UART_BASE + UARTRIS_OFFSET)

void setup_uart0(void);
int getch(void);
void putch(int);
void puts(char *str);
#endif // _UART_H_