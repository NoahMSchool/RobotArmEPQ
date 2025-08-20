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

module arm_segment(arm_length){
  x_width = 10;
  y_depth = 10;


  //translate([-x_width/2, -y_depth/2, 0])
  //cube([x_width,y_depth,arm_length], center = false);


  //StartModule
  cube(15, center = true);

  //EndModule
  translate([0,0,arm_length])
  rotate([0,90,0])
  union(){
    difference(){
      cube([50,25,20], center = true);
      //cylinder(15,20,20, center = true);
      servo_spacing(size = [22.4+0.1, 11.75, 16.1],shaft_offset = 6, shaft_height = 2, thickness = 1.75, screw_offset = 2.9, screw_radius = 1.6, wire_exit_height = 6, wire_exit_width_frac = 3/4, wire_exit_amount = 5);

    }
    servo_box(size = [22.4+0.1, 11.75, 16.1],shaft_offset = 6, thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12, wire_exit_height = 6, wire_exit_width_frac = 3/4);

}
}

arm_segment(arm_length = 65);
