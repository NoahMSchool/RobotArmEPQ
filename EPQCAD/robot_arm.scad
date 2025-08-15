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

module servo_box(size = [20,10,15], thickness = 1, screw_count = 1, screw_offset = 1, screw_radius = 0.5, screw_depth = 5, volume_only = false){
  tolerance = 0.5;
  //tollerance is 1.5X on X to help fitting and not on z
  servo_base = [size[0]+tolerance*3, size[1]+ tolerance *2, size[2]+thickness];

  servo_base_box = [size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness];
  screw_separation = 2.5;
  wire_exit_height = 6;
  wire_exit_width_frac = 3/4;
  if (volume_only){
    translate([0,0,-(thickness)/2])
    cube(servo_base_box, center = true);
  }

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

//ms18 SG90 servo
//servo_box([22.4+0.1, 11.75, 16.1], thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12);

//servo_top();

module arm_segment(arm_length){
  x_width = 10;
  y_depth = 10;


  translate([-x_width/2, -y_depth/2, 0])
  //servo_box([22.4+0.1, 11.75, 16.1], thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12);
  cube([x_width,y_depth,arm_length], center = false);


  //StartModule
  cube(15, center = true);
  //EndModule

  translate([0,0,arm_length])
  union(){
    difference(){
    cylinder(5,25,25);
    servo_box([22.4+0.1, 11.75, 16.1], thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12, volume_only = true);
    }
    servo_box([22.4+0.1, 11.75, 16.1], thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12);

  }
  
  


}

arm_segment(arm_length = 100);