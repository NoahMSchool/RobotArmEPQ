 # EPQ WriteUp
<br>

## Brainstorming Ideas 

`11/01/2024`

### Subjects : 

Programming  
Artificial Intelligence / Machine Learning  
3D printing  
Raspberry Pi  

### Project Ideas  

Making a robot using raspberry pi, servo motors and 3D printing  
Walking Dog  
How AI is contributing to Robotics  
How reinforcement learning contributes to walking robots  
Robot Arm that sorts objects by color (Lego)  
How developments in VR and AR will impact consumer technology  
Will XR glasses or XR headsets reach consumers first


`11/08/2024`

## Coming Up with initial Idea 

Project Idea – 7/10  

I got an idea to make a robot arm that could move things around. Maybe sort things by color and have a camera. 

## Title

How sure about the title – 4/10  

Programable Robot Arm,	Robot Lego Sorter	  
Researching robot arms 


`15/11/2024`

## Robot Arm Research

I did some research on robot arms. I learned about the different form factors of differnt robot arms. Work envelopes which are the area the robot arm can access. I learned about the different parts of a robot arm that I would need to make, like the body, the gripper and the computer. 

I could outline all the different systems I would need to make and also the optional things I could make if I have time.  

The main tasks I needed to complete was to make my own custom 3D printed body. I wanted to do some programming using a raspberry pi and make some way to control it. A task I could do after is try to use computer vision to detect objects with cameras. 

This is a video that I liked about robot arms
https://www.youtube.com/watch?v=u5k2ewa1_is 


 '11/16/2024'
## Deciding on components 

I had to figure out which types of components and models of components to use. 

For the microcontroller I wanted to use raspberry pi. After some research I learned about the different types of motors and learned servo motors are the best for an arm. 

`22/11/2024`
## Deciding on project scope

I will use a custom 3D printed Skeleton  
I will use servo motors to allow the arm to move  
I will use Inverse Kinematics to calculate how the joints of the arm need to rotate to move the end of the arm into position  
I will use a raspberry pi to allow programming of the arm  
I might use a camera or LIDAR to detect the position of objects so that the arm can pick up these objects  
I could then make it sort objects by color such as Lego or fruit  
 

## Making Pre-Designed robot arm 

`25/11/2024` 
## Finding Premade Model
I found a model of a robot arm online that I 3D printed.

Serv-Arm by Heartman - Thingiverse  

## Ordering Servos
Next, I bought some SG90 servo motors that the 3D printed body was designed to house. I needed to screw the servos in some holes that were left. 

`11/26/2024`
## Printing 
There were many different parts to the robot arm that I needed to print separately. They came in a file with lots of different models. I had to choose which models I was going to use and then rotate the models in my slicing software to ensure that they were printed in the best quality. 

Over the next few days I printed and reprinted the parts. I was having problems with my printer not adhering to the base so The prints kept on failing. This was very frustraiting. I tried different fillaments and different models. It tended to happen with larger parts.
I was also looking into slicing settings.
I got it to work by increasing the first layer height.

`11/28/2024`
## Arm Assembly
Once the servos came I then assembled the arm with screws.
I continued over the next few days while I also worked on electronics

## Arm Electronics
`01/08/2025` 

## Functions of the Robot Arm to consider
* Methods of control
** Direct control of servos and magnet on the Breadboard (potentiometer and buttons)

### Out of scope for the project
* Vision to detect where they are?

## Simple Component Tests:

### Basic GPIO outputs

```python
pin = RPi.GPIO.setup(pin_number, GPIO.OUT)
GPIO.output(pin_number, GPIO.LOW)  # Send a 0 or Low Signal
GPIO.output(pin_number, GPIO.HIGH) # Send a 1 or High Signal
```

### Servos and Pulse Width Modulation Output

Need for Pulse Width Modulation for Servo
```python
pwm = RPi.GPIO.PWM(pin_number, frequency)
pwm.ChangeDutyCycle(duty)
```   
I also found a utility class ```gpiozero.Servo``` class.
https://gpiozero.readthedocs.io/en/stable/api_output.html
Note that my Servo needed a range of 500 to 2500 microseconds

```python
from gpiozero import Servo
servo = Servo(pin_number, initial_value = 0, min_pulse_width = 0.5/1000, max_pulse_width = 2.5/1000)
servo.value = v # Between -1 and 1 for a 180 degree movement range
```

### Potentiometers, Analog to Digital Converters and the I2C Protocol
I learned there was 3 different Bus Protocols - UART, SPI and I2C
The busio library controls these: https://pypi.org/project/ADS1x15-ADC/

I2C Bus Protocol https://en.wikipedia.org/wiki/I%C2%B2C:
https://www.robot-electronics.co.uk/i2c-tutorial
Half Duplex

