module box_container(size, thickness){
  translate([0,0,size[2]/2+thickness])
  difference(){
    cube([size[0]+2*thickness, size[1]+2*thickness, size[2]+2*thickness], center = true);
    translate([0,0,thickness*2])
    cube(size, center = true);
  }
}

module shaft_test(shaft_data){
  length = 100;
  difference(){
    union(){
      cube([length-10,15, 20], center = false);
      rotate([90,0,0])
      translate([0,5,0])
      linear_extrude(1.6)
      text("ServoShaftFitter v0.4", size = 7);
    }
    translate([0,10,20.1])
      for (i = [1:1:8]){
        current_shaft_diameter = 4.6+0.1*i;  //SG90 5.2
        //shaft_data = [teeth count, shaft diameter, shaft depth]
        
        shaft_data = [21,current_shaft_diameter,3];

        translate([i*10,0,0])
        servo_shaft(shaft_data);
        translate([i*10,-8,-4.5])
        linear_extrude(5)
        text(str(current_shaft_diameter), size = 5, halign = "center");
    }
  }
}
