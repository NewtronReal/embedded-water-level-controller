#include <lpc214x.h>

#define LOW_TH   100
#define HIGH_TH  200

int main(void)
{
    unsigned int level;

    // Set P0.10 as output (pump control)
    IO0DIR |= (1 << 10);

    // Ensure pump is OFF initially
    IO0CLR = (1 << 10);

    while (1)
    {
        // Read 8-bit water level from P0.0–P0.7
        level = IO0PIN & 0xFF;

        if (level < LOW_TH)
        {
            // LOW ? Pump ON
            IO0SET = (1 << 10);
        }
        else if (level >= HIGH_TH)
        {
            // HIGH ? Pump OFF
            IO0CLR = (1 << 10);
        }
        else
        {
            // MEDIUM ? Do nothing (retain previous state)
        }
    }
}