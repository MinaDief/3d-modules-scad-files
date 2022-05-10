/*Edits:
Required:
*/
$fn=70;
base_thickness=1.5;
//as you mentioned on our first meeting, that you need it to be strong enough so that customers don't break it easily


hole_radius=1+0.2;
wall_drill_radius=1.5;
wiring_radius=15;
//it was 5 and you requested to increase it
//pcb
pcb_length=60.2;
pcb_width=56.5;
increase_base_size=2;
//pcb holes
hole_translate_x=2.5;
hole_translate_y=2.5;
pcb_hole_support=2;
pcb_holes_height=2.5;

//adjust 1 hole out, as reuqested
third_hole_translate_y=0;
box_tolerence_x=2.5;
box_tolerence_y=1.2;
//tolerence_between_pcbs=7;
//pcb_max_heigth=21;  //relay height mohamed call, add tolerence 5mm for jack of sensor

//put it 150 to make interfacing screw
interfacing_screw=0;

sensor_hole_support=0.75;

middle_part_wall_thickness=2.5;
//it was 2 and weak

//box_height=40; according to en's 
//box_height=25; I will reduce to split

box_height=5;
//box_sensor_height=box_height+pcb_max_heigth+tolerence_between_pcbs+5;

box_wall_height=22;
//minimum 20
tolerence_between_base_and_middle_part=0.3;


//ventilation 
//put it 1 to enable ventilation holes  
ventilation_radius=1;


//box
translate_box_z=-5;


//curvey face
curvey_face_height=5;
curvey_surface_size_increase=0;





//the box
curvy_radius=8;
adjust_box_x=6;
adjust_box_y=adjust_box_x;
translate_x=-4;
translate_y=-3;

//LED
led_diameter=4.7+0.1;

//remote
remote_screw_radius=2.25;
remote_screw_tolerence=0.4;
//validate before altering the value
remote_trim=0.25;
//#curvey part
//color("green")


translate([0,0,400]) 
difference(){

curvey_face(curvey_face_height);


// LED's opening
translate([7.5+curvy_radius,-15,-100])
translate([-30,43,190])
cylinder(r=led_diameter/2,h=600);

translate([20+curvy_radius,-15,-100])
translate([-30,43,190])
cylinder(r=led_diameter/2,h=600);
    

//remote
translate([-20,-50,70]) 
cube([50,50,50]);
}


scale([1,1,1])
translate([0,-23,400]) 
difference(){
intersection(){    
intersection(){
curvey_face(curvey_face_height);

//remote
translate([-20,-50,70]) 
cube([50,50,50]);
    }
//trim the edges to fit in
    translate([-20+remote_trim,-21-remote_trim,70]) 
cube([49.5,21,50]);    
}
    
// remote screws
translate([7.5,-15,-100])
translate([-20,10,190])
cylinder(r=remote_screw_radius,h=600);

translate([20,-15,-100])
translate([-0,10,190])
cylinder(r=remote_screw_radius,h=600);  
  //screw 1st cube on the remote part
translate([0,23,-400-0.2])
translate([-16.5,-32,500-2.9]) 
cube([8,10,3.6]);

//screw 2nd cube
    
translate([0,23,-400-0.2])
translate([16.5,-32,500-2.9]) 
cube([8,10,3.6]);  

}

difference(){
//remote screws on the main part
union(){
//screw 1st cube
translate([-16.5,-7,500-2.9]) 
cube([8,8,3]);


//screw 2nd cube
translate([16.5,-7,500-2.9]) 
cube([8,8,3]);
}


translate([7.5,-14,-100])
translate([-20,10,190])
cylinder(r=remote_screw_radius-remote_screw_tolerence,h=600);

translate([20,-14,-100])
translate([-0,10,190])
cylinder(r=remote_screw_radius-remote_screw_tolerence,h=600);
}






//##middle part
translate([-25,-15,130])
color("green")
difference(){
box(increase_base_size+middle_part_wall_thickness+tolerence_between_base_and_middle_part,box_wall_height-box_height-1);
    
translate([0,0,-1])    
box(increase_base_size+tolerence_between_base_and_middle_part,box_wall_height-box_height+5);
    
//middle part and base interfacing holes
//this will occur two times
translate([25,15,0])
translate([0,pcb_width,-box_height/2+1])
rotate([90,0,0])
cylinder(r=hole_radius,h=interfacing_screw);
    


    


//for (i = [start:step:end]) { … }
for (j = [0:6:12])
for (i = [0:6:36]) {
translate([25,20,-40])
translate([0,-10+i,40+j])
rotate([0,90,0])
cylinder(r=ventilation_radius,h=150,center=true);
}
}

//base part

color("gray")
translate([-25,-15,0])
difference(){
//hard to scale  
box(increase_base_size,0);
color("red")
translate([0,0,base_thickness])    
box(-2.5+increase_base_size,1);
    



//wall drilling holes *2
    translate([pcb_length,pcb_width/2,translate_box_z-2])
cylinder(r=wall_drill_radius,h=500);
    
       translate([0,pcb_width/2,translate_box_z-2])
cylinder(r=wall_drill_radius,h=500);
    
    //middle part and base interfacing holes
//this will occur two times
translate([25,15,0])
translate([0,pcb_width,-box_height/2+1])
rotate([90,0,0])
cylinder(r=hole_radius,h=interfacing_screw);


//wiring opening
translate([pcb_length/2,pcb_width/2,translate_box_z-2])
cylinder(r=wiring_radius,h=50);
}


translate([-25,-15,0])
%main_pcb();
translate([2,-2,0]){
    
pcb_hole(0,0);
pcb_hole(0,52.7);
pcb_hole(49.6,0);
pcb_hole(49.6,52.7);
}
// pcb hole 
module pcb_hole(move_hole_x,move_hole_y){
translate([-25+move_hole_x,-15+move_hole_y,0])
difference(){
    
translate([hole_radius+hole_translate_x,hole_radius+hole_translate_y,translate_box_z+1])
cylinder(r=hole_radius+pcb_hole_support,h=pcb_holes_height);

translate([hole_radius+hole_translate_x,hole_radius+hole_translate_y,translate_box_z+2])
cylinder(r=hole_radius,h=20);
}
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
    
module box_v2(changeXY,changeZ){
  minkowski()
{

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
difference(){
translate([5,13.5,-55.5])
//color("pink")    
sphere(r=160);

difference(){
    
translate([-25,-15,-100])
box(500,200);
    
translate([-25,-15,0])
box(middle_part_wall_thickness+increase_base_size+0.3,250);

}
translate([0,0,-398-hx])
cube([3000,3000,1000],true);
}
}

/*
module curvey_face(hx){

difference(){
    
    translate([5,12,-54])
sphere(r=160);

difference(){
translate([-25,-15,-100])
box(500,200);

translate([-25,-15,-120])

box(middle_part_wall_thickness+increase_base_size+0.3,250);
}

translate([0,0,385.1+hx])
cube([3000,3000,1000],true);
}
}