```python
import board
import busio      
i2c = busio.I2C(board.SCL,board.SDA)
```
I bought some ADS1115 Analog to Digital Converters
Documentation here: https://pypi.org/project/ADS1x15-ADC/

```python
import adafruit_ads1x15.ads1115 as ADS
from adafruit_ads1x15.analog_in import AnalogIn
ads = ADS.ADS1115(i2c,address=0x48)
pot = AnalogIn(ads, ADS.P0)
print(pot.voltage, v)
```


## 3D Printing First Attempt:
I decided to test my servos on a robot arm. I found this model online:
https://www.thingiverse.com/thing:1684471

It came in two parts - an arm and a controller. I only wanted the arm. It is a very simple model so was excellent for starting to understand how the motors work together. It has 4 servos:
- a rotating on for the based
- two arm joints
- a gripper

I learned about 3D printing. I have a Creality Ender 3 v3 printer. I am using a 0.4mm nozzle and PLA filamnent. I knew a bit about this from before as I did my Design and Technology GCSE with 3D printed parts

In the beginning, the base of the model wouldn't print. The main issue was that the first layer was not sticking to the base. I tried:
* releveling and recalibrating the printer
* cleaning the nozzle. I replaced it and put it back
* changing the temperature of the nozzle and the bed for the PLA
In the end, the thing that seems to help the most was increasing the thickness of the first layer from 0.2mm to 0.4mm


`01/01/2025`


## Setting Up development Environment 

Originally, I was coding directly on the raspberry pi. This was quite slow and difficult to program with. I wanted to be able to program the raspberry pi 4 directly from my computer. I had to use SSH (Secure Shell Protocol) to allow my computer to wirelessly connect to the raspberry pi. 

I saved the commands I had to use in the terminal of my computer in my GitHub so I could paste it into the command line each time I wanted to work on the project. This allowed me to load my environment into sublime text so I could start writing code. 

### Learning about RCA plugs
In order to fit the servo motors into the frame, I had to remove the RCA plugs and put them back on again. The plugs have a small black clip for each wire. If you lift that, you can pull the wire out and then push them back to replace them.

I needed to buy some M3 bolts and screws to secure the servos, and some glue to keep things together.
I have set up one potentiometer per servo motor. Currently I have 3 working.
I need to think about the cable maintanance as there are a lot of wires coming out of the arm and into the servos

### Testing the model
I created a circuit that used:
- One potentiometer per servo
- The potentiometers were wired into 4 channels of my analog to digital converter (ADC)
- The ADC was wired into the Raspberry Pi IDC pins
- Each servo had a Pulse Width Modulation Output Pin going into it
The program simply had a loop that read the voltages of the ADC inputs (range of 0-3.3 V), and set the pulse widths to match (range of -1 to 1) using a map and clamp function I created

## Setting up mac with raspberry Pi

### Working directly on the raspeberry pi
In the beggining I was working directly on the raspberry pi plugging a monitor, mouse and keyboard into the raspberry pi's ports. Using this I can control the raspberry pi with my mouse and keyboard.
I was using the thonny editor on the raspberry pi. This was tedius because of all the setup every time. It was also very slow and difficult to type with with the lag.

I wanted to try to set it up so I can connect remotely to the rasperry pi.
In order to do this I needed to:
* allow SSH to the raspberry pi
* connect the raspeberry pi to the same network as the computer
* mount the raspberry pi drive on my mac using macFuse and SSHFS

### Finding Raspberry Pi IP address

The IP address of the raspberry pi could change so the following command is an easy way to find it from my mac
`arp -a | grep raspberry`
returns
`raspberrypi.lan (192.168.86.37) at d8:3a:dd:66:99:5a on en0 ifscope [ethernet]`

### Enabling SSH
SSH stands for secure shell which needs to be running on the raspberry pi so other computers can connect to it, I turned this on on the raspberry pi settings

If we create a public/private key pair we can SSH without need the password every time
On your Mac, generate an SSH key (if you don’t already have one):
```ssh-keygen -t rsa -b 4096 -C "your_email@example.com"```

Copy the key to the Raspberry Pi:
```ssh-copy-id admin@192.168.86.250```

This saves your public key on the Pi so you don’t have to type a password.
Now, SSH without a password!
ssh admin@192.168.86.250

```ssh admin@192.168.86.250 "python3 /home/admin/src/RaspberryPiEpq/simpleLED.py"```

### Mounting the drive
```sshfs admin@192.168.86.250:/home/admin ~/mnt/pi -o reconnect,allow_other```

Unmounting
```umount ~/mnt/pi``` 

### Creating a Build System in Sublime Text

In Sublime Text, you can create a build system that runs your own commands when you press Cmd^B

