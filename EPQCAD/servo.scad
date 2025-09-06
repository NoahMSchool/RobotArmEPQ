$fn = 16;
include <component_data.scad>

function get_servo_size(servo_data) = [servo_data[0][0]+(servo_data[7]+servo_data[5]+servo_data[3])*2, servo_data[0][1]+servo_data[3]*2, servo_data[0][2]+servo_data[3]];
//[size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness]

function get_servo_offset(servo_data) = [servo_data[1],0,-(servo_data[0][2]+servo_data[3]+servo_data[2])/2];
//[shaft_offset,0,-(size[2]+thickness+shaft_height)/2]

function get_servo_bounding_box(size, servo_offset) = [[size[0]/2+servo_offset[0],size[1]/2+servo_offset[1],size[2]/2+servo_offset[2]], [-size[0]/2+servo_offset[0],-size[1]/2+servo_offset[1],-size[2]/2+servo_offset[2]]];


module servo_box(servo_data){
  size = servo_data[0];
  shaft_offset = servo_data[1];
  shaft_height = servo_data[2];
  thickness = servo_data[3];
  screw_count = servo_data[4];
  screw_offset = servo_data[5];
  screw_separation = servo_data[6];
  screw_radius = servo_data[7];
  screw_depth = servo_data[8];
  wire_exit_height = servo_data[9];
  wire_exit_width_frac = servo_data[10];
  tolerance = servo_data[11];
  //tollerance is 1.5X on X to help fitting and not on z

  servo_base = [size[0]+tolerance*3, size[1]+ tolerance *2, size[2]+thickness];
  servo_base_box = get_servo_size(servo_data);

  translate(get_servo_offset(servo_data))  
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
    $fn = 32;
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


module servo_spacing(servo_data){
  size = servo_data[0];
  shaft_offset = servo_data[1];
  shaft_height = servo_data[2];
  thickness = servo_data[3];
  //screw_count = servo_data[4];
  screw_offset = servo_data[5];
  screw_separation = servo_data[6];
  screw_radius = servo_data[7];
  screw_depth = servo_data[8];
  wire_exit_height = servo_data[9];
  wire_exit_width_frac = servo_data[10];
  //tolerance = servo_data[11];
  wire_exit_amount = servo_data[12];

  servo_base_box = [size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness+shaft_height];
  translate([shaft_offset,0,-(size[2]+thickness+shaft_height)/2])
  union(){

    translate([0,0,-(thickness)/2+shaft_height/2])
    cube(servo_base_box, center = true);

    translate([size[0]/2+(screw_radius+screw_offset+thickness)+wire_exit_amount/2,0,-(size[2]-0.5)/2 + wire_exit_height/2])
    cube([wire_exit_amount, size[1]*wire_exit_width_frac, wire_exit_height], true);
  }
}

module servo_top(outer_radius = 50, hole_radius = 10){
 $fn = 8;
 cylinder(outer_radius, center = true);
}


//servo_box();
//servo_spacing();
//echo(get_servo_box_size());

//ms18 SG90 servo
//servo_box(size = [22.4+0.1, 11.75, 16.1],shaft_offset = 6, thickness = 1.75, screw_count = 1, screw_offset = 2.9, screw_radius = 1.6, screw_depth = 12, wire_exit_height = 6, wire_exit_width_frac = 3/4);
// servo_spacing(size = [22.4+0.1, 11.75, 16.1],shaft_offset = 6, shaft_height = 2, thickness = 1.75, screw_offset = 2.9, screw_radius = 1.6, wire_exit_height = 6, wire_exit_width_frac = 3/4, wire_exit_amount = 5);

