use <displayMount.scad>

thickness=2;
boxX=160;
boxY=150;
scaleD=210;
frame=8;

displayHeight=32;

displayY=frame*2+displayHeight/2-boxY/2;


translate([0,displayY,-thickness/2])displayFront();

difference()
{
    cube([boxX,boxY,thickness],center=true);
    //Remove displayfront
    translate([0,displayY,0])cube([132,displayHeight,thickness*10],center=true);
    translate([0,scaleD/2,0])cylinder(d=scaleD,h=thickness*10,center=true);
}