In my setup this will run the current python file

```
    "shell_cmd": "ssh admin@192.168.86.250 \"python3 /home/admin/src/RaspberryPiEpq/${file_name}\"",
    "working_dir": "$file_path",
    "selector": "source.python"
}
```

`03/07/2025`

## Researching Inverse Kinematics 

Instead of manually controlling the angles of the robot arm I wanted it to take cartesian coordinates as input and then figure out the angles the joints needed rotate to rotate itself 

The base was easy as I just used the inverse tan function to find the angle. This is as it is the bases rotation is independent of the other axis. 
Next I had to figure out the two angles  
I tried figuring out this myself for fun. I drew some diagrams on some paper and tried to use trigonometry to solve for the angles. 
First I did a more general example using real numbers trying figure out the angle.  
I used Pythagoras to find the distance of the point in space to the origin and the cosine rule to solve for the angles 
I then tried to use variables instead of the numbers which is necessary for a general algorithm to find the angles. This algorithm would work for any angle and lengths of the arms. 
For this there would also always be two solutions and sometimes no solutions so I would need to add constraints to the arms rotation. 

 
After this I tried to validate my work using this video by RoTechnic: 
Easy inverse kinematics for robot arms 
Simulating Inverse Kinematics 

`03/014/2025` 

Firstly, I needed to simulate how the math's behind the inverse kinematics would work. I tried a few different programs. I used blenders built in Inverse Kinematics for a reference of what I wanted. 
I first tried to write a program in Sprite Kit which is a simple graphics library. I also considered using blenders python scripting for this 
I eventually chose to do it in Godot as I can code it to be the most realistic as it is 3D and I can add a skin to it to see how it will look. 

 
### Researching Modeling Software 

`01/05/2024`

As I was going to make 3D printing to make my arm, I needed to decide which software I needed to model it. I initially wanted to use blender as I had experience with it but after researching I learned that blender was not great for this kind of design and a software with parametric moddeling is more suitable. 
Something like fusion360 is much better for making scale models that fit components. I also used AI asking ChatGPT to compare the benefits and drawbacks of both blender fusion 360. 

I spend the evening trying to learn Fusin 360 because i thought that was the most suitable 
 

### Godot Computer Simulation 

`16/05/2025`

Making Computer simulation in Godot 
Godot is a game engine that I wanted to use to make a simulation for the whole arm. I would use it to practice programming inverse kinematics. For attaching the real 3D models to it and experimenting with getting it to pick up objects 

`18/05/2025`

I tried different combinations of nodes in godot, I first tried to use the built in Springarm Node then I tried to make a custom node setup. I then decided to modify each arm segment individually as they all had different needs 

`30/05/2025`

### Researching connecting Godot to raspberry pi 

I wanted to use my godot computer simulation to control the arm.
The best solution was to host a web server on the raspberry pi where I would control it remotely from my mac.

`31/01/2024`

I wanted a feature of my robot arm to be able to connect to a computer and be controlled directly from the Godot simulation on my computer. 
I decided I was going to host a web server on the raspberry pi, the Godot game would directly write to that server and the raspberry pi would interpret these instructions. 

I then decided to practice using API calls in one of my Godot games I had been working on, I first used an API to get some jokes and then I used an API Where the ISS at? that would give me the position of the ISS when I called it. I used a HTTP request node and a script to get the position and I used it to make a satellite that orbited the world with the same longitude and latitude as the ISS at this time. 


 `11/06/2025 `
### Researching the gripper 


If I want to pick up objects with my arm, I need a way for it to grip objects. 
The main options were two finger and three finger grippers 
Vacuum grippers which act like suction cups 
Magnetic grippers 
I thought what material and mechanism to use 

 My favorite option was the magnetic gripper. I could use an electromagnet that I could turn on and off. This would allow me to easily pick up and drop magnetic objects like steel balls. This would make it easier to achieve precise control over the objects it is holding while being more reliable as I do not need to worry about the object slipping and confusing the system 

`21/06/2025`
### Learning FreeCAD
I tried to learn freecad for a week I followed some tutorials

`28/06/2025`
### Installing and learning OpenSCAD 

After trying to learn FreeCad for a week I was still struggling. I decided to try to install OpenSCAD which is a CAD software for programmers. This lead me to learn more about the command line as I had to install it through homebrew. 


`05/07/2025`
```
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
```
For the next few days I continued practicing making shapes and learning the basics of OpenSCAD using the linked video tutorials, the cheat sheet, and Google Gemini while practicing. 

