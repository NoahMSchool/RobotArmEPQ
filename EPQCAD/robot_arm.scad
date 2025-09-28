use <servo.scad>
use <ArmSegments.scad>
use <effectors.scad>
use <helpers.scad>

include <component_data.scad>

// X is forward

module robot_arm(){
 //Calculate arm off center base radius
 //Switch statement to choose part to render
  magnet_depth = 10;
  base_off_center = magnet_depth;


  cube(size=[2,4,8], center=true); 
  //effector = 0;
  //base_servo =; 0;
  //middle_servo = 0;

  //off_center = effectorarm_width/2
  //base(off_center = base_off_center)
}



//shaft_test(SG90_shaft_data);
//servo_shaft(SG90_shaft_data);

//arm_segment(arm_length = 100, thickness = 2.4, wire_in_offset = 10, end_servo = SG90_data, start_servo = SG90_data);
//servo_box(SG90_data);
electromagnet_sphere();

//base(base_radius = 75, base_height = 5, base_servo = MG996R_data, servo_height = 75, servo_off_center = -10, thickness = 5);

//effector_segment(arm_length = 100, beam_diameter = 2, start_servo = SG90_data, wire_in_offset = 15, width = 18, magnet_depth= 10);