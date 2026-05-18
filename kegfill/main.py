import time
from hx711 import *
from machine import Pin, I2C
import ssd1306
import os
import gfx
import bignumber
import pinassign

# setup display
i2c = I2C(-1, pinassign.scl, pinassign.sda)
oled_width = 128
oled_height = 64
oled = ssd1306.SSD1306_I2C(oled_width, oled_height, i2c)

oled.text('Taring scale...', 0, 20)
oled.show()
time.sleep_ms(1000)

# Setup scale Calibrate to kg
hx = HX711(pinassign.pin_SCK, pinassign.pin_OUT)
hx.set_offset(0);
hx.set_gain(128)
hx.set_scale(-28000)
hx.set_time_constant(1)

time.sleep_ms(50)

hx.tare()

#
# Keg specifics
empty_keg = 3.4
full_keg = 12.25
delta_keg=full_keg-empty_keg
max_weight=50
pint_weight=0.473
gallon_weight=3.785411784



while True:
    data = hx.read()
    offset_data = hx.get_value();
    kg_data = hx.get_units()
    gallon_data=kg_data/gallon_weight

    #Tare empty scale (no keg)
    #kd1=max(kg_data-empty_keg,0)
    #kd2=min(kd1,delta_keg)
    #keg_fract = kd2/delta_keg
    #keg_percent=int(100*keg_fract)
    #pints=int(kd2/pint_weight)
    #gallons=round(kd2/gallon_weight,2)

    # Tare with empty keg
    gallons=round(gallon_data,2)
    keg_fract = gallon_data/2.5


    print(data, offset_data, kg_data,keg_fract,gallons)
    oled.fill(0)
    gallon_string=str(gallons)
    bignumber.twoDecimal(oled, gallons)
    graphics = gfx.GFX(oled_width, oled_height, oled.pixel)
    histo=int(oled_height*keg_fract)
    histo_width=25
    graphics.fill_rect(oled_width-histo_width, oled_height-histo, histo_width, histo,1)

    oled.show()
    time.sleep(1)