```
`19/07/2025`
## Servo module

I finally built a servo model 

I started with a base and used boolean operations to  subtract the volume needed to house the servos
My design is very flexible and allows for different servo shapes, thicknesses, wire exits, screw sizes, offset and more  allowing it to be adapted to many different servos 

I first adapted it to a SG90 servo 

This involved lots of reprinting and adjusting my exposed parameters until it fit perfectly. 

My first attempt was supprisingly close and it already fit quite well. However the screws did not fit or line up, parts were to loose and I realised there was a gap in the bottom. 
In total I did 8 attempts before I perfected it. 
I also realised some improvements in my code that would mean it is easier to adapt in future. (mostly changing how the offsets rely on each other. 
The idea is I can instantiate this as a reusable module as a part of the other larger components of the arm 
I next had to finalise the components I was going to use. 
The choice of servo motors was quite straightforward as there was little and simple to choose from options. 

`26/06/2025`
## Electromagnet Module
With the electromagnet It required more research. 

I was initially unsure what I needed. I started with a push pull solenoid before realising this was not right.  

I eventually found a small electromagnet that would work. It had a holding force of 2.5kg which I initially thought was extreamly overkill as it needed to carry 20g spheres however I learned that the holding force is not the same as the force to pick something to pick something up it should be divided by a factor of 5 or 10 and also the fact that my objects are spherical not flat means there is less surface area to attract meaning that this electromagnetwas just right 
 
I used the cheat sheet again
https://openscad.org/cheatsheet/index.html?version=2021.01 

https://www.amazon.co.uk/yusvwkj-Helicopter-Airplane-Mechanical-Waterproof/dp/B08XHWCS1R/ref=sr_1_1_sspa?crid=KS51G24JRPD4&dib=eyJ2IjoiMSJ9.D-t4hKDeuOxvcXYG0oVDMS4PIL1gT3dLHffNDWqnEUJ1A2NBkZMdj5Kr-koS38nLJKwShqtwl2WXgHJfu3PeNJBIIwZFLhuKPJDnGCIm2ipysHmIkWDIP7Wnr7tV_n-WiI6gArwDKpKfewKgq-g8h2rfAem2fEudF2VxZtQaQc6vo2ZL1reB8NrHKpiy8rintHqXiT1ss5fRwBwMZKA1hLSKk0DAFGhNyBIFCsJZaX_x1xqykF9Dw_8SM2xDTUKA1EzhZgiz6SkV36B3ko_4HlJRSkbU82LijA3JNwiZ1IU.25FR426NNNdaDipbuuIdED69Gkc39LVB98uAxpmO8lg&dib_tag=se&keywords=towerpro%2Bservo%2Bmotor%2B-%2Bmg996r%2B360%2Bmetal%2Bgear&qid=1752356386&sprefix=MG996R%2Btower%2Caps%2C70&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1 

 

## Choosing Components 

`12/06/2025`

Before making the model I had to finalise the components that I was going to use so I could make the englosure around them. 

Electromagnet 

https://thepihut.com/products/small-push-pull-solenoid-12vdc 

https://thepihut.com/products/mini-push-pull-solenoid-5v 

 

### Servos 

 

https://thepihut.com/products/servo-motor-mg996r-high-torque-metal-gear?srsltid=ARcRdnpizNyWNPJ9_e3-erIbrxfITi6vHZ5jLgyimcGtfAZI8Y49Nv9W 

### Ball Bearings 

https://www.amazon.co.uk/sourcing-map-Bearing-Stainless-Precision/dp/B07YKSD1SH/ref=sr_1_9?dib=eyJ2IjoiMSJ9.x0JxWxhUIVfokdMkT6AFg1PfWcp5vhWm6pB-xcVL5T3jWvmy3ctmrjqjrDzCC4BAPLv6hfJbZ6NTEl4qJf1x5e66pGc4qcgv6xCHjJRJUpLuSUz82j3x4v7KQM_oNGNClJmEPyWdqlznNTLS5BSy6S-Kahnmzskd34n-ECNHiXiqKjBqLEtiz5UGTwve7Plo2Gk38uowR5WP4DkxHGl7c4WHXDABHYBcIip6iL7_QYhOHwycBYs1FMS1AB6gFHloHrv-lTpuYaDuJUSrIYuFRxhZRPUkwE-BpLh9-0ntICI.EAJs3MCR7diZwUGhz4Ux-5wixyV0isM0azREpUpVmm0&dib_tag=se&keywords=steel%2Bball%2Bbearings&qid=1753303104&sr=8-9&th=1 

`Date: 14/08/2025`

### Torque Calculator
I wrote a simple python program that helped me select the servo motors that I needed. I could give it the torque and the mass of a servo or component and it would tell me if each servo in the arm had enough torque. I could refine it replacing spe 

`python`
```
#Servo Torque Calculator v1

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

I then started making it in OpenSCAD. I changed the arm width,depth, and length to be dependant on the end effector servo's required size. I usd the new bounding box and size helper functions for this. 

