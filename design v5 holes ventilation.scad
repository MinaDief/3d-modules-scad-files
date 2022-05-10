/*Edits:
Required:
1-
2-
2-logo
3-ventilation
4-curve from the inside
5-
6-
7-
8-increase package 1 or 1.5 mm so pcb can fit
9-adjust the last screw according to the picture
10-curvey, edit from the inside to fit the sensor
11- make sample test print:
a-would the base fit the middle part?

Done:
base thickness from 1 to 1.5
wiring input radius from 5 to 10
make the three parts interfacing
two holes for base interface
reduce pcb holes height to 2.5
1.27 make sure
increase pcb holes radius by 0.2
adjust potentiometer position
edited the curve height from 5 to 4
*/
$fn=150;
base_thickness=1.5;
//as you mentioned on our first meeting, that you need it to be strong enough so that customers don't break it easily

sensor_part_base_thickness=1;
hole_radius=1+0.2;
wall_drill_radius=1.5;
wiring_radius=10;
//it was 5 and you requested to increase it
//pcb
pcb_length=49.53+0;
pcb_width=30.48;
increase_base_size=1.5; //because the pcb didn't fit
//pcb holes
hole_translate_x=1.27;
hole_translate_y=1.27;
pcb_hole_support=1;
pcb_holes_height=2.5;

box_tolerence_x=2.5;
box_tolerence_y=1.2;
//tolerence_between_pcbs=7;
//pcb_max_heigth=21;  //relay height mohamed call, add tolerence 5mm for jack of sensor

sensor_hole_support=0.75;

//box_height=40; according to en's 
//box_height=25; I will reduce to split

box_height=5;
//box_sensor_height=box_height+pcb_max_heigth+tolerence_between_pcbs+5;

box_wall_height=28;
//you called me 15/6 11PM and wanted it to be 28

tolerence_between_base_and_middle_part=0.3;
//x=50;

x=34;
//box
translate_box_z=-5;

//potentiometer adjustments
potentiometer_radius=1.5;  //you told me on facebook chat
potentiometer_distance_from_top=2.7+1;
//you declared on facebook
first_potentiometer_distance_horizontally=-1.1;
second_potentiometer_distance_horizontally=6.6;

//curvey face
curvey_face_height=4;



//sensor
sensor_length=32.2;
sensor_width=24.3;
sensor_height=25.4;
sensor_pcb_height=10.58;
distance_between_holes=28;
tolerence=5;



//the box
curvy_radius=8;
adjust_box_x=6;
adjust_box_y=adjust_box_x;
translate_x=-4;
translate_y=-3;


//sensor part
//color("gray")
translate([0,0,-30])
difference(){
curvey_face(curvey_face_height);
    
translate([0,0,95])
sensor_sphere();
    
translate([0,0,120])
sphere(r=21);
    
//sensor pcb holes
translate([0,0,63.5]){
translate([-25,-15,0])
translate([(pcb_length-sensor_length)/2+hole_radius+1.1,(pcb_width-sensor_width)/2+sensor_width/2,14-5])
cylinder(r=hole_radius,h=30);
    

translate([-25,-15,0])
translate([(pcb_length-sensor_length)/2+hole_radius+1.1+distance_between_holes,(pcb_width-sensor_width)/2+sensor_width/2,14-5])
cylinder(r=hole_radius,h=30);
}
}

//middle part
translate([-25,-15,30])
color("silver")
difference(){
box(increase_base_size+2+tolerence_between_base_and_middle_part,box_wall_height-box_height-1);
    
translate([0,0,-1])    
box(increase_base_size+tolerence_between_base_and_middle_part,box_wall_height-box_height+5);
    
//middle part and base interfacing holes
//this will occur two times
translate([25,15,0])
translate([0,pcb_width,-box_height/2+1])
rotate([90,0,0])
cylinder(r=hole_radius,h=150);
    
//first potentiometer holes    
translate([25,15,0])
translate([first_potentiometer_distance_horizontally,pcb_width,box_wall_height-7.6-potentiometer_distance_from_top+1]) 
rotate([90,0,0])
cylinder(r=potentiometer_radius,h=15);
    
//second potentiometer holes    
translate([25,15,0])
translate([second_potentiometer_distance_horizontally,pcb_width,box_wall_height-7.6-potentiometer_distance_from_top+1]) 
rotate([90,0,0])
cylinder(r=potentiometer_radius,h=15);

  //ventilation and logo
  
ventilation_radius=1;
//for (i = [start:step:end]) { … }
for (j = [0:5:15]){
for (i = [0:5:30]) { 
translate([25,15,-30])
translate([0,-10+i,30+i])
rotate([0,90,0])
cylinder(r=ventilation_radius,h=150,center=true);
}
}
}
//base part
translate([-25,-15,0])
difference(){
//hard to scale  
box(increase_base_size,0);
color("red")
translate([0,0,base_thickness])    
box(-2+increase_base_size,1);
    

//wiring opening
translate([pcb_length/2,pcb_width/2,translate_box_z-2])
cylinder(r=wiring_radius,h=5);

//wall drilling holes *2
    translate([pcb_length,pcb_width/2,translate_box_z-2])
cylinder(r=wall_drill_radius,h=500);
    
       translate([0,pcb_width/2,translate_box_z-2])
cylinder(r=wall_drill_radius,h=500);
    
    //middle part and base holes
//this will occur two times
translate([25,15,0])
translate([0,pcb_width,-box_height/2+1])
rotate([90,0,0])
cylinder(r=hole_radius,h=150);
}


