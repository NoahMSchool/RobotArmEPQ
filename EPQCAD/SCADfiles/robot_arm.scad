use <servo.scad>
use <ArmSegments.scad>
use <base_Components.scad>
use <effectors.scad>
use <helpers.scad>

include <component_data.scad>

// X is forward

module robot_arm(end_seg_length = 120, middle_seg_length = 160, middle_seg_sevo = MG92B_data, base_seg_height = 50, base_seg_servo = MG996R_data, base_cube_height = 60, base_cube_length = 160, turntable_radius = 60, turntable_servo = MG996R_data){
    //magnet_effector // balls radius 6mm 30mm above ground
    magnet_diameter = 20;
    magnet_case_radius = 15;
    magnet_pivot_offset = 25; // how high magnet is off from center of point of rotation
    beam_diameter = 6;
    servo_off_center = magnet_diameter/2;
    turntable_height = 5;
    
 
    base_cube_inthickness = 8;
    base_cube_wire_ring_offset = turntable_radius-10;
    
    base_cube(servo = turntable_servo, cube_height = base_cube_height, cube_length = base_cube_length, in_thickness = base_cube_inthickness, turntable_radius = turntable_radius, turntable_height = turntable_height, wire_exit_ring_offset = base_cube_wire_ring_offset);
    translate([(base_cube_length-base_cube_inthickness)/2, 0, -(base_cube_height+turntable_height)/2])
    base_wall([base_cube_inthickness,base_cube_length-base_cube_inthickness*2,base_cube_height-base_cube_inthickness*2-turntable_height]);
    //base_top(cube_length = base_cube_length, top_height = turntable_height/2, wire_exit_ring_offset = base_cube_wire_ring_offset);
    rotate([0,0,0])
    union(){
    base_seg(base_radius = turntable_radius, base_height = turntable_height, base_servo = base_seg_servo, turn_servo = turntable_servo, servo_height = base_seg_height, servo_off_center = servo_off_center, base_wire_offset = base_cube_wire_ring_offset, thickness = 5, base_res = 32);
    
    translate([servo_off_center,0,base_seg_height+middle_seg_length/2])
    rotate([180,90,0])
    arm_segment(arm_length = middle_seg_length, thickness = 2.4, wire_in_offset = 10, end_servo = middle_seg_sevo, start_servo = base_seg_servo);
    
    //offset height may be wrong
    translate([servo_off_center,0,base_seg_height+middle_seg_length+end_seg_length/2])
    rotate([180,90,180])
    effector_segment(arm_length = end_seg_length, beam_diameter = beam_diameter, start_servo = middle_seg_sevo, wire_in_offset = 15, width = get_magnet_depth(magnet_pivot_offset)*2, magnet_diameter = magnet_diameter);
    
    translate([0,0,base_seg_height+middle_seg_length+end_seg_length+magnet_pivot_offset])
    rotate([180,0,0])
    electromagnet_sphere(handle_height = magnet_pivot_offset, magnet_diameter = magnet_diameter, case_radius = magnet_case_radius, beam_diameter = beam_diameter);
    cylinder(h=magnet_case_radius*2+0, r=(beam_diameter)/2-0.25, center=false); // fn
    }
}

//shaft_test(servo_data = MG996R_data, test_start = 4.7);

//v1
//robot_arm(end_seg_length = 120, middle_seg_length = 160, middle_seg_sevo = MG92B_data, base_seg_height = 50, base_seg_servo = MG996R_data, base_cube_height = 60, base_cube_length = 160, turntable_radius = 60, turntable_servo = MG996R_data);

//v2
robot_arm(end_seg_length = 120, middle_seg_length = 160, middle_seg_sevo = MG92B_data, base_seg_height = 40, base_seg_servo = MG996R_data, base_cube_height = 60, base_cube_length = 175, turntable_radius = 60, turntable_servo = MG996R_data);
