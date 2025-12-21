PORT_A_DATA equ 0x8
PORT_A_CONTROL equ 0x9
PORT_B_DATA equ 0xE
PORT_B_CONTROL equ 0xF

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
	
	ld a, 0b10101010
	ld c, PORT_A_DATA
	out (c), a ; Sets the output bits
End:
	halt