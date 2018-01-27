#include <stdio.h>
#include <stdlib.h>
#include <bcm2835.h>
#include <err.h>

void
bcm2835w_spi_setClockDivider(uint32_t divider)
{
  uint16_t div = (uint16_t) (divider & 0xffff);
  bcm2835_spi_setClockDivider(div);
}
