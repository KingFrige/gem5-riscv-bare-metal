#include "ns16550a.h"

int main() {
  char p = 'h';
  uartinit();
  uartputc(p);
  p++;
  uartputc(p);
  uartputc('\n');

  while(1){;}

  return 0;
}

