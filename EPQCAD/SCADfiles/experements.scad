size : [x,y,z]


servo : [size, shaft_data, screw_data, wire_exit_data, space_data]


size
shaft_data : [offset, height]
screw_data : [count, offset, separation, radius, depth]
wire_exit_data : [height, width,frac]
space_data : [thickness, ]


size, shaft_offset = 5, shaft_height = 5, thickness = 1, screw_count = 1, screw_offset = 2, screw_separation = 2.5, screw_radius = 0.75, screw_depth = 5, wire_exit_height = 6, wire_exit_width_frac = 3/4, tolerance = 0.5



# MG996R

body : [[40.3, 19.4, 27.5], 1.5]
shaft_data : [10,12]
screw_data : [2, 4.2, 10, 2, 15]
space_data : [1.5, 0.5]

servo_box(body : )


//servo_box(size = [40.3, 19.4, 27.5],shaft_offset = 10, shaft_height = 12, thickness = 1.5 , screw_count = 2, screw_offset = 4.2 , screw_separation = [10, screw_radius = 2, screw_depth = 15, wire_exit_height = 14, wire_exit_width_frac = 3/4, tolerance = 0.75);


servos = [
	[[], [], [], []], //MG996R
	[[], [], [], []], //SG90

]

module servo_box(size, shaft_offset, shaft_height, thickness, screw_count, screw_offset, screw_separation, screw_radius, screw_depth, wire_exit_height, wire_exit_width_frac, tolerance){
  //tollerance is 1.5X on X to help fitting and not on z

  size = body[0]
  thickness = body



  servo_base = [size[0]+tolerance*3, size[1]+ tolerance *2, size[2]+thickness];
  servo_base_box = [size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness];

  //#translate([0,0,8])
  //#cube([2,2,8], center = true);

  
    translate([shaft_offset,0,-(size[2]+thickness+shaft_height)/2])  difference(){  
    // box
    translate([0,0,-(thickness)/2])
    cube(servo_base_box, center = true);

    //base
    translate([0,0,(thickness+tolerance)/2])
    cube(servo_base, center = true);

    //wirehole
    translate([size[0]/2+(screw_radius+screw_offset+thickness)/2,0,-(size[2]-tolerance)/2 + wire_exit_height/2])
    cube([(thickness+screw_radius+screw_offset)*2, size[1]*wire_exit_width_frac, wire_exit_height], true);
    
    //screws
    if (screw_count == 1){
      translate([-(screw_offset+size[0]/2),0,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([(screw_offset+size[0]/2),0,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);
    }
    if (screw_count == 2){   
      translate([(screw_offset+size[0]/2),-screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([(screw_offset+size[0]/2),screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([-(screw_offset+size[0]/2),-screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([-(screw_offset+size[0]/2),screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);
    }
  }  
}