translate([-25,-15,0])
%main_pcb();


// pcb holes *4
//first
translate([-25,-15,0])
difference(){
    
translate([hole_radius+hole_translate_x,hole_radius+hole_translate_y,translate_box_z+1])
cylinder(r=hole_radius+pcb_hole_support,h=pcb_holes_height);

translate([hole_radius+hole_translate_x,hole_radius+hole_translate_y,translate_box_z+2])
cylinder(r=hole_radius,h=20);
}
//second
translate([-25,-15,0])
difference(){
translate([-hole_radius+pcb_length-hole_translate_x,hole_radius+hole_translate_y,translate_box_z+1])
cylinder(r=hole_radius+pcb_hole_support,h=pcb_holes_height);

translate([-hole_radius+pcb_length-hole_translate_x,hole_radius+hole_translate_y,translate_box_z+2])
cylinder(r=hole_radius,h=20);

}
//third
translate([-25,-15,0])
difference(){
translate([hole_radius+hole_translate_x,-hole_radius-hole_translate_y+pcb_width,translate_box_z+1])
cylinder(r=hole_radius+pcb_hole_support,h=pcb_holes_height);

translate([hole_radius+hole_translate_x,-hole_radius-hole_translate_y+pcb_width,translate_box_z+2])
cylinder(r=hole_radius,h=20);
}
//forth
translate([-25,-15,0])
difference(){
translate([-hole_radius+pcb_length-hole_translate_x,-hole_radius-hole_translate_y+pcb_width,translate_box_z+1])
cylinder(r=hole_radius+pcb_hole_support,h=pcb_holes_height);
 
translate([-hole_radius+pcb_length-hole_translate_x,-hole_radius-hole_translate_y+pcb_width,translate_box_z+2])
cylinder(r=hole_radius,h=20);
}    




module box(changeXY,changeZ) {
    minkowski()
{
translate([curvy_radius+translate_x-changeXY/2
,-box_tolerence_y/2+curvy_radius+translate_y-changeXY/2
,translate_box_z])
cube([pcb_length+box_tolerence_x-curvy_radius*2+adjust_box_x+changeXY,pcb_width+box_tolerence_y-curvy_radius*2+adjust_box_y+changeXY,box_height+changeZ]);
cylinder(r=curvy_radius,h=1);
}
    }
    
module main_pcb(){
difference(){


cube([pcb_length,pcb_width,0.4]);



translate([hole_radius+hole_translate_x,hole_radius+hole_translate_y,-39])
cylinder(r=hole_radius,h=400);

translate([-hole_radius+pcb_length-hole_translate_x,hole_radius+hole_translate_y,-39])
cylinder(r=hole_radius,h=400);


translate([hole_radius+hole_translate_x,-hole_radius-hole_translate_y+pcb_width,-39])
cylinder(r=hole_radius,h=400);

translate([-hole_radius+pcb_length-hole_translate_x,-hole_radius-hole_translate_y+pcb_width,-39])
cylinder(r=hole_radius,h=400);


}
}
module sensor_pcb(){
difference(){
color("gray")
translate([(pcb_length-sensor_length)/2,(pcb_width-sensor_width)/2,sensor_pcb_height+tolerence])
cube([sensor_length,sensor_width,0.4]);

translate([(pcb_length-sensor_length)/2+hole_radius+1.1,(pcb_width-sensor_width)/2+sensor_width/2,-80])
cylinder(r=hole_radius,h=100);


translate([(pcb_length-sensor_length)/2+hole_radius+1.1+distance_between_holes,(pcb_width-sensor_width)/2+sensor_width/2,-80])
cylinder(r=hole_radius,h=100);
}
}


//curvey surface
module curvey_face(hx){
rotate([180,0,0])
difference(){
translate([0,0,45])
sphere(r=150);
difference(){
translate([-25,-15,-100])
box(500,200);
translate([-25,-15,-120])
box(increase_base_size,250);
}

translate([0,0,70+hx])
cube([300,300,350],true);
}
}

//sensor sphere
module sensor_sphere(){

color("gray")    
cylinder(r=11.5,h=15);
//sensor opening 21.8mm "mohamedcall"
//radius= 21.8/2 = 10.9
//UPDATE:
//circle measurement=23mm "facebook"
//radius=23/2=11.5



}




