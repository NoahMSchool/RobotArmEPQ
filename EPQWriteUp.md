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

### Arm Cad

I placed my servo in the arm module. I used the servo spacing module to subtract volume from the arm so I could replace it with the servo

`Date: 21/08/2025`

### Electromagnet

The electromagnet I ordered have arived.
I experemented using it with the raspberry pi power output pins. I also made some simple circuits with buttons and switches. I experemented with different voltages and used external power supply. And how well the balls stuck and stayed in place and chained picking up other magnets. I managed to get it to pick up a maximum of 3 at once. I took note of what I would need to do to house it. One objective would be to stop the balls roling around the magnet as this would make where the ball is dropped unpredictable. I saw it came with a screw but I later decided not to use it as I wanted to work underneath near the magnet 

Later in the day I spent an hour and a half designing a modular CAD model in OpenSCAD for a design to house the electromagnet.
This involved mostly cylnders aswell as using a sphere to make it fit the ball it needed to pick up.


### Spring Arm Godot

I restructured and simplified my arm segment scene to use a built in springarm node which is masking no layers. This meant that each arm automatically inherited its childs position and meant I can greatly simplify the code while also improving it which would make it easier to continue. 

`Date: 22/08/2025`

### Base Replaning

I realised that using a stepper motor at the base would mean my wires got tangled. 
The most common approach to solving this is to use brushes to connect the wires to the base

I am going to try to use a MG90D Tower Pro Servo motor at the base. As the servo cannot support this weight on the shaft I am going to 3D print a turntable which will support its base.
As it is not full 360 rotation my solution is to have the arm bend over backwards to reach behind. The only problem is as my magnets position is not motorised I do not know how it will rotate over

I started designing a turntable in OpenSCAD after I cleaned up some of my previous code

### Measuring and fitting components

I used the electronic digital calliper to help measure some of my components. I adjusted the parameters of my program to fit the specific components.
I then printed and reprinted them until they were the correct size and matched well. I did this with the electromagnet and I got the magnetic surface working well and I tested it with the raspberry pi. I may need to rethink the connection mechanism to the rest of the arm and change that later. I also tried making an enclosure for the MG996R servo.

I also added some servos with their specifications to a google sheet and asked chatGPT to put it in the format of my program so I can test and finalise the servo models I am going to use.

`Date: 23/08/2025`

### Servo height offset

I made it so the shaft of the servo is the origin of the module. This will help keep things alligned

I later tried to redo the upper half of the electromagnet to get the connection working. I want to put the wirehole in the side on one of the arms as this will also hold the magnet in place

`Date: 03/09/2025`

## Adjusting Plan

I decided that I would first focus on the arm segment and then the rotating base would be a bonus if I have time.
I then started making a base in OpenSCAD.
When putting a servo ontop of the cylnder I realised there was no way to know the modules size
I would need to rethink how I was storing things in the program like servo sizes. And maybe I would need functions that return sizes alongside my modulse. Unfortunatelly OpenSCAD does not support classes. 

`Date: 05/09/2025`

## Shaft Container
I wasnt sure if printing my own shaft container with teeth to grip would work or if I was going to need to fit it using a servo horn.


## Restructuring Parameters

I looked into the best way to store things in OpenSCAD
The only datastructure that can store multiple things is a list so I had to use that
I made anouther Text file for documenting what each part means.

`Date: 06/09/2025`

I decided making a datastructure for each part is not that useful As I am not reusing it. It just meant that I was accessing variables by index instead of name which would be less readable.I could make getter functions for each but that would be pointless so I scrapped the idea.
But I was passing in data for servos a lot so I thought making a datastructure with that and other components would be more usefull.

I made a new file called component data which stores data for each component. I started with servos. 
Here is an example of the structure. I used AI giving it the structure to help format the data for different servos.

`openscad`
```
MG996R_data = [
    [40.3, 19.4, 27.5], // size
    10,                 // shaft_offset
    12,                 // shaft_height
    1.5,                // thickness
    2,                  // screw_count
    4.2,                // screw_offset
    10,                 // screw_separation
    2,                  // screw_radius
    15,                 // screw_depth
    14,                 // wire_exit_height
    3/4,                // wire_exit_width_frac
    0.75                // tolerance
];

```


## Helper Size/Offset Functions

Later I made functions that found the space required and the offset and then the bounding box which used the two previous as this would be useful for adjusting the shape of the arm segment.

`openscad`
```
function get_servo_size(servo_data) = [servo_data[0][0]+(servo_data[7]+servo_data[5]+servo_data[3])*2, servo_data[0][1]+servo_data[3]*2, servo_data[0][2]+servo_data[3]];
//[size[0]+(screw_radius+screw_offset+thickness)*2, size[1]+thickness*2, size[2]+thickness]

function get_servo_offset(servo_data) = [servo_data[1],0,-(servo_data[0][2]+servo_data[3]+servo_data[2])/2];
//[shaft_offset,0,-(size[2]+thickness+shaft_height)/2]

function get_servo_bounding_box(size, servo_offset) = [[size[0]/2+servo_offset[0],size[1]/2+servo_offset[1],size[2]/2+servo_offset[2]], [-size[0]/2+servo_offset[0],-size[1]/2+servo_offset[1],-size[2]/2+servo_offset[2]]];

```

Add Image here of bounding box



`Date: 07/09/2025`

## Making middle arm segment

I wanted to start making the middle arm segment in OpenSCAD. I decided that I wanted to put the effector at the end of the previous arm link which would minimise torque requirements as you want to keep effectors as downstream as possible. And I would have the servo rotated so It would face downwards.
I drew out my target in a sketch and then I moddled the arm in blender as reference. 

Add image in sketch book
Add image in blender

I then tried making it in OpenSCAD. I changed the arm width,depth, and length to be dependant on the end effector servo's required size.
