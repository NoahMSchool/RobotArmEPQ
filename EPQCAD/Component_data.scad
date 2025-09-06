// ServoData

MG996R_data = [
    [40.3, 19.4, 27.5], // size
    10,                 // shaft_offset
    12,                 // shaft_height
    1.5,                // thickness
    2,                  // screw_count
    4.2,                // screw_offset
    10,                 // screw_separation
    2,                  // screw_radius
    15,                 // screw_depth
    14,                 // wire_exit_height
    3/4,                // wire_exit_width_frac
    0.75                // tolerance
];

default_data = [
    [20,10,15], // SIZE
    5,          // SHAFT_OFFSET
    5,          // SHAFT_HEIGHT
    1,          // THICKNESS
    1,          // SCREW_COUNT
    2,          // SCREW_OFFSET
    2.5,        // SCREW_SEPARATION
    0.75,       // SCREW_RADIUS
    5,          // SCREW_DEPTH
    6,          // WIRE_EXIT_HEIGHT
    3/4,        // WIRE_EXIT_WIDTH_FRAC
    0.5,         // TOLERANCE
    5,			//WIRE_EXIT_AMOUNT
];

module servo_box(servo_data = default_data){
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


module servo_spacing(servo_data = default_data){
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

servo_box(servo_data = MG996R_data);

