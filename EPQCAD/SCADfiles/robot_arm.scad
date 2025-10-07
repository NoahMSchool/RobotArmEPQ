use <servo.scad>
use <ArmSegments.scad>
use <effectors.scad>
use <helpers.scad>

include <component_data.scad>

// X is forward

module robot_arm(){
    //magnet_effector
    magnet_diameter = 20;
    magnet_pivot_offset = 25;
    beam_diameter = 1;

    servo_off_center = magnet_diameter/2;

    end_seg_length = 130;

    middle_seg_length = 130;
    middle_seg_sevo = MG92B_data;
    
    base_seg_height = 60;
    base_seg_servo = MG996R_data;
    
    turntable_radius = 50;
    turntable_height = 5;
    turntable_servo = MG996R_data;
    
    base_cube_height = 60;
    base_cube_length = 160;
    base_cube_inthickness = 10;

    base(base_radius = turntable_radius, base_height = turntable_height, base_servo = base_seg_servo, turn_servo = turntable_servo, servo_height = base_seg_height, servo_off_center = servo_off_center, thickness = 5);
    
    base_cube(servo = turntable_servo, cube_height = base_seg_height, cube_length = base_cube_length, in_thickness = base_cube_inthickness, turntable_radius = turntable_radius, turntable_height = turntable_height, wire_exit_ring_offset = 50);
    
    translate([servo_off_center,0,base_seg_height+middle_seg_length/2])
    rotate([180,90,0])
    arm_segment(arm_length = middle_seg_length, thickness = 2.4, wire_in_offset = 10, end_servo = middle_seg_sevo, start_servo = base_seg_servo);
    
    //offset height may be wrong
    translate([servo_off_center,0,base_seg_height+middle_seg_length+end_seg_length/2])
    rotate([180,90,180])
    effector_segment(arm_length = end_seg_length, beam_diameter = 5, start_servo = middle_seg_sevo, wire_in_offset = 15, width = get_magnet_depth(magnet_pivot_offset)*2, magnet_diameter = magnet_diameter);
    
    translate([0,0,base_seg_height+middle_seg_length+end_seg_length+magnet_pivot_offset])
    rotate([180,0,0])
    electromagnet_sphere(handle_height = magnet_pivot_offset, magnet_diameter = magnet_diameter, beam_diameter = 5);

}



//servo_shaft(SG90_shaft_data);

//arm_segment(arm_length = 100, thickness = 2.4, wire_in_offset = 10, end_servo = SG90_data, start_servo = SG90_data);
//servo_box(SG90_data);
//electromagnet_sphere();

//base(base_radius = 75, base_height = 5, base_servo = MG996R_data, servo_height = 75, servo_off_center = 10, thickness = 5);

//effector_segment(arm_length = 100, beam_diameter = 2, start_servo = SG90_data, wire_in_offset = 15, width = 18, magnet_depth= 10);


//electromagnet(tolerance = 0.25, magnet_height = 15, magnet_radius = 10, case_radius = 15, base_frac = 0.6, base_extrude = 4, magnet_surface_radius = 4, ball_radius = 6, ball_tolerance = 0.8, handle_height = 10, bar_radius = 1);

//servo_box(MG996R_data);
//shaft_test(MG996R_shaft_data);

//rotate([0,0,0])


//base_cube(servo = MG996R_data, cube_height = 60, cube_length = 160, in_thickness = 10, turntable_radius = 60, turntable_height = 6, wire_exit_ring_offset = 50);

//servo_shaft(MG996R_data);





//Current

//Base v04
//base(base_radius = 60, base_height = 6, base_servo = MG996R_data, servo_height = 60, thickness = 4, servo_off_center = 10, base_wire_offset = 50, turn_servo = MG996R_data);


robot_arm();
