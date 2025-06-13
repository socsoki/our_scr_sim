#include <inttypes.h>
#define UART_TX_ADDR 0xf0000004
#define UART_TX_FULL 0xf000000b

int main() {
    int a = 8;
    int b = 12;
    int c = 13;
    a = a + b + c;
    *((uint32_t *) UART_TX_ADDR) = a;
    return a;
}