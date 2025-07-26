module box_container(size, thickness){
  translate([0,0,size[2]/2+thickness])
  difference(){
    cube([size[0]+2*thickness, size[1]+2*thickness, size[2]+2*thickness], center = true);
    translate([0,0,thickness*2])
    cube(size, center = true);
  }


}

//box_container([1,5,1.5], 0.5);
$fn = 16;

module servo(){
  thickness = 0.1;
  servo_base = [2, 1, 1.5+thickness];
  screw_offset = 0.1;
  screw_radius = 0.05;
  screw_depth = 0.25;
  servo_base_box = [servo_base[0]+screw_radius*2+screw_offset*2+thickness*2, servo_base[1]+thickness*2, servo_base[2]+thickness*1];
  screw_count = 2;
  screw_distance = 0.25;

  difference(){
    // box
    translate([0,0,-thickness/2])
    cube(servo_base_box, center = true);
    translate([0,0,thickness/2])
    cube(servo_base, center = true);
    
    //screws
    
    if (screw_count == 1){
      translate([(screw_offset+servo_base[0]/2),0,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([-(screw_offset+servo_base[0]/2),0,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);
    }

    if (screw_count == 2){   
      translate([(screw_offset+servo_base[0]/2),-screw_distance/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([(screw_offset+servo_base[0]/2),screw_distance/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([-(screw_offset+servo_base[0]/2),-screw_distance/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([-(screw_offset+servo_base[0]/2),screw_distance/2,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);
    }


  }
  //cube(servo_base, center = true);  

  
}

servo();

//Add ramps for bottom
//add hole on one side for wire
//add support for multiple screwholes
//make top variables attributes