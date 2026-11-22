include <BOSL/constants.scad>
use <BOSL/threading.scad>
use <BOSL/metric_screws.scad>

// fn will be overridden by test script
$fn=100;

//metric_nut(size=8,pitch=1.5);
rodD=9;
height=5;
wingH=0.8*height;
difference()
{
    union()
    {
        translate([0,0,0])cylinder(d=rodD+2,h=height,center=true);
        translate([0,0,-height/2+wingH/2])cube([4,rodD+9.5,wingH],center=true);
    }
    //threaded_rod(d=rodD,l=height+1);
    threaded_rod(d=rodD,l=height+1, pitch=1.25);
}