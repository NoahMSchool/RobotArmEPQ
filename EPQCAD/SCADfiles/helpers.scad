use <servo.scad>

function set_nth(lst, i, val) =
    [ for (j = [0:len(lst)-1]) (j == i ? val : lst[j]) ];

module box_container(size, thickness){
  translate([0,0,size[2]/2+thickness])
  difference(){
    cube([size[0]+2*thickness, size[1]+2*thickness, size[2]+2*thickness], center = true);
    translate([0,0,thickness*2])
    cube(size, center = true);
  }
}

module shaft_test(servo_data, test_num, test_start = 5.5){
  shaft_data = servo_data[13];
  text_string = str("ShaftFitterv1", servo_data[14]);
  echo(text_string);
  length = 100;
  difference(){
    union(){
      cube([length-10,15, 15], center = false);
      rotate([90,0,0])
      translate([5,5,0])
      linear_extrude(1.6)
      text(text_string, size = 5);
    }
    translate([0,10,15.1])
      for (i = [1:1:8]){
        current_shaft_diameter = test_start+0.1*i;  //SG90 5.2
        //shaft_data = [teeth count, shaft diameter, shaft depth, teeth_depth, hole_radius]
        current_shaft_data = set_nth(shaft_data, 1, current_shaft_diameter);
        translate([i*10,0,0])
        servo_shaft(current_shaft_data);
        translate([i*10,-8,-4.5])
        linear_extrude(5)
        text(str(current_shaft_diameter), size = 5, halign = "center");
    }
  }
}
