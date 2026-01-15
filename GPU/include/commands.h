#pragma once
#include <Arduino.h>

#define SET_CURSOR_COMMAND '\x10'
#define SET_CURSOR_COMMAND_LENGTH 4 // 0x10 x y 0x00

#define SET_PIXEL_COMMAND '\x11'
#define SET_PIXEL_COMMAND_LENGTH 5 // 0x11 x y character 0x00

#define FILL_SCREEN_COMMAND '\x12'
#define FILL_SCREEN_COMMAND_LENGTH 3 // 0x12 color 0x00
