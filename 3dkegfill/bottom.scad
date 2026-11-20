use <knurlpocket.scad>



$fn=64;

thickness=2;
boxX=160;
boxY=150;
scaleD=210;
boardHeight=20;
frame=8;
boxHeight=6;

displayHeight=32;

displayY=20+displayHeight/2-boxY/2;

boardX=89;

screw_radius = 1.75;
corner_screw_distance = 5;
screwX=boxX/2-corner_screw_distance;
screwYin=46;
screwYout=-boxY/2+corner_screw_distance;


module bottom()
{
    difference()
    {
        union()
        {
          // square box
          translate([0,0,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);
           
            // cylinder wall
            difference(){
             translate([0,scaleD/2+boardHeight,boxHeight/2])
                cylinder(d=scaleD+2*thickness,h=boxHeight,center=true);
             translate([scaleD/2+boxX/2,scaleD/2+boardHeight,boxHeight/2])cube([scaleD,scaleD,boxHeight],center=true);
             translate([-scaleD/2-boxX/2,scaleD/2+boardHeight,boxHeight/2])cube([scaleD,scaleD,boxHeight],center=true);
             translate([0,1.5*boxY,boxHeight/2])cube([boxX,boxY,boxHeight],center=true);

            }
    
        }

        translate([0,scaleD/2+boardHeight,0])cylinder(d=scaleD,h=1000,center=true);
        
        //knurl holes
        translate([screwX,screwYout,boxHeight/2])
            m3knurl_pocket(boxHeight);
        translate([-screwX,screwYout,boxHeight/2])
            m3knurl_pocket(boxHeight);
        translate([screwX,screwYin,boxHeight/2])
            m3knurl_pocket(boxHeight);
        translate([-screwX,screwYin,boxHeight/2])
            m3knurl_pocket(boxHeight);
        
        

    }
    

}


bottom();
