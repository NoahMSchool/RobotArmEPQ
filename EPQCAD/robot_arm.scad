use <servo.scad>

module box_container(size, thickness){
  translate([0,0,size[2]/2+thickness])
  difference(){
    cube([size[0]+2*thickness, size[1]+2*thickness, size[2]+2*thickness], center = true);
    translate([0,0,thickness*2])
    cube(size, center = true);
  }
}

//servo_top();

module arm_segment(arm_length, module_distance){
  width = 21;
  depth = 21;
  back_depth = 20;



  //StartModule
  //cube(15, center = true);

  //EndModule
  //translate([arm_length,0,0])
  //rotate([0,90,0])
  union(){
    difference(){
      translate([0,0,-depth/2])
      cube([arm_length,width,depth], center = true);
      
      translate([module_distance/2,0,0])
      servo_spacing(size = [22.4+0.1, 11.75, 16.1],shaft_offset = 6, shaft_height = 3, thickness = 1.75, screw_offset = 2.9, screw_radius = 1.6, wire_exit_height = 6, wire_exit_width_frac = 3/4, wire_exit_amount = 5);

    }
    translate([module_distance/2,0,0])
    servo_box(size = [22.4+0.1, 11.75, 16.1],shaft_offset = 6, shaft_height = 3, thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12, wire_exit_height = 6, wire_exit_width_frac = 3/4);

  }
}

module electromagnet(tolerance = 0.25, magnet_height = 15, base_frac = 0.6, base_extrude = 4, magnet_radius = 10, case_radius = 15, magnet_surface_radius = 4, ball_radius = 6, ball_tolerance = 1.2, handle_height = 15, bar_radius = 1){
  $fn = 64;
  //magnet radius refers to body maybe change

  union(){    
    // difference(){
    //   union(){
    //   translate([magnet_radius+tolerance,-(case_radius-magnet_radius-tolerance)/2,magnet_height*base_frac])
    //   cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2+magnet_height*(1-base_frac)], center = false);
      
    //   translate([-magnet_radius-tolerance-(case_radius-magnet_radius-tolerance),-(case_radius-magnet_radius-tolerance)/2,magnet_height*base_frac])
    //   cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2+magnet_height*(1-base_frac)], center = false);
    //   }
      
    //   translate([0,0,handle_height+magnet_height])
    //   rotate([0,90,0])
    //   cylinder(h=case_radius*3, r=bar_radius, center=true);
    // }    
    difference(){
      translate([0,0,(magnet_height*base_frac-base_extrude)/2])
      cylinder(h=magnet_height*base_frac+base_extrude, r1 = magnet_radius, r2=case_radius, center = true);

      translate([0,0,magnet_height/2])
      cylinder(h=magnet_height, r=magnet_radius+tolerance, center = true);

      translate([0,0,-ball_radius])
      union(){
        sphere(r=ball_radius+ball_tolerance);
        cylinder(h=(ball_radius+ball_tolerance)*2, r=magnet_surface_radius, center=true);  
      }
    }  
  }
}

electromagnet(tolerance = 0.25, magnet_height = 15, magnet_radius = 10, case_radius = 15, base_frac = 0.6, base_extrude = 4, magnet_surface_radius = 4, ball_radius = 6, ball_tolerance = 0.8, handle_height = 10, bar_radius = 1);


module turntable(){
  $fn = 65;

  radius = 25;
  height = 10;

  cylinder(h=height, r=radius, center=true);

}

//turntable();


//arm_segment(arm_length = 130, module_distance = 65);2.35

//cut off ends diagonally for wires and aesthetics
//Make tube at back for cable management



//Make Servo shaft origin of servo module
//Figure out how to attatch end of electromagnet


//Use new format for parameter pasing


//MG996Rservo
//servo_box(size = [40.3, 19.5, 27.5],shaft_offset = 10, shaft_height = 12, thickness = 1.5 , screw_count = 2, screw_offset = 3.6 , screw_separation = 10, screw_radius = 2, screw_depth = 15, wire_exit_height = 14, wire_exit_width_frac = 3/4, tolerance = 0.75);

