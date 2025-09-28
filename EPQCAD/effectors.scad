module electromagnet_sphere(){
  //surface_height = 15;
  handle_height = 25;


  tolerance = 0.25;
  magnet_height = 15;
  wire_height = 10;
  wirehole_radius = 2;
  base_extrude = 4;
  magnet_radius = 10;
  case_radius = 15;
  magnet_surface_radius = 4;
  ball_radius = 6;
  ball_tolerance = 1.2;
  bar_radius = 1;

  $fn = 64;
  //magnet radius refers to body maybe change

  union(){    
    difference(){
      //bars
      // union(){      
      //   translate([magnet_radius+tolerance,-(case_radius-magnet_radius-tolerance)/2,wire_height-wirehole_radius])
      //   cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2-wire_height+wirehole_radius], center = false);
      
      //   translate([-magnet_radius-tolerance-(case_radius-magnet_radius-tolerance),-(case_radius-magnet_radius-tolerance)/2,wire_height-wirehole_radius])
      //   cube([case_radius-magnet_radius-tolerance, case_radius-magnet_radius-tolerance, handle_height+bar_radius*2-wire_height+wirehole_radius], center = false);
      //   }

      //cylinder
      difference(){
        //outer
        intersection(){
        translate([0,0,wire_height-wirehole_radius])
        cylinder(h=handle_height+bar_radius*2-(wire_height-wirehole_radius), r=case_radius, center=false);
        translate([0,0,handle_height/2])
        rotate([0,90,0])
        cylinder(r = case_radius, h = case_radius*2, center = true);
        }
        //inner
        translate([0,0,wire_height-wirehole_radius-0.01])
        cylinder(h=handle_height+bar_radius*2+(magnet_height-wire_height)+0.02, r=magnet_radius, center=false);

        translate([0,0,wire_height-wirehole_radius+(handle_height+bar_radius*2+(magnet_height-wire_height))/2+0.01])
        cube([magnet_radius*2,case_radius*2,handle_height+bar_radius*2+(magnet_height-wire_height)], center = true);
      }
      //wirehole
      translate([magnet_radius+(case_radius-magnet_radius)/2,0,wire_height])
      rotate([0,90,0])
      cylinder(h=case_radius-magnet_radius+0.1, r=wirehole_radius, center=true);

      //handle
      translate([0,0,handle_height])
      rotate([0,90,0])
      cylinder(h=case_radius*3, r=bar_radius, center=true);
    }    
    difference(){
      translate([0,0,(wire_height-base_extrude-wirehole_radius)/2])
      cylinder(h=wire_height+base_extrude-wirehole_radius, r1 = magnet_radius, r2=case_radius, center = true);

      translate([0,0,magnet_height/2])
      cylinder(h=magnet_height, r=magnet_radius+tolerance, center = true);

      translate([0,0,-ball_radius])
      union(){
        sphere(r=ball_radius+ball_tolerance);
        cylinder(h=(ball_radius+ball_tolerance)*2, r=magnet_surface_radius, center=true);  
      }
    }  
  }
}