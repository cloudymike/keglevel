use <displayMount.scad>
use <boardMount.scad>



$fn=64;

thickness=2;
boxX=160;
boxY=150;
scaleD=210;
boardHeight=20;
frame=8;
boxHeight=55;

displayHeight=32;

displayY=20+displayHeight/2-boxY/2;

boardX=89;


module top()
{
    difference()
    {
        union()
        {
          difference()
            {
            translate([0,0,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
            translate([0,0,boxHeight/2+thickness])cube([boxX-2*thickness,boxY-2*thickness,boxHeight],center=true);
            }
            difference(){
             translate([0,scaleD/2+boardHeight,boxHeight/2])
                cylinder(d=scaleD+2*thickness,h=boxHeight,center=true);
             translate([scaleD/2+boxX/2,scaleD/2+boardHeight,boxHeight/2])cube([scaleD,scaleD,boxHeight],center=true);
             translate([-scaleD/2-boxX/2,scaleD/2+boardHeight,boxHeight/2])cube([scaleD,scaleD,boxHeight],center=true);
             translate([0,1.5*boxY,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
            }
    
        }
        //Remove displayfront
        translate([0,displayY,0])cube([132,displayHeight,thickness*10],center=true);
        translate([0,scaleD/2+boardHeight,0])cylinder(d=scaleD,h=1000,center=true);
    }
    
    
    
    //translate([0,displayY,0])displayFront();
    translate([boxX/2-boardX-thickness-1,boardHeight-thickness,28])rotate([0,90,0])mountPlate();
}


difference()
{
top();
    translate([0,0,boxHeight/2+12])cube([boxX,boxY,boxHeight],center=true);
    translate([-20,0,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
    translate([0,-70,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
}