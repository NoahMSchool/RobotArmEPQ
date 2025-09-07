use <servo.scad>
include <component_data.scad>

module box_container(size, thickness){
  translate([0,0,size[2]/2+thickness])
  difference(){
    cube([size[0]+2*thickness, size[1]+2*thickness, size[2]+2*thickness], center = true);
    translate([0,0,thickness*2])
    cube(size, center = true);
  }
}

module arm_segment(arm_length = 100, end_servo = default_data){
  servo_bounds = get_servo_bounding_box(end_servo);
  servo_size = get_servo_size(end_servo);

  front_space = 0;
  back_space = servo_bounds[0][0];


  thickness = 3;
  width = servo_size[1]+thickness;
  depth = servo_size[2]+thickness;

  //StartModule
  //cube(15, center = true);

  //EndModule
  //translate([arm_length,0,0])
  //rotate([0,90,0])
  union(){
    difference(){
      translate([0,0,-depth/2])
      translate([(back_space-front_space)/2,0,0])
      cube([front_space+back_space+servo_bounds[0][0]+arm_length+thickness*2,width,depth], center = true);
      
      translate([-arm_length/2,0,0])
      servo_spacing(end_servo);

    }

    translate(-[arm_length/2,0,0])
    servo_box(end_servo);

  }
}
//cut off ends diagonally for wires and aesthetics
//Make tube at back for cable management

module electromagnet(tolerance = 0.25, magnet_height = 15, wire_height = 10, wirehole_radius = 2, base_frac = 0.6, base_extrude = 4, magnet_radius = 10, case_radius = 15, magnet_surface_radius = 4, ball_radius = 6, ball_tolerance = 1.2, handle_height = 15, bar_radius = 1){
  $fn = 64;
  //magnet radius refers to body maybe change

  union(){    
    difference(){
      //union(){
        //translate([magnet_radius+tolerance,-(case_radius-magnet_radius-tolerance)/2,wire_height-wirehole_radius])
        //cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2+(magnet_height-wire_height)], center = false);
      
        //translate([-magnet_radius-tolerance-(case_radius-magnet_radius-tolerance),-(case_radius-magnet_radius-tolerance)/2,magnet_height*base_frac])
        //cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2+magnet_height*(1-base_frac)], center = false);
      //}

      //outer
      translate([0,0,wire_height-wirehole_radius])
      cylinder(h=handle_height+bar_radius*2+(magnet_height-wire_height), r=case_radius, center=false);
      //inner
      translate([0,0,wire_height-wirehole_radius-0.01])
      cylinder(h=handle_height+bar_radius*2+(magnet_height-wire_height)+0.02, r=magnet_radius, center=false);

      translate([0,0,wire_height-wirehole_radius+(handle_height+bar_radius*2+(magnet_height-wire_height))/2+0.01])
      cube([magnet_radius*2,case_radius*2,handle_height+bar_radius*2+(magnet_height-wire_height)], center = true);

      //wirehole
      translate([magnet_radius+(case_radius-magnet_radius)/2,0,wire_height])
      rotate([0,90,0])
      cylinder(h=case_radius-magnet_radius+0.1, r=wirehole_radius, center=true);

      translate([0,0,handle_height+magnet_height])
      rotate([0,90,0])
      cylinder(h=case_radius*3, r=bar_radius, center=true);
    }    
    difference(){
      translate([0,0,(wire_height-base_extrude-wirehole_radius)/2])
      cylinder(h=wire_height+base_extrude-wirehole_radius, r1 = magnet_radius, r2=case_radius, center = true);

      translate([0,0,magnet_height/2])
      #cylinder(h=magnet_height, r=magnet_radius+tolerance, center = true);

      translate([0,0,-ball_radius])
      union(){
        sphere(r=ball_radius+ball_tolerance);
        cylinder(h=(ball_radius+ball_tolerance)*2, r=magnet_surface_radius, center=true);  
      }
  }  
  }
}



module base(){
  $fn = 65;

  radius = 37.5;
  height = 10;

  cylinder(h=height, r=radius, center=false);
  translate([0,0,height])
  rotate([0,90,0])
  servo_box();

}

arm_segment(arm_length = 100, end_servo = default_data);


//base();


//electromagnet(tolerance = 0.25, magnet_height = 15, magnet_radius = 10, case_radius = 15, wire_height = 10, base_frac = 0.6, base_extrude = 4, magnet_surface_radius = 4, ball_radius = 6, ball_tolerance = 0.8, handle_height = 8, bar_radius = 1);

//Figure out how to attatch end of electromagnet

