$fn = 16;

function get_servo_box_size (size = [20,10,15], shaft_offset = 5, thickness = 1, screw_offset = 2, screw_radius = 0.75) = [[size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness]];

module servo_box(size = [20,10,15], shaft_offset = 5, thickness = 1, screw_count = 1, screw_offset = 2, screw_radius = 0.75, screw_depth = 5, volume_only = false, wire_exit_height = 6, wire_exit_width_frac = 3/4){
  tolerance = 0.5;
  //tollerance is 1.5X on X to help fitting and not on z

  servo_base = [size[0]+tolerance*3, size[1]+ tolerance *2, size[2]+thickness];
  servo_base_box = [size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness];
  screw_separation = 2.5;

  #translate([0,0,8])
  #cube([2,2,8], center = true);

  
  translate([shaft_offset,0,0])
  difference(){  
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
      translate([(screw_offset+servo_base[0]/2),-screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([(screw_offset+servo_base[0]/2),screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([-(screw_offset+servo_base[0]/2),-screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([-(screw_offset+servo_base[0]/2),screw_separation/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);
    }
  }  
}


module servo_top(outer_radius = 50, hole_radius = 10){
 $fn = 8;
 cylinder(outer_radius, center = true);
}


module servo_spacing(size = [20,10,15], shaft_offset = 5, shaft_height = 2,thickness = 1, screw_offset = 2, screw_radius = 0.75, wire_exit_height = 6, wire_exit_width_frac = 3/4, wire_exit_amount = 5){
  servo_base_box = [size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness+shaft_height];
  translate([shaft_offset,0,0])
  union(){

    translate([0,0,-(thickness)/2+shaft_height/2])
    cube(servo_base_box, center = true);

    translate([size[0]/2+(screw_radius+screw_offset+thickness)+wire_exit_amount/2,0,-(size[2]-0.5)/2 + wire_exit_height/2])
    cube([wire_exit_amount, size[1]*wire_exit_width_frac, wire_exit_height], true);

  }
  
}


//servo_box([22.4+0.1, 11.75, 16.1],shaft_offset = 6, thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12, volume_only = true);
servo_box();
servo_spacing();
echo(get_servo_box_size());