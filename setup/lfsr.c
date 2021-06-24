#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

// 10-bit long LFSR: argument is polynomial taps
int main(int argc, char* argv[])
{
    uint16_t lfsr = 0x01;
    unsigned period = 0;
    char s[10+1];
    uint16_t poly=0x204;
    if (argc>1) {poly=strtol(argv[1],NULL,16);printf("polynom: %x\n",poly);}
    do {
          unsigned lsb = lfsr & 1;  /* Get lsb (i.e., the output bit). */
          lfsr >>= 1;               /* Shift register */
          if (lsb == 1)             /* Only apply toggle mask if output bit is 1. */
            lfsr ^= poly;           /* Apply toggle mask, value has 1 at bits corresponding*/
                                    /* to taps, 0 elsewhere. */
          ++period;
          printf("%d ", lfsr&1);
    } while(lfsr != 0x01u);
    printf("\nperiod: %d\n",period); // check 2^10-1 long sequence
    return 0;
}
