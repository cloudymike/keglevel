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

screw_radius = 1.75;
corner_screw_distance = 5;
screwX=boxX/2-corner_screw_distance;
screwYin=46;
screwYout=-boxY/2+corner_screw_distance;


module top()
{
    difference()
    {
        union()
        {
          // square box
          difference()
            {
            translate([0,0,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
            translate([0,0,boxHeight/2+thickness])cube([boxX-2*thickness,boxY-2*thickness,boxHeight],center=true);
            }
            
            // cylinder wall
            difference(){
             translate([0,scaleD/2+boardHeight,boxHeight/2])
                cylinder(d=scaleD+2*thickness,h=boxHeight,center=true);
             translate([scaleD/2+boxX/2,scaleD/2+boardHeight,boxHeight/2])cube([scaleD,scaleD,boxHeight],center=true);
             translate([-scaleD/2-boxX/2,scaleD/2+boardHeight,boxHeight/2])cube([scaleD,scaleD,boxHeight],center=true);
             translate([0,1.5*boxY,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);

            }
    
    // screw columns
        translate([screwX,screwYout,boxHeight/2])
            cylinder(r=screw_radius + thickness,h=boxHeight, center=true);
        translate([-screwX,screwYout,boxHeight/2])
            cylinder(r=screw_radius + thickness,h=boxHeight, center=true);
        translate([screwX,screwYin,boxHeight/2])
            cylinder(r=screw_radius + thickness,h=boxHeight, center=true);
        translate([-screwX,screwYin,boxHeight/2])
            cylinder(r=screw_radius + thickness,h=boxHeight, center=true);
        }
        //Remove displayfront
        translate([0,displayY,0])cube([133,displayHeight,thickness*10],center=true);
        translate([0,scaleD/2+boardHeight,0])cylinder(d=scaleD,h=1000,center=true);
        
        //screwholes
        translate([screwX,screwYout,boxHeight/2])
            cylinder(r=screw_radius,h=boxHeight, center=true);
        translate([-screwX,screwYout,boxHeight/2])
            cylinder(r=screw_radius,h=boxHeight, center=true);
        translate([screwX,screwYin,boxHeight/2])
            cylinder(r=screw_radius,h=boxHeight, center=true);
        translate([-screwX,screwYin,boxHeight/2])
            cylinder(r=screw_radius,h=boxHeight, center=true);
        
        //cablenotch
        notchHeight=1;
        notchWidth=5;
        translate([0,0,boxHeight-notchHeight/2])cube([notchWidth,100,notchHeight],center=true);
        
        //mount screw holes
        offsetBottom=9;
        translate([0,scaleD/2+boardHeight,boxHeight-offsetBottom])rotate([90,0,30])cylinder(r=screw_radius,h=scaleD+4*thickness,center=true);
        translate([0,scaleD/2+boardHeight,boxHeight-offsetBottom])rotate([90,0,-30])cylinder(r=screw_radius,h=scaleD+4*thickness,center=true);
        
        // Hole to allow knurles on board. Yes it is a hack.
        translate([-7,0,boxHeight-9])rotate([90,0,0])cylinder(r=3,h=100,center=true);
        translate([-7,0,boxHeight-45])rotate([90,0,0])cylinder(r=3,h=100,center=true);
        
        //Hole for USB
        translate([boxX/2,20-7-15.3,boxHeight/2])cube([10,10,15],center=true);

    }
    
    //display 
    //translate([0,displayY,0])displayFront();
    //board
    translate([boxX/2-boardX-thickness-1,boardHeight-thickness,28])rotate([0,90,0])mountPlate();
    

}


difference()
{
top();
    //translate([0,0,boxHeight/2+16])cube([boxX,boxY,boxHeight],center=true);
    translate([-15,0,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
    //translate([100,0,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
    translate([0,-85,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
    translate([0,95,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
}