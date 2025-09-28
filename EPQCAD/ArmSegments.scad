include <component_data.scad>
use <servo.scad>

module effector_segment(arm_length = 100, beam_diameter = 2, start_servo = default_data, wire_in_offset = 15, width = 18, magnet_depth= 15){
  vnum = "v0.3";
  top_space = 0.25; // sligtly put top below xy plane
  front_space = get_servo_shaft_radius(start_servo[13]);
  wire_cross = [7.5,7.5,7.5];
  depth = (magnet_depth-top_space)*2;
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
      translate([-arm_length/2,0,-depth])
      cylinder(h=depth, r=beam_diameter/2,center=false, $fn=20);
      //endservo spacing
    
      //wire tube
      translate([0,0,-depth/2])
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
  vnum = "v0.4";
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
      wire_depth = (get_servo_wire_offset(end_servo)+get_servo_box_offset(end_servo))[0];
      translate([wire_in_offset+servo_bounds[1][0],0,-wire_depth/2])
      cube([wire_cross[2],wire_cross[1],wire_depth], center = true);
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


module base(base_radius = 50, base_height = 5, base_servo = default_data, servo_height = 30, servo_off_center = 0, thickness = 3){
  base_res = 8;
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
    translate([servo_off_center,0,base_height])
    union(){
      translate([-get_servo_size(base_servo)[1],-width/2-thickness,box_height/2])
      rotate([90,-90,0])
      linear_extrude(1)
      text("Base v0.3",valign = "center", halign = "center", size = depth/3);

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
    rotate([0,0,180/base_res])
    cylinder(h=base_height, r=base_radius, center=false);
  }


} 