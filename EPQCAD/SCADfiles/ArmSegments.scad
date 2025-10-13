include <component_data.scad>
use <servo.scad>

module effector_segment(arm_length = 100, beam_diameter = 2, start_servo = default_data, wire_in_offset = 15, width = 18, magnet_diameter= 20){
  vnum = "v0.5";
  top_space = 0.25; // sligtly put top below xy plane
  front_space = get_servo_shaft_radius(start_servo[13]);
  wire_cross = [7.5,7.5,7.5];
  depth = magnet_diameter-top_space*2;
  body_length = arm_length+front_space;

  union(){
    difference(){
      //main body
      union(){
        translate([0,0,-depth/2-top_space])
        translate([front_space/2,0,0])
        cube([body_length,width,depth], center = true);
      
        translate([-arm_length/2,0,-(depth)/2-top_space])
        cylinder(h=depth, r=width/2, center=true, $fn=32);

      }

      //shaft hole
      translate([arm_length/2,0,0])
      servo_shaft(start_servo[13]); // 13 is servos shaft data
      
      //beam hole
      translate([-arm_length/2,0,-(depth+top_space*2)])
      cylinder(h=depth+top_space*2, r=beam_diameter/2,center=false, $fn=20);
      //endservo spacing
    
      //wire tube
      translate([wire_cross[0],0,-depth/2])
      cube([arm_length, 0,0]+wire_cross,center = true);
      //wire in
      translate([-arm_length/2+wire_in_offset,0,-depth/2])
      cube([wire_cross[0], wire_cross[1], 2*depth], center = true);
    
    }
  
  translate([0,-width/2,-depth/2])
  rotate([90,0,0])
  linear_extrude(height = 1)
  text(str("EffectorSegment ", vnum), size = depth/3, halign = "center", valign = "center");

}
}

module arm_segment(arm_length = 100, thickness = 3, wire_in_offset = 25, end_servo = default_data, start_servo){
  vnum = "v0.5";
  servo_bounds = get_servo_bounding_box(end_servo);
  servo_size = get_servo_size(end_servo);
  top_space = 0.25; // sligtly put top below xy plane
  front_space = get_servo_shaft_radius(start_servo[13]);
  back_space = abs(servo_bounds[0][0]);


  wire_cross = get_servo_wire_cross(end_servo);

  width = servo_size[1]+thickness;
  depth = servo_size[2]+thickness;
  body_length = arm_length+front_space+back_space+thickness*2;

  union(){
    difference(){
      //main body
      translate([0,0,-depth/2-top_space/2])
      translate([(front_space-back_space)/2,0,0])
      cube([body_length,width,depth-top_space], center = true);
      
      //shaft hole
      translate([arm_length/2,0,0])
      servo_shaft(start_servo[13]); // 13 is servos shaft data
      
      //endservo spacing
      translate([-arm_length/2,0,0])
      union(){
      servo_spacing(end_servo);

      //wire in
      wire_depth = (get_servo_wire_offset(end_servo)+get_servo_box_offset(end_servo))[2];

      echo(get_servo_wire_offset(end_servo));
      echo(get_servo_box_offset(end_servo));
      translate([wire_in_offset+servo_bounds[1][0],0,wire_depth/2])
      cube([wire_cross[2],wire_cross[1],abs(wire_depth)], center = true);
      }

      //wire tube
      translate(get_servo_wire_offset(end_servo)+get_servo_box_offset(end_servo))
      cube([arm_length, 0,0]+wire_cross,center = true);
    }
    //endservo
    translate(-[arm_length/2,0,0])
    servo_box(end_servo);
  }
  translate([0,-width/2,-depth/2])
  rotate([90,0,0])
  linear_extrude(height = 1)
  text(str("ArmSegment ", vnum), size = depth/3, halign = "center", valign = "center");

}
//cut off ends diagonally for wires and aesthetics
//Make tube at back for cable management


module base(base_radius = 50, base_height = 5, base_servo = default_data, turn_servo = default_data, servo_height = 30, servo_off_center = 0, thickness = 3, base_wire_offset = 40){
  base_res = 256;
  $fn = base_res;

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
      text("Base v0.4",valign = "center", halign = "center", size = depth/3);

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
      servo_shaft(turn_servo[13], extend = 10);
    }
  } 
}
module base_cube(cube_height = 80, cube_length = 160, in_thickness = 10, turntable_radius = 60, turntable_height = 4, servo = default_data, wire_exit_ring_offset = 40){
  tolerance = 0.25;
  $fn = 256;
union(){
  translate([0,-cube_length/2,-cube_height/2])
  rotate([90,0,0])
  linear_extrude(2)
  text("Cube Base v04", valign = "center", halign = "center", size = cube_height/4);
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

module base_wall(wall_dims = [10,100,100]) {
  led_diameter = 5;
  difference(){
    cube(wall_dims, center = true);
    rotate([0,90,0])
    cylinder(h=wall_dims[0]+0.1, r=led_diameter/2, center=true, $fn=32);
  }
}