# Stack Overflow Check

## Overview

  - Currently NuttX supports three types of stack overflow detection:
    
    1.  Stack Overflow Software Check
    2.  Stack Overflow Hardware Check
    3.  Stack Canary Check

  - The software stack detection includes two implementation ideas:
    
    1.  Implemented by coloring the stack memory
    2.  Implemented by comparing the sp and sl registers

## Support

Software and hardware stack overflow detection implementation, currently
only implemented on ARM Cortex-M (32-bit) series chips Stack Canary
Check is available on all platforms

## Stack Overflow Software Check

1.    - Memory Coloring Implementation Principle
        
        1.  Before using the stack, Thread will refresh the stack area
            to 0xdeadbeef
        2.  When Thread is running, it will overwrite 0xdeadbeef
        3.  up\_check\_tcbstack() detects 0xdeadbeef to get the stack
            peak value
        
        <!-- end list -->
        
          - Usage:  
            Enable CONFIG\_STACK\_COLORATION

2.    - Compare sp and sl  
        When compiling the program, keep r10 and use r10 as stackbase::
        ''' ARCHOPTIMIZATION += -finstrument-functions -ffixed-r10
        
        Each function will automatically add the following when entering
        and exiting: \_\_cyg\_profile\_func\_enter
        \_\_cyg\_profile\_func\_exit
        
          - Usage:  
            Enable CONFIG\_ARMV8M\_STACKCHECK or
            CONFIG\_ARMV7M\_STACKCHECK

## Stack Overflow Hardware Check

1.  Set MSPLIM PSPLIM when context switching
2.  Each time sp is operated, the hardware automatically compares sp and
    PSPLIM. If sp is lower than PSPLIM, crash

<!-- end list -->

  - Usage:  
    Enable CONFIG\_ARMV8M\_STACKCHECK\_HARDWARE

## Stack Canary Check

1.  Add a canary value to the stack
2.  When the thread is running, the canary value is overwritten
3.  When the thread is running, the canary value is compared with the
    original value
4.  If the value is different, it means that the stack is overflowed

<!-- end list -->

  - Usage:  
    Enable CONFIG\_STACK\_CANARIES
