# Keep the pinout in a separate file
# to make change to new hardware easier

from machine import Pin

# Setup load cell amplifier
pin_OUT = Pin(12, Pin.IN, pull=Pin.PULL_DOWN)
pin_SCK = Pin(15, Pin.OUT)


oledReset=Pin(16, Pin.OUT)
scl=Pin(22)
sda=Pin(21)

