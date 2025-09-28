
module brick(brick_size = 1){
	difference(){
		cube(brick_size);
		translate([brick_size/2,brick_size/2,0])
		cube(brick_size*0.75, center = true);
	}
	$fn = 32;
	translate([brick_size/2,brick_size/2,brick_size])
	cylinder(brick_size*0.5,brick_size*0.3,brick_size*0.3, center = true);
}

module brick_block(block_size, x_blocks, y_blocks){
	for  (y = [0:y_blocks-1]){
		for (x = [0:x_blocks-1]){
			echo(x,y)
			translate([block_size*x, block_size*y,0])
			brick(block_size);	
			}
		}
}

*brick_block(2.5, 2,3);

module box_container(size, thickness){
	translate([0,0,size[2]/2+thickness])
	difference(){
		cube([size[0]+2*thickness, size[1]+2*thickness, size[2]+2*thickness], center = true);
		translate([0,0,thickness*2])
		cube(size, center = true);
	}


}

box_container([1,5,1.5], 0.5);
