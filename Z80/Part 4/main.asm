PORT_A_DATA equ 0x8
PORT_A_CONTROL equ 0x9
PORT_B_DATA equ 0xE
PORT_B_CONTROL equ 0xF

CTC_CHANNEL_0 equ 0x18
CTC_CHANNEL_1 equ 0x19
CTC_CHANNEL_2 equ 0x1E
CTC_CHANNEL_3 equ 0x1F

SIO_CHANNEL_A_DATA equ 0x10
SIO_CHANNEL_A_CONTROL equ 0x11
SIO_CHANNEL_B_DATA equ 0x16
SIO_CHANNEL_B_CONTROL equ 0x17

MODE_0 equ 0x0F

Start:
    di ; Disable interrupts
    ld a, 0 ; Set A to 0
PioInit:
    ld a, MODE_0
    ld c, PORT_A_CONTROL
    out (c), a ; Set mode 0 on the PIO port A

    ld c, PORT_B_CONTROL
    out (c), a ; Set mode 0 on port B

    ld a, 0
    ld c, PORT_A_DATA
    out (c), a ; Zero out port A
CtcInit:
    ld a, 0b00000111
    ld c, CTC_CHANNEL_1
    out (c), a ; Initialize channel 1

    ld a, 0x02
    ld c, CTC_CHANNEL_1 
    out (c), a ; Write 0x2 as the time constant

    ld a, 0b00000111
    ld c, CTC_CHANNEL_2
    out (c), a ; Initialize channel 2

    ld a, 0x02
    ld c, CTC_CHANNEL_2
    out (c), a ; Write 0x2 as the time constant

    ld a, 0b00000111
    ld c, CTC_CHANNEL_0
    out (c), a ; Initialize channel 0

    ld a, 0x02
    ld c, CTC_CHANNEL_0
    out (c), a ; Write 0x2 as the time constant
SioInit:
    ld a, 0b00110000
    ld c, SIO_CHANNEL_A_CONTROL
    out (c), a ; Init channel A

    ld a, 0b00011000
    out (c), a ; Reset channel A

    ld a, 0x4
    out (c), a ; Select register 4

    ld a, 0b01000100
    out (c), a ; x16, 1 stop, parity off

    ld a, 0x5
    out (c), a ; Select register 5

    ld a, 0b01101000
    out (c), a ; 8 bits, tx on, crc off

    ld a, 0x3
    out (c), a ; Select register 3

    ld a, 0b11000001
    out (c), a ; Rx on

    ld a, 0x1
    out (c), a ; Select register 1

    ld a, 0
    out (c), a ; SIO interrupts disabled

SioTest:
    ld a, 0
    ld c, SIO_CHANNEL_A_CONTROL
    out (c), a ; Select status register 0
    in a, (c) ; Read status register 0

    bit 0, a ; Test if character is available
    jp z, SioTest ; Loop if no character is received

    ld c, SIO_CHANNEL_A_DATA
    in a, (c) ; Load the character from RX buffer
    out (c), a ; Echo data back

    ld c, PORT_A_DATA
    out (c), a ; Output the character bits to LEDs

    jp SioTest
End:
    halt
