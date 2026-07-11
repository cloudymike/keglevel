#!/bin/bash

USBPORT=$(ls /dev/ | grep -e ACM)
if [ "$USBPORT" = "" ]
then
USBPORT=$(ls /dev/ | grep -e USB)
fi
PORT=/dev/$USBPORT
echo Port used $PORT


CURDIR=$(pwd)
TOPDIR=${CURDIR%/*}

ampy --port $PORT put  ssd1306.py
ampy --port $PORT put  ./../libraries/micropython-max7219/max7219.py
ampy --port $PORT put  gfx.py
ampy --port $PORT put  bignumber.py

ampy --port $PORT put  hx711.py
ampy --port $PORT put  pinassign.py
ampy --port $PORT put  main.py
timeout 2  ampy --port $PORT run reset.py
