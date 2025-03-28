import time
from hx711 import *
from machine import Pin, I2C
from neogauge import neoGauge
import os

# Keg specifics
empty_keg = 3.4
full_keg = 12.25
delta_keg=full_keg-empty_keg
max_weight=50
pint_weight=0.473


def data2percent(data):
    kd1=max(data-empty_keg,0)
    kd2=min(kd1,delta_keg)
    keg_fract = kd2/delta_keg
    percent=int(100*keg_fract)
    return(percent)




    
# Setup left load cell amplifier
pinLeftOUT = Pin(12, Pin.IN, pull=Pin.PULL_DOWN)
pinLeftSCK = Pin(15, Pin.OUT)
hxLeft = HX711(pinLeftSCK, pinLeftOUT)
hxLeft.offset = 12.9
hxLeft.set_gain(128)
time.sleep_ms(50)
scale = 420
hxLeft.set_scale(scale)

# Setup right load cell amplifier
pinRightOUT = Pin(2, Pin.IN, pull=Pin.PULL_DOWN)
pinRightSCK = Pin(4, Pin.OUT)
hxRight = HX711(pinRightSCK, pinRightOUT)
hxRight.offset = 12.9
hxRight.set_gain(128)
time.sleep_ms(50)
scale = 420
hxRight.set_scale(scale)


gauge=neoGauge(13,24)

while True:
    leftPercent=data2percent(hxLeft.get_units())
    time.sleep(0.2)
    rightPercent=data2percent(hxRight.get_units())
    time.sleep(0.2)
    print(leftPercent,rightPercent)

    gauge.gaugeTwo(leftPercent,rightPercent)
    time.sleep(0.2)
