PORT_A_DATA equ 0x8
PORT_A_CONTROL equ 0x9
PORT_B_DATA equ 0xE
PORT_B_CONTROL equ 0xF

CTC_CHANNEL_0 equ 0x18
CTC_CHANNEL_1 equ 0x19
CTC_CHANNEL_2 equ 0x1E
CTC_CHANNEL_3 equ 0x1F

MODE_0 equ 0x0F

Start:
    di
    nop
    nop
PioInit:
    ld a, MODE_0
    ld c, PORT_A_CONTROL
    out (c), a ; Set mode 0 on the PIO

    nop
PioOutput:
    ld a, 0b10101010
    ld c, PORT_A_DATA
    out (c), a ; Sets the output bits
CtcInit:
    ld a, 0b00000111
    ld c, CTC_CHANNEL_1
    out (c), a ; Initialize channel 1

    nop

    ld a, 0x02
    ld c, CTC_CHANNEL_1
    out (c), a

    ld a, 0b00000101
    ld c, CTC_CHANNEL_2
    out (c), a ; Initialize channel 2

    ld a, 0x02
    ld c, CTC_CHANNEL_2
    out (c), a

    ld a, 0b00000111
    ld c, CTC_CHANNEL_0
    out (c), a ; Initialize channel 0

    ld a, 0x02
    ld c, CTC_CHANNEL_0
    out (c), a
End:
    halt
