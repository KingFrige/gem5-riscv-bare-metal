#include "ns16550a.h"

int main() {
  char p = 'h';
  uartinit();
  uartputc(p);
  p++;
  uartputc(p);

  while(1){;}

  return 0;
}

