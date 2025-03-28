ringHeight=3;
capHeight=2;
kegTowerOD=3*25.4;
wallThickness=4;
overlap=20;
screenCoverThickness=0.4;

module neopixelRing(ledCount=24)
{
    // https://www.amazon.com/DIYmall-WS2812B-Integrated-Addressable-Raspberry/dp/B0C7CC3267
    ledOD = ledCount==24 ? 66 : 0 ;
    ledID = ledCount==24 ? 52 : 0 ;
    ledH=ringHeight+capHeight;
    
    difference()
    {
        cylinder(d=ledOD,h=ledH,center=true,$fn=128);
        cylinder(d=ledID,h=ledH,center=true,$fn=128);
    }
}


module plainCap()
{

  cylinder(h=ringHeight,d=kegTowerOD-2*wallThickness, center=true,$fn=128);
  translate([0,0,-(ringHeight+capHeight)/2])cylinder(d=kegTowerOD,h=capHeight, center=true, $fn=128);

  pegD=0.5;
  translate([(kegTowerOD-2*wallThickness-pegD)/2,0,0])cylinder(d=pegD,h=ringHeight,center=true, $fn=64);
  translate([-(kegTowerOD-2*wallThickness-pegD)/2,0,0])cylinder(d=pegD,h=ringHeight,center=true, $fn=64);
  translate([0,(kegTowerOD-2*wallThickness-pegD)/2,0])cylinder(d=pegD,h=ringHeight,center=true, $fn=64);
  translate([0,-(kegTowerOD-2*wallThickness-pegD)/2,0])cylinder(d=pegD,h=ringHeight,center=true, $fn=64);
  
}

module cap()
{
    difference()
    {
        plainCap();
        translate([0,0,screenCoverThickness-capHeight/2])neopixelRing(24);
    }
}


cap();