import time
from hx711 import *
from machine import Pin, I2C
import ssd1306
import os
import gfx
import bignumber
import pinassign


hx = HX711(pinassign.pin_SCK, pinassign.pin_OUT)
hx.offset = 12.9
hx.set_gain(128)
time.sleep_ms(50)
scale = 420
hx.set_scale(scale)

# setup display

# ESP32 Pin assignment
i2c = I2C(-1, pinassign.scl, pinassign.sda)

oled_width = 128
oled_height = 64
oled = ssd1306.SSD1306_I2C(oled_width, oled_height, i2c)

oled.text('Starting up...', 0, 20)

oled.show()
time.sleep_ms(1000)

# Keg specifics
empty_keg = 3.4
full_keg = 12.25
delta_keg=full_keg-empty_keg
max_weight=50
pint_weight=0.473
gallon_weight=3.785411784

while True:
    data = hx.read()/scale
    good_data = hx.get_units()
    kd1=max(good_data-empty_keg,0)
    kd2=min(kd1,delta_keg)
    keg_fract = kd2/delta_keg
    keg_percent=int(100*keg_fract)
    #pints=int(kd2/pint_weight)
    gallons=round(kd2/gallon_weight,2)

    print(data, good_data, keg_percent,gallons)
    oled.fill(0)
    #oled.text(str(int(2*good_data)),0,0)
    gallon_string=str(gallons)
    #oled.text(gallon_string,0,0)
    bignumber.twoDecimal(oled, gallons)
    graphics = gfx.GFX(oled_width, oled_height, oled.pixel)
    histo=int(oled_height*keg_fract)
    histo_width=25
    #bar=int(oled_width*keg_fract)
    graphics.fill_rect(oled_width-histo_width, oled_height-histo, histo_width, histo,1)
    #graphics.fill_rect(0, 59, bar, 10,1)

    oled.show()
    time.sleep(1)