### Functional Programming Link
I had adapted the bounding box to just take servo data by using 2 other functions. This is slightly more readable but is still not very readable. I was getting a bit worried about using openscad because its lack of classes and propper functions were making me doubt my programs maintainablity. 
I realised that the functions were pure function which return a value without having side effects or effecting state which is used in functional programming langualges like haskell. Not that OpenSCAD is a functinal langage but this was an introduction to the minset.

I had been looking into some other similar programs like python libraries and OpenCascade, Cadquery and FreeCAD scripting.

`Date: 08/09/2025`

## Getting height to allign to servo + Bug Fixing 

I got the height of the arm to adapt to the height of the servo
I also fixed some bugs causing unexpected translations.
I am finding my code to not be very readable so I might need to figure out a solution. I am thinking that OpenSCAD is not optimal for larger projects.
I then used AI by passing in the indexes labeled with the variables they correspond to and asked it to write a more readable version that I could put in a comment next to it. I checked it and it worked well.


`Date: 10/09/2025`

## Wire Tunnel

I made a tunnel for wires in my arm model. I followed the design I did earlier with the drawing. I made two more helper function in the servo that gets size and offset info that I used to perfectly match the wire sizes. There is also a wire enterance point that moves dependant on the size of the servo and an offset variable.
I exposed a few more parameters to the arm function and improved some code overall.
One thing I am worried about is not being able to get the wires through the hole during assembly. 

I am almost ready to print some arm samples. Before that I want to get the servo shaft hole at the base. As these parts are quite large I want to be able to test as many variables as possible at once. I might also start with shorter arms by changing the parameters.

Insert Drawing

`Date: 12/09/2025`

## Shaft Hole

I knew that the ways to connect the servo shaft to a horn is that there are screws and gears. I knew how the screws would work. I wasnt sure how I would do the gears as I didn't know whether the printers resolution would be sufficient. 
I took apart the servo part of the original arm as I wanted to see if it printed the gears. Which it did and they worked pretty well.
My backup was to model something around the non circular horns that came in the box as I knew they had good gears.

First I added some parameters to my servo data to do with the shaft.

I then made a module that would be used to subtract space from the arm for the gear to fit in. My plan was that it would go all the way through which would allow me to screw the screw in from the back.

First I made a cylnder using the parameters passed with the resolution as the teeth count

I used a loop and rotated small cubes around the cylinder. (same as teeth count)
I used the cosine rule to make sure the cubes width matched the cylinders face width exactly.
`cube([teeth_depth*2,sqrt(2*shaft_radius*shaft_radius*(1-cos(360/teeth_count))),shaft_depth], center = true);`

I then added tubes for the screws to go through and added a few more features.
Finlly I added it to a cube to test and then I added it to the servo.

I think this might need quite a lot of tweeking to get right so I may print a block with quite a lot of different variations and see what fits because they are quite small.

`Date: 13/09/2025`

## Printing first arm segment.

I printed the first arm segment. The main things I was worried about was the wire hole not supporting and loosing rigidity and i didnt know how my teeth would work.
My slicer said it would weigh 18 grams so I thought I should soon work a bit more on my torque calculator to include the arm weight as that was as significant as the servo.


When I came back later the arm had successfully printed. I then realised that I used the diameter of the servo shaft istead of the radius so it was too big. Aswell as that I improved a few more things and added text to the side and used it to show the version number. When I tried to snap it for a durability test it was quite strong and held so I do not need to worry about that.
I reprinted.
There was still a few problems. (Shaft size, wire exit height, screws)
I did anouther print.

Previously I was using trinket which is a browser based python editor. I then used homebrew to install python on my machine. This way I could add my python script to source control and run it localy.

## Torque Algorithm

I worked on the torque algorithm. I realised it had quite a big logic error so I had to rewrite it a bit.
I made a new list that stored the current distances and the weights so I recalculate the torque at each arm.


`Date: 13/09/2025`

I then tested it with some cases that i wrote down on some paper. I got the expected results.
I found out even with small sg90's they would work with the expected 20g arms 10cm long

## Reprinting and testing assembly

I reprinted the arm with a few tweeks. The screws were working nicely but the shaft was too small. I was confused why one servo was fitting worse than before but it was because there was anouther type of SG90 i was using.

## Designing base

I was thinking about how to design it. 
I eventurally decided was going to make a new module but use parts from the arm segment module.
I realised that its width would need to be the same as my top arm segments.
I then decided I wanted to add some overide variables that would set lengths to fixed values if the space allows

I had a longer think about it and drew some diagrams and thought about different ideas

**Requirements**
Should work without manual length setting
Can have manual lengths set if user wants

TODO

Top find length function

