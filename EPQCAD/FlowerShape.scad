$fn = 32; 

  

rotate(a=90, v=[0,1,0]) 

sphere(5); 

$fn = 16; 

for (i = [0:30:330]){ 

	echo(i) 

	rotate(a=i,v=[1,0,0]) 

	translate([0,0,5]) 

	cylinder(h=10, r1=1, r2 = 3); 

} 