#include <Arduino.h>
#include <TVout.h>
#include <stdint.h>

#include "font.h"
#include "utils.h"
#include "commands.h"

#define BAUDRATE 3884
#define HORIZONTAL_RESOLUTION 128
#define VERTICAL_RESOLUTION 96

TVout TV;

// TODO: Rewrite this 
void handle_data(const char* data, int data_length) {
  switch (data[0])
  {
    case SET_CURSOR_COMMAND:
    {
      if(data_length < SET_CURSOR_COMMAND_LENGTH) {
        Serial.println("ERROR");
        return;
      }

      uint8_t x = data[1];
      uint8_t y = data[2];

    #ifdef DEBUG
      Serial.print("Setting cursor: x - ");
      Serial.print(x);
      Serial.print(" ; y - ");
      Serial.print(y);
      Serial.println();
    #endif

      TV.set_cursor(x, y);
      return;
    }
    case SET_PIXEL_COMMAND:
    {
      if(data_length < SET_PIXEL_COMMAND_LENGTH) {
        Serial.println("ERROR");
        return;
      }

      uint8_t x = data[1];
      uint8_t y = data[2];
      char c = data[3];

    #ifdef DEBUG
      Serial.print("Setting pixel: x - ");
      Serial.print(x);
      Serial.print(" ; y - ");
      Serial.print(y);
      Serial.print(" ; character - ");
      Serial.print(c);
      Serial.println();
    #endif

      TV.set_pixel(x, y, c);
      return;
    }
    case FILL_SCREEN_COMMAND:
    {
      if(data_length < FILL_SCREEN_COMMAND_LENGTH) {
        Serial.println("ERROR");
        return;
      }

      uint8_t color = data[1];

    #ifdef DEBUG
      Serial.print("Filling screen: color - ");
      Serial.print(color);
      Serial.println();
    #endif

      TV.fill(color);
      return;
    }
    default:
    {
      TV.print(const_cast<char*>(data));
      break;
    }
  }
}

void setup() {
  Serial.begin(BAUDRATE);

  TV.begin(PAL, HORIZONTAL_RESOLUTION, VERTICAL_RESOLUTION);
  TV.select_font(font6x8);
}

void loop() {
  if(Serial.available() == 0) return;

  String data = Serial.readStringUntil('\x00');
  Serial.println(data); // Echo data back

  if(data.length() < 2) {
    return;
  }

  handle_data(data.c_str(), data.length());
}