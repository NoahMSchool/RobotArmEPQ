include <component_data.scad>
use <servo.scad>

module base_seg(base_radius = 50, base_height = 5, base_servo = default_data, turn_servo = default_data, servo_height = 30, servo_off_center = 0, thickness = 3, base_wire_offset = 40, base_res = 6){
  //$fn = base_res;
  $fn = 128;

  top_space = 0.25;
  depth = abs(get_servo_bounding_box(base_servo)[0][2]);
  width = get_servo_size(base_servo)[1];
  wire_cross = get_servo_wire_cross(base_servo);
  wiretunnel_offset = get_servo_wire_offset(base_servo);
  wiretunnel_depth = 0;


  box_height = servo_height+abs(get_servo_bounding_box(base_servo)[0][0])+thickness;
  union(){
    //above base
    translate([servo_off_center,0,0])
    union(){
      translate([-get_servo_size(base_servo)[1],-width/2-thickness,box_height/2])
      rotate([90,-90,0])
      linear_extrude(1)
      //text("Base v0.4",valign = "center", halign = "center", size = depth/3);
      text("BaseSeg",valign = "center", halign = "center", size = depth/3);
      difference(){
        //box container
        translate([-(depth+top_space+thickness)/2,0,box_height/2])
        cube([depth-top_space+thickness, width+thickness*2, box_height], center = true);
        //servo_space
        translate([0,0,servo_height])
        rotate([0,90,0])
        servo_spacing(base_servo);

        
        //wire tube
        tunnel_height = servo_height-get_servo_bounding_box(base_servo)[1][0]+0.2;
        translate([get_servo_wire_offset(base_servo)[2]+get_servo_box_offset(base_servo)[2],0,tunnel_height/2+0.1])
        cube([wire_cross[2],wire_cross[1],tunnel_height],center = true);

        //wire exit
        tunnel_depth = abs(get_servo_wire_offset(base_servo)[2]+get_servo_box_offset(base_servo)[2]);
        translate([-tunnel_depth/2,0,wire_cross[2]/2])
        cube([tunnel_depth,wire_cross[1],wire_cross[2]],center = true);
        
      }
      //servo
      translate([0,0,servo_height])
      rotate([0,90,0])
      servo_box(base_servo);
    }
    //base_cylnder
    difference(){
      translate([0,0,-base_height])
      rotate([0,0,180/base_res])
      cylinder(h=base_height, r=base_radius, center=false);

      translate([base_wire_offset-wire_cross[2]/2,0,-base_height/2])
      cube([wire_cross[2],wire_cross[1],base_height*2], center = true);

      translate([0,0,-base_height-0.01])
      rotate([180,0,0])
      servo_shaft(turn_servo[13], extend = 3);
    }
  } 
}

module base_cube(cube_height = 80, cube_length = 160, in_thickness = 10, turntable_radius = 60, turntable_height = 4, servo = default_data, wire_exit_ring_offset = 40){
  tolerance = 0.25;
  $fn = 128;
union(){
  translate([0,-cube_length/2,-cube_height/2])
  rotate([90,0,0])
  linear_extrude(2)
  //text("Cube Base v04", valign = "center", halign = "center", size = cube_height/4);
  text("Noah Marks", valign = "center", halign = "center", size = cube_height/4);
    difference(){

      translate([0,0,-cube_height/2])
      cube([cube_length, cube_length, cube_height], center = true);
      translate([in_thickness,0,-(cube_height)/2-turntable_height/2])
      difference(){
        cube([cube_length, cube_length-in_thickness*2,cube_height-in_thickness*2-turntable_height], center = true);
        translate([-2*in_thickness,0,0])
        cube([get_servo_size(servo)[0]-0.5,get_servo_size(servo)[1] ,cube_height-in_thickness*2], center = true);
      }
      translate([0,0,-in_thickness])
      difference(){
        cylinder(h=in_thickness*2, r=wire_exit_ring_offset, center=true);
        //cylinder(h=in_thickness*2, r=wire_exit_ring_offset-10, center=true);
      }
      translate([0,0,-(turntable_height-tolerance)/2])
      cylinder(h=turntable_height+tolerance, r=turntable_radius+tolerance*2,center = true);
      translate([0,0,-turntable_height-tolerance])
      servo_spacing(servo);
      translate([servo[1],0,0])//shaft offset
      cube([get_servo_size(servo)[0], get_servo_size(servo)[1], turntable_height*3], center = true);
    }
  }
  translate([0,0,-turntable_height-tolerance*2])
  servo_box(servo);
}

module base_top(top_height = 4, cube_length = 160, turntable_radius = 640, wire_exit_ring_offset = 60){
  translate([0,0,top_height/2])
  difference(){
    cube([cube_length, cube_length, top_height], center = true);  
    cylinder(r = wire_exit_ring_offset, h = 2*top_height, center = true);
    cylinder(h=1, r=1, center=false, $fn=20);
  }
  
}

module base_wall(wall_dims = [10,100,100]) {
  led_diameter = 5;
  leds = ["Ready", "Activity", "Magnet"];
  led_separation = 25;
  text_extrude = 3;
  wire_exit_offset = 3;
  wire_exit_width = 15;
  tolerance = 0.75;
  wall_dims_tolerance = [wall_dims[0], wall_dims[1]-tolerance*2, wall_dims[2]-tolerance*2];

  difference(){
    cube(wall_dims_tolerance, center = true);
    translate([0,-(len(leds)-1)*led_separation/2,0])
    union(){
    for (i = [0 : len(leds)-1]){
      translate([0,led_separation*i, 0])

      union(){
        rotate([0,90,0])
        cylinder(h=wall_dims[0]+0.1, r=led_diameter/2, center=true, $fn=32);
        translate([(wall_dims.x-text_extrude)/2,0,-10])
        rotate([90,0,90])
        linear_extrude(text_extrude, convexity = 10)
        text(leds[i], size = 5, halign = "center", valign = "center");
      }
    }  
  }
  translate([0,(wall_dims[1]-wire_exit_width)/2-wire_exit_offset,0])
  cube([wall_dims[0]*1.5, wire_exit_width, wall_dims[2]-2*wire_exit_offset], center = true);
}
}