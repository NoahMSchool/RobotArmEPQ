include <component_data.scad>
use <servo.scad>

module effector_segment(arm_length = 100, beam_diameter = 2, start_servo = default_data, wire_in_offset = 15, width = 18, magnet_diameter= 20){
  vnum = "v0.5";
  top_space = 0.25; // sligtly put top below xy plane
  front_space = get_servo_shaft_radius(start_servo[13]);
  wire_cross = [15,10,10];
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
        cylinder(h=depth, r=width/2, center=true);

      }

      //shaft hole
      translate([arm_length/2,0,0])
      servo_shaft(start_servo[13]); // 13 is servos shaft data
      
      //beam hole
      translate([-arm_length/2,0,-(depth+top_space*2)])
      cylinder(h=depth+top_space*2, r=beam_diameter/2,center=false);
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
  text("Noah EPQ Robot Arm ", size = depth/3, halign = "center", valign = "center");
  //text(str("EffectorSegment ", vnum), size = depth/3, halign = "center", valign = "center");

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
