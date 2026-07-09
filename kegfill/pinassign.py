# Keep the pinout in a separate file
# to make change to new hardware easier

from machine import Pin

# Setup load cell amplifier
pin_OUT = Pin(2, Pin.IN, pull=Pin.PULL_DOWN)
pin_SCK = Pin(1, Pin.OUT)


scl=Pin(9)
sda=Pin(8)