Offset base servo so top is in line with centre of base

`Date: 15/09/2025`


## Planning Design

I spent a long time thinking and designing the arm and where the wires would go. I was drawing diagrams and tracing where the wires would go.
I also went over the design and fixed bugs


`Date: 16/09/2025`

I decided that I wanted to go with the original design with one effector per limb. This would make the modular sizing easier as each limbs size would depend on the effector. And It is less risky in terms of weight distribution and arm size.

This would mean that not all limbs are the same size however I dont think it will look bad if it is a bit asymetrical and I would rather make something that works.
I added some more to the base cad. 

The way I would structure the program is there is a main module that can create any component specified.
At the beggining it would calculate neccessary parameters for modules that were linked. Such as the offsets of the base so the final effector is centered

I made this but it currently consists of mostly comments/pseudocode about how I want to structuere it. 

Immidate next steps are
Make box size of servo, offset box so servo is relative to servo_off center

`Date: 17/09/2025`

## Servo Shaft fitting

First I separated the servo shaft data into a new array datastrucure so my test module could use it. I am thinking about doing this with the other parameters. I am not sure it will be worth it though.

I completed my part that would be used to print multiple different sized shafts.
It used a loop to shift each servo shaft along the block and also the shaft radius slightly increased as it was multiplied each loop.
I remeasured the shaft with my digital caliper around multiple orientiotions to get a rough Idea of the size. I made my program print 8 slightly different servos with slightly different radii starting slightly less than the measured value to slightly more. When I printed it I found that 5.2 mm was the sweet spot for the diameter which was acctually quite different to the 4.8mm I measured, maybe because of the gears. 
It started loosing grip after time and wouldnt move the servo. I changed the gears and reprinted the module.

`Date: 18/09/2025`

I finished reprinting and testing with a name


`Date: 19/09/2025`


## Finished Base

I printed off the first


`Date: 20/09/2025`

In the morning I finished the base and changed the arm to fit with the servo shaft fitting then I printed the 


https://images-na.ssl-images-amazon.com/images/I/61jUf7Q-0uL.pdf

## Assembling printed arm
I assembled my first arm with the two printed components.
I had to fit the screws and the wires in and it was reletively straightforward.

`22/09/25`
## Debugging servos
I was trying to get the servos to move to a specified rotation

Whenever I was touching the servos it was moving randomly and I was confused as I was running the same programs that previously worked were not working
I spend an hour debugging why the servos were doing this. I tried different programs and looked at how the servos were being turned of and the wiring and components I was using.

I finally realised it was because I was using a external power supply for the servos. The servos and the pi did not have a common ground. This meant the servos did not understand the pwm signals that the
pi were sending as it had no reference of what to compare the voltage to. That is why it was randomly moving.

After rewiring by connecting the ground of the pi to the power supply ground. I ran my previous program and it worked

`24/09/25`
## Godot Editor Scripts and Parameters

I worked for a while on the Godot project, I wanted to get in a state where I could just send the HTTP requests to the web server on the Pi.
I wanted to be able to preview the arm in the editor when I changed parameters. Since everything was being done in code I previously could not see what it was doing until I ran.
I learned about editor scripts which allowed me to preview it.

`25/09/25`

## Adding Servo Functions
I made some functions that would get the servo to move to a specific angle.
I had to tweek the range of pulse widths that the servo could understand so I looked at the specs and then ran some functions until it was right.

## HTTP request
I first tested the HTTP request from the browser.
I then sent it using godot

This is an example of a request that gets it to move:
`http://192.168.86.44:8080/servos?base_angle=-60&middle_angle=80`


`27/09/2025`

## Designing and printing third arm segment

I designed the arm segment with a curved end so the magnet would stay in place.
I went through 3 iterations before I got one that worked well

## AutoStarting Web Server

```
admin@raspberrypi:~/src/RaspberryPiEpq $ sudo systemctl daemon-reload
admin@raspberrypi:~/src/RaspberryPiEpq $ sudo systemctl enable robot_server.service
Created symlink /etc/systemd/system/multi-user.target.wants/robot_server.service → /etc/systemd/system/robot_server.service.
admin@raspberrypi:~/src/RaspberryPiEpq $ sudo systemctl start robot_server.service
admin@raspberrypi:~/src/RaspberryPiEpq $ sudo systemctl status robot_server.service
● robot_server.service - EPQ robot arm controller
     Loaded: loaded (/etc/systemd/system/robot_server.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2025-09-27 22:13:03 BST; 35s ago
   Main PID: 1500 (python3)
      Tasks: 4 (limit: 4915)
        CPU: 572ms
     CGroup: /system.slice/robot_server.service
             └─1500 /usr/bin/python3 /home/admin/src/RaspberryPiEpq/pig.py

Sep 27 22:13:03 raspberrypi systemd[1]: Started EPQ robot arm controller.

```
## Printing Bigger base.
I printed a bigger base as my smaller base was struggling so I thought I needed a bigger motor. There was also a small crack in the original base as I was trying to put a bigger screw in it. I learned that It is better to use smaller holes for the screws instead of bigger screws.

