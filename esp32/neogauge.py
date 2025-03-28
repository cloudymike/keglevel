# Create two gauges that sets gauge based on 
# percent (0-100) input 
from machine import Pin
from neopixel import NeoPixel
import time

class neoGauge:
    def __init__(self,dataPin=15, size=24):
        
        self.ringSize=size
        self.pixels = NeoPixel(Pin(dataPin), self.ringSize)
        self.right = 0
        self.left = 0

    def gaugeTwo(self, left,right):
        self.left=left
        self.rigt=right
        self.gaugeSide(left,0)
        self.gaugeSide(right,1)
        self.pixels.write()

    def gaugeSide(self, percent, side):
        sideRingSize=int(self.ringSize/2)-1
        l0=sideRingSize+2
        r0=sideRingSize
        self.pixels[0]=(0,0,255)
        self.pixels[sideRingSize+1]=(255,255,255)

        pixelOn=int(percent*sideRingSize/100)
        if percent < 10:
            color=(255,0,0)
        elif percent < 33:
            color=(255,255,0)
        else:
            color=(0,255,0)

        for i in range(sideRingSize):
            pixIndex=r0-i if side else i+l0
            if i<=pixelOn:
                self.pixels[pixIndex]=color
            else:
                self.pixels[pixIndex]=(0,0,0)

#Simple example showing how it works
if __name__ == "__main__":
    # Ring Size 24 is OD=72mm
    # Data pin 15,no clock pin used
    gauge=neoGauge(2,24)
    while True:
        for p in range(101):
            gauge.gaugeTwo(p,(3*p)%100)
            time.sleep(0.01)
