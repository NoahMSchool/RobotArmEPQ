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

module servo(size = [20,10,15], thickness = 1, screw_count = 1, screw_offset = 1, screw_radius = 0.5, screw_depth = 5){
  tolerance = 0.5;
  servo_base = [size[0]+tolerance*2, size[1]+ tolerance *2, size[2]+thickness + tolerance];

  servo_base_box = [servo_base[0]+(screw_radius+screw_offset+thickness)*2, servo_base[1]+thickness*2, servo_base[2]+thickness];
  screw_separation = 2.5;
  wire_exit_height = 3;
  wire_exit_width_frac = 1/2;
  difference(){
    // box
    translate([0,0,-(thickness+tolerance)/2])
    cube(servo_base_box, center = true);
    //base
    translate([0,0,(thickness+tolerance)/2])
    cube(servo_base, center = true);
    
    //wirehole
    translate([servo_base[0]/2+(screw_radius+screw_offset+thickness)/2,0,-(servo_base[2]-tolerance)/2 +wire_exit_height/2+thickness/2])
    cube([(thickness+screw_radius+screw_offset)*2, servo_base[1]*wire_exit_width_frac, wire_exit_height], true);
    //screws

    if (screw_count == 1){
      translate([-(screw_offset+servo_base[0]/2),0,servo_base[2]/2])
      cylinder(screw_depth*2, screw_radius, screw_radius, center = true);

      translate([(screw_offset+servo_base[0]/2),0,servo_base[2]/2])
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
  //cube(servo_base, center = true);  

  
}

servo([23, 12, 19.5], thickness = 0.5, screw_count = 1, screw_offset = 2.4, screw_radius = 1.25, screw_depth = 5);

//Add ramps for bottom
//make top variables attributes