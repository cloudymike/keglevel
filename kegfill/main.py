import time
from hx711 import *
from machine import Pin, SPI
import max7219
import os
import gfx
import bignumber
import pinassign

# setup display
spi = SPI(1, baudrate=10000000)
screen = max7219.Max7219(32, 8, spi, Pin(10))

screen.text('Tare', -1, 0, 1)
screen.show()
time.sleep_ms(1000)

# Setup scale Calibrate to kg
hx = HX711(pinassign.pin_SCK, pinassign.pin_OUT)
hx.set_offset(0);
hx.set_gain(128)
hx.set_scale(-21160)
hx.set_time_constant(1)

time.sleep(5)

hx.tare(25)

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

    # Tare with empty keg
    gallons=round(gallon_data,2)
    kg=round(kg_data,2)
    keg_fract = gallon_data/2.5


    print(data, offset_data, kg_data,keg_fract,gallons)
    screen.fill(0)
    gallon_string=str(gallons)
    screen.text(gallon_string, 0, 0, 1)

    screen.show()
    time.sleep(0.5)