`31/09/2025`

## New Servo Motor

I got the new servo motor and made a new servo data for it. It was acctually very similar to the SG90 I had exept was taller. My first print acctually fitted quite well. I then printed anouther one of my shaft test

`28/09/2025`
## Printing and Designing

When I was testing my arm with all the components the base was struggling to rotate. I was confused as my torque calculator expected it to work. I then learned that continuouse torque is different and I should multiply it by 2 or 3 to be safe.
I then learned that you cannot rely on the 
My old base broke, so I printed a new version with the bigger servo.

I then improved my electromagnet module adding curves as an option as appose to he arm


Learned about background processes
tested new wires

`07/10/2025`
## Robot arm module

I made a module that pieced all the components together into one


`07/10/2025`
## Programming IK

I initially thought the base would be easy but I first had to understand the different quadrants used in 3D and godot. Godot takes -Z as forward +X as right and +y as up
The four quadrants used were 

There are also two arctan functions in gdscript. The atan2 will output the correct quadrant and atan will not.
Because I want slighly different functinallity if it is in the back two quadrants then I would flip the angle in y=-z.
Although I am doing this once per frame, it is only one entitiy so I am not worried about missing out on the optimisations.

`14/10/2025`

I tried to figure out the best way to store the servos rotation, after using the program to control my arm I realised the positions were off, I added a rotation offset parameter that is only applied right at the end when rotating the servos. I also learned about the right hand rule of rotations which helped my apply this to 3D space.

`07/10/2025`

### Constraining Target

I needed to stop the target from going to places it could not acctually reach. First I did this by constraining the pointer, then I did it in the IK code checking if it is solvable.
At the end I did it with a mix of both. 

`07/10/2025`
### Fixing IK above target

My IK was working well below the origin but it wasnt working if the target was abobe the origin
After debugging I figured out the atan function I was using was picking up the wrong angle. I used the atan function which adjusts the angle based on which quadrant it is in.
It was working well after this.
`14/10/25`
## Calabrating IK to arm from godot

I had to match the angles that godot would output to the angles required by the servo.
as the servos were facing opposite directions anticlockwise, which I was taking as the positive direction would be flipped.
I thought the neatest solution was to just send a negative for the one arm segment  in godot.
I tested it one segment/servo at a time as it would be easier to debug.
By the end it was working well from godot.
There would be a few improvements I could make from the pi code as I have not yet calabrated the new servos.

`15/10/25`
## Calabrating IK to arm


## References

#### Serv-Arm by Heartman - Thingiverse  
https://www.thingiverse.com/thing:1684471

### Videos

Jelle Vermandere Big Robot Arm - youtube
https://www.youtube.com/watch?v=u5k2ewa1_is 

Jelle Vermandere Mini Robot Arm - youtube
https://www.youtube.com/watch?v=u5k2ewa1_is 

Jelle Vermandere Micro Robot Arm - youtube
https://www.youtube.com/watch?v=u5k2ewa1_is 

OpenSCAD tutorial for Project Enclosure - MathCodePrint - youtube
https://www.youtube.com/watch?v=lPgLZgnbREk

OpenSCAD introductions - MathCodePrint - youtube
https://www.youtube.com/watch?v=oTCu2hCuqfg&list=PLkRx3bM9e3yDK0NlFz-GomPfkst1ofT5y&index=1 

### Documents

OpenSCAD Cheat Sheet
https://openscad.org/cheatsheet/

Raspberry Pi Pins
https://www.theengineeringprojects.com/2021/03/what-is-raspberry-pi-4-pinout-specs-projects-datasheet.html

SG90 servo datasheet - Imperial Collage London
http://www.ee.ic.ac.uk/pcheung/teaching/DE1_EE/stores/sg90_datasheet.pdf

### Articles

#### Sparkfun Servos Explained
https://www.sparkfun.com/servos

#### Sparkfun Hobby Servos
https://learn.sparkfun.com/tutorials/hobby-servo-tutorial/all

#### Torque for servo motors
https://automaticaddison.com/how-to-determine-what-torque-you-need-for-your-servo-motors/

### Products

