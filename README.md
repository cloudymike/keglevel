# Keg level
The project was inspired by this project
https://byo.com/project/diy-keg-beer-level-management-system

This will check the weight of kegs and translate that 
into a gauge display showing how full the kegs are.

This is for a two keg with 2.5Gallons kegs. For different
size kegs, change the empty_keg and full_keg variables
in top of main.py

The display is intended to be mounted in a (Custom) keg
tower top. A 24LED neopixel ring should fit on a 3inch
keg tower top.

For the scale hardware use the printfiles from the above project,
see Thingiverse 
https://www.thingiverse.com/thing:6007574

## TODO
* Seems like sensors resets, maybe just a modeling issue
* Tare the scales in a simple way. Probably when kegs are
  swapped
