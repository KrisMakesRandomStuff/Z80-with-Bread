/**
 * Generated Pins header File
 * 
 * @file pins.h
 * 
 * @defgroup  pinsdriver Pins Driver
 * 
 * @brief This is generated driver header for pins. 
 *        This header file provides APIs for all pins selected in the GUI.
 *
 * @version Driver Version  3.0.0
*/

/*
© [2025] Microchip Technology Inc. and its subsidiaries.

    Subject to your compliance with these terms, you may use Microchip 
    software and any derivatives exclusively with Microchip products. 
    You are responsible for complying with 3rd party license terms  
    applicable to your use of 3rd party software (including open source  
    software) that may accompany Microchip software. SOFTWARE IS ?AS IS.? 
    NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS 
    SOFTWARE, INCLUDING ANY IMPLIED WARRANTIES OF NON-INFRINGEMENT,  
    MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT 
    WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
    INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY 
    KIND WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF 
    MICROCHIP HAS BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE 
    FORESEEABLE. TO THE FULLEST EXTENT ALLOWED BY LAW, MICROCHIP?S 
    TOTAL LIABILITY ON ALL CLAIMS RELATED TO THE SOFTWARE WILL NOT 
    EXCEED AMOUNT OF FEES, IF ANY, YOU PAID DIRECTLY TO MICROCHIP FOR 
    THIS SOFTWARE.
*/

#ifndef PINS_H
#define PINS_H

#include <xc.h>

#define INPUT   1
#define OUTPUT  0

#define HIGH    1
#define LOW     0

#define ANALOG      1
#define DIGITAL     0

#define PULL_UP_ENABLED      1
#define PULL_UP_DISABLED     0

// get/set IO_RC4 aliases
#define RESET_n_TRIS                 TRISCbits.TRISC4
#define RESET_n_LAT                  LATCbits.LATC4
#define RESET_n_PORT                 PORTCbits.RC4
#define RESET_n_WPU                  WPUCbits.WPUC4
#define RESET_n_OD                   ODCONCbits.ODCC4
#define RESET_n_ANS                  ANSELCbits.ANSC4
#define RESET_n_SetHigh()            do { LATCbits.LATC4 = 1; } while(0)
#define RESET_n_SetLow()             do { LATCbits.LATC4 = 0; } while(0)
#define RESET_n_Toggle()             do { LATCbits.LATC4 = ~LATCbits.LATC4; } while(0)
#define RESET_n_GetValue()           PORTCbits.RC4
#define RESET_n_SetDigitalInput()    do { TRISCbits.TRISC4 = 1; } while(0)
#define RESET_n_SetDigitalOutput()   do { TRISCbits.TRISC4 = 0; } while(0)
#define RESET_n_SetPullup()          do { WPUCbits.WPUC4 = 1; } while(0)
#define RESET_n_ResetPullup()        do { WPUCbits.WPUC4 = 0; } while(0)
#define RESET_n_SetPushPull()        do { ODCONCbits.ODCC4 = 0; } while(0)
#define RESET_n_SetOpenDrain()       do { ODCONCbits.ODCC4 = 1; } while(0)
#define RESET_n_SetAnalogMode()      do { ANSELCbits.ANSC4 = 1; } while(0)
#define RESET_n_SetDigitalMode()     do { ANSELCbits.ANSC4 = 0; } while(0)
// get/set IO_RC5 aliases
#define RESET_TRIS                 TRISCbits.TRISC5
#define RESET_LAT                  LATCbits.LATC5
#define RESET_PORT                 PORTCbits.RC5
#define RESET_WPU                  WPUCbits.WPUC5
#define RESET_OD                   ODCONCbits.ODCC5
#define RESET_ANS                  ANSELCbits.ANSC5
#define RESET_SetHigh()            do { LATCbits.LATC5 = 1; } while(0)
#define RESET_SetLow()             do { LATCbits.LATC5 = 0; } while(0)
#define RESET_Toggle()             do { LATCbits.LATC5 = ~LATCbits.LATC5; } while(0)
#define RESET_GetValue()           PORTCbits.RC5
#define RESET_SetDigitalInput()    do { TRISCbits.TRISC5 = 1; } while(0)
#define RESET_SetDigitalOutput()   do { TRISCbits.TRISC5 = 0; } while(0)
#define RESET_SetPullup()          do { WPUCbits.WPUC5 = 1; } while(0)
#define RESET_ResetPullup()        do { WPUCbits.WPUC5 = 0; } while(0)
#define RESET_SetPushPull()        do { ODCONCbits.ODCC5 = 0; } while(0)
#define RESET_SetOpenDrain()       do { ODCONCbits.ODCC5 = 1; } while(0)
#define RESET_SetAnalogMode()      do { ANSELCbits.ANSC5 = 1; } while(0)
#define RESET_SetDigitalMode()     do { ANSELCbits.ANSC5 = 0; } while(0)
/**
 * @ingroup  pinsdriver
 * @brief GPIO and peripheral I/O initialization
 * @param none
 * @return none
 */
void PIN_MANAGER_Initialize (void);

/**
 * @ingroup  pinsdriver
 * @brief Interrupt on Change Handling routine
 * @param none
 * @return none
 */
void PIN_MANAGER_IOC(void);


#endif // PINS_H
/**
 End of File
*/