Ball Bearings - amazon
https://www.amazon.co.uk/sourcing-map-Bearing-Stainless-Precision/dp/B07YKSD1SH/ref=sr_1_9?dib=eyJ2IjoiMSJ9.x0JxWxhUIVfokdMkT6AFg1PfWcp5vhWm6pB-xcVL5T3jWvmy3ctmrjqjrDzCC4BAPLv6hfJbZ6NTEl4qJf1x5e66pGc4qcgv6xCHjJRJUpLuSUz82j3x4v7KQM_oNGNClJmEPyWdqlznNTLS5BSy6S-Kahnmzskd34n-ECNHiXiqKjBqLEtiz5UGTwve7Plo2Gk38uowR5WP4DkxHGl7c4WHXDABHYBcIip6iL7_QYhOHwycBYs1FMS1AB6gFHloHrv-lTpuYaDuJUSrIYuFRxhZRPUkwE-BpLh9-0ntICI.EAJs3MCR7diZwUGhz4Ux-5wixyV0isM0azREpUpVmm0&dib_tag=se&keywords=steel%2Bball%2Bbearings&qid=1753303104&sr=8-9&th=1 

sg90 servos - Miuzei amazon
https://www.amazon.co.uk/Micro-Helicopter-Airplane-Remote-Control/dp/B07KPS9845/ref=sr_1_1_sspa?crid=120KBDJVI0OX7&dib=eyJ2IjoiMSJ9.ObBr3wesRgGIBtaUSZHZLSej-yTppx-Nm-TM2hmRUO45Qc0aOpG4rfF7VMrM9fAlIe9nXM0fIB4JgT8tYikfi4HsuRFOHknJELM6tU1ySwWF88qLgL4_iNtfIqASH9vqbo4aT896vW2cLTcg3V3-IKu54DX59AbXMM2AOBEVwqKlOYVCRiM5JADz8o2tipSCkTeRkYq5iQG9qJr09rtzqWgeaCK5m84LzhsWqBpNd9FVLEuPgW-Bn30wCusD7d4NMWe8pm0vRoVMjaesE0w2BTgJctz9_sUPxSgFk7KVkbQ.1eZUD4pFvjjgJDZodEbRQ5n0hsxWXING3svT-Rl1KWk&dib_tag=se&keywords=sg90%2Bservo&qid=1761495929&sprefix=sg90%2Bservo%2Caps%2C87&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1

#### MG996R servos - Pihut

https://thepihut.com/products/servo-motor-mg996r-high-torque-metal-gear?srsltid=AfmBOorv6jxMM8T7VpcyTgm5QU8NuffIEoWj4pkQ5HYwmZrIC5NOuWfb

#### Electromagnet - Pihut
https://thepihut.com/products/5v-electromagnet-2-5-kg-holding-force

#### MG92B servos - PiHut
https://thepihut.com/products/towerpro-servo-motor-mg92b-metal-gear?srsltid=AfmBOooLM_eJrakXMkz6deP7bFifsxFM3eVuTHgLAUna1u8Eq-MEEeAt

#### 3D printer
https://store.creality.com/uk/products/ender-3-v3-se-3d-printer?utm_source=google_ads&utm_medium=search&gad_source=1&gad_campaignid=20457631393&gclid=CjwKCAjwpOfHBhAxEiwAm1SwEizCBhxql9OVgwVVGWIWqnG4ORpuSTDXps5xMLeLPUJAa8kvGIMUkBoCg2wQAvD_BwE

#### 3d printer fillament
https://www.amazon.co.uk/Creality-Filament-Hyper-1-75mm-Printer/dp/B0DZVY6D7P/ref=sr_1_3_sspa?adgrpid=165940041753&dib=eyJ2IjoiMSJ9.e6z4Po0lBLNvCwhmKWz1n77iARjegYT-eLpV6E_lzkSbBt42HyYvaOMEDhhllKJIpjUPaktMjRX8jyo_MM5jOuAdJm-KI0cliACgu0SQXFbwHZ9iHR0EZbp6wxscXoRwNiK_d136pX_krr8NNrKoZPbespoTGT1i4kzE2DynxanN2zHUVPSg5Jg6dKPemcEYAiqmfS6sgHrjJdzpXyArn9SkEEPwMo2OOrjZ061QQJdz6Q3gSBHRmItfcHUpOdlcg2dBatYTaZ6NIuOgTr29vVhRcKoRCEOLZH6cQymToYU.ZFcRg9Sk1A4OoxVfldHV5XkXKITH-eqWRUG4IXw-neo&dib_tag=se&gad_source=1&hvadid=705523939616&hvdev=c&hvexpln=69&hvlocphy=9222618&hvnetw=g&hvocijid=16423848959267145223--&hvqmt=b&hvrand=16423848959267145223&hvtargid=kwd-911425806474&hydadcr=14781_2301072&keywords=creality%2Bfilaments&mcid=4cfe0e364bb73442b9cf9e6159ae0e50&qid=1761219310&sr=8-3-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&th=1
