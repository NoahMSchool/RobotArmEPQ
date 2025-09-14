use <servo.scad>
include <component_data.scad>

// X is forward

module box_container(size, thickness){
  translate([0,0,size[2]/2+thickness])
  difference(){
    cube([size[0]+2*thickness, size[1]+2*thickness, size[2]+2*thickness], center = true);
    translate([0,0,thickness*2])
    cube(size, center = true);
  }
}

module arm_segment(arm_length = 100, thickness = 3, wire_in_offset = 25, end_servo = default_data, start_servo){
  vnum = "v0.2";
  servo_bounds = get_servo_bounding_box(end_servo);
  servo_size = get_servo_size(end_servo);
  top_space = 0.25; // sligtly put top below xy plane
  front_space = get_servo_shaft_radius(start_servo);
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
      servo_shaft(start_servo);
      
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

module electromagnet(tolerance = 0.25, magnet_height = 15, wire_height = 10, wirehole_radius = 2, base_frac = 0.6, base_extrude = 4, magnet_radius = 10, case_radius = 15, magnet_surface_radius = 4, ball_radius = 6, ball_tolerance = 1.2, handle_height = 15, bar_radius = 1){
  $fn = 64;
  //magnet radius refers to body maybe change

  union(){    
    difference(){
      //union(){
        //translate([magnet_radius+tolerance,-(case_radius-magnet_radius-tolerance)/2,wire_height-wirehole_radius])
        //cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2+(magnet_height-wire_height)], center = false);
      
        //translate([-magnet_radius-tolerance-(case_radius-magnet_radius-tolerance),-(case_radius-magnet_radius-tolerance)/2,magnet_height*base_frac])
        //cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2+magnet_height*(1-base_frac)], center = false);
      //}

      //outer
      translate([0,0,wire_height-wirehole_radius])
      cylinder(h=handle_height+bar_radius*2+(magnet_height-wire_height), r=case_radius, center=false);
      //inner
      translate([0,0,wire_height-wirehole_radius-0.01])
      cylinder(h=handle_height+bar_radius*2+(magnet_height-wire_height)+0.02, r=magnet_radius, center=false);

      translate([0,0,wire_height-wirehole_radius+(handle_height+bar_radius*2+(magnet_height-wire_height))/2+0.01])
      cube([magnet_radius*2,case_radius*2,handle_height+bar_radius*2+(magnet_height-wire_height)], center = true);

      //wirehole
      translate([magnet_radius+(case_radius-magnet_radius)/2,0,wire_height])
      rotate([0,90,0])
      cylinder(h=case_radius-magnet_radius+0.1, r=wirehole_radius, center=true);

      translate([0,0,handle_height+magnet_height])
      rotate([0,90,0])
      cylinder(h=case_radius*3, r=bar_radius, center=true);
    }    
    difference(){
      translate([0,0,(wire_height-base_extrude-wirehole_radius)/2])
      cylinder(h=wire_height+base_extrude-wirehole_radius, r1 = magnet_radius, r2=case_radius, center = true);

      translate([0,0,magnet_height/2])
      #cylinder(h=magnet_height, r=magnet_radius+tolerance, center = true);

      translate([0,0,-ball_radius])
      union(){
        sphere(r=ball_radius+ball_tolerance);
        cylinder(h=(ball_radius+ball_tolerance)*2, r=magnet_surface_radius, center=true);  
      }
  }  
  }
}


module base(base_servo, depth, height){
  $fn = 16;
  top_space = 0.25;
  base_radius = 50;
  base_height = 10;
  off_center = 
  thickness = 5;


  box_height = height+get_servo_bounding_box(base_servo)[0][0]
  union(){
    translate([0,0,base_height+height/2])
    difference(){
      cube([depth-top_space,25, height], center = true);
      translate([(depth+top_space)/2,0,height/2])
      rotate([0,90,0])
      #servo_spacing(base_servo);
    }
    //servo  
    translate([depth/2,0,base_height+height])
    rotate([0,90,0])
    servo_box(base_servo);

    //base
    cylinder(h=base_height, r=base_radius, center=false);

  }
  
  
  //translate([0,0,height+20])
  //
  //servo_box(base_servo);
}

// difference(){
//   translate([0,0,25.1])
//   cube(50, center = true);
//   servo_shaft(MG996R_data);
// }

//arm_segment(arm_length = 100, thickness = 2.4, wire_in_offset = 10, end_servo = SG90_data, start_servo = SG90_data);

base(SG90_data, depth = 35, height = 50);


//electromagnet(tolerance = 0.25, magnet_height = 15, magnet_radius = 10, case_radius = 15, wire_height = 10, base_frac = 0.6, base_extrude = 4, magnet_surface_radius = 4, ball_radius = 6, ball_tolerance = 0.8, handle_height = 8, bar_radius = 1);

//Figure out how to attatch end of electromagnet

