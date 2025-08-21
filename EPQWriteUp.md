# EPQ WriteUp
<br>

`Date: 14/08/2025`

### Torque Calculator
I wrote a simple python program that helped me select the servo motors that I needed. I could give it the torque and the mass of a servo or component and it would tell me if each servo in the arm had enough torque. I could refine it replacing spe 

`python`
```
#Servo Motor Calculator

g = 9.81

# (name, distance(cm), torque(kg/cm), mass(kg))
MG90D_1 = ("MG90D_ 1", 0, 1.5, 0.013)
MG90D_2 = ("MG90D_2", 6.5, 1.5, 0.013)
SG90 = ("SG90", 6.5, 0.75, 0.009)

arm = [MG90D_1, MG90D_2, SG90]

weight = 0
distance = 0
for segment in reversed(arm):
  if segment[2]<weight*distance:
    print(f"_{segment[0]}_ has too little torque : has {segment[2]} requires {round(weight*distance, 2)}")
  weight += segment[3]*g
  distance += segment[1]
```


## Blocks of code

`openscad`
```
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

brick_block(2.5, 2,3);
```

<br>


`Date: 18/08/2025`

### Shaft Offset CAD
The servo shaft is the part that rotates
I wanted to center the shaft of the servo in my model so the arm rotates from the expected place.
I offset the model in the servo module so its origin was where the servo shaft is located



`Date: 19/08/2025`
### Filament Research
I looked into what the best fillament would be the best to use.
I am going to use PLA filament as it has good rigidity and is easy to print with.
I dont think I need to worry much about the choice as most filament will work fine and I am just going to order some from amazon.


`Date: 20/08/2025`

### Servo Spacing CAD

I put my servo code in a separate file for better organisation as I expand the project

In my servo code I created a mathmatical function that will return the dimentions of the servo housing, this would be useful for figuring out the dimentions of other parts of the arm

I also made a separate module that returns the space used by a servo.
This will be useful for boolean operations where I can remove the space in the arm to allow the servo to go in without overlapping with the arm.
This also expanded outwards for the area that is required by the wires and the servo shaft
