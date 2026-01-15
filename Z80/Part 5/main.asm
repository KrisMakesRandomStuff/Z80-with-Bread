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

GPU_FILL_COMMAND equ 0x12

CR_CHAR equ 0xD
LF_CHAR equ 0xA
NULL_CHAR equ 0x00

BLACK equ 0x00

MODE_0 equ 0x0F

Start:
    di ; Disable interrupts
    ld a, 0 ; Set A to 0
    ld sp, 0xffff ; Initialize stack pointer to the top of the ram
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
TestDisplay:
    call ClearDisplay
    call WordDelay

    ld bc, InitializationText
    call WriteString

    ld bc, HelloWorld
    call WriteString
End:
    halt

ClearDisplay:
    ld a, GPU_FILL_COMMAND
    call WriteCharacter

    ld a, BLACK 
    call WriteCharacter 

    ; We don't have to send a null byte
    ; because the black is 0x00 and it
    ; substitutes the null byte

    ret

WriteString:
    ; Put the starting character into BC
WriteStringLoop:
    ld a, (bc) ; Load starting character into A
    cp NULL_CHAR ; Check if A is null byte
    jp z, WriteStringEnd ; If A is 0, jump to end
    call WriteCharacter ; Write the character to the gpu

    inc bc ; Increment BC to get the other character
    jp WriteStringLoop ; Loop to the start
WriteStringEnd:
    ld a, CR_CHAR 
    call WriteCharacter ; Write carriage return

    ld a, LF_CHAR
    call WriteCharacter ; Write line feed

    ld a, NULL_CHAR
    call WriteCharacter ; Write null byte

    call WordDelay ; Add some delay between words
    ret

WaitForTxEmpty:
    ; Waits for the TX buffer to be all sent
WaitTxLoop:
    ld a, 1
    out (SIO_CHANNEL_A_CONTROL), a ; Select read register 1
    in a, (SIO_CHANNEL_A_CONTROL) ; Store the read register in A

    bit 0, a
    jp z, WaitTxLoop ; Loop back if the data is still being transmitted
    ret

WordDelay:
    ; Delay for aproximatly 2.8 ms
    ld b, 0xff 
DelayInner:
    nop
    djnz DelayInner
    ret

WriteCharacter:
    ; Writes the character in A to the SIO channel A data
    out (SIO_CHANNEL_A_DATA), a
    call WaitForTxEmpty
    ret

HelloWorld:
    defb "Hello from Z80"
    defb 0 ; Null byte
InitializationText:
    defb "Init complete"
    defb 0 ; Null byte