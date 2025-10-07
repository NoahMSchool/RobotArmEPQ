// ServoData

//The top shaft gear info
//shaft_data = [teeth count, shaft diameter, shaft depth]
SG90_shaft_data = [21,5.2,3];
MG996R_shaft_data = [24,6.0, 4.8];
MG92B_shaft_data = [20,4.8,10.8];

//data for inner screws holding the servo
//screw_data = [screw_count, screw_offset_screw_separation, screw_radius, screw_depth]

SG90_screw_data = [1,2.9,0,1.2,12];
//MG996R_screw_data = []

//SG90_screw_data = [1,2,2.5,0.75,5]

MG996R_data = [
    [40.3, 19.4, 27.5], // size
    -10.2,                 // shaft_offset
    11.8,                 // shaft_height
    2.8,                // thickness
    
    2,                  // screw_count
    4.2,                // screw_offset
    10,                 // screw_separation
    1,                  // screw_radius
    15,                 // screw_depth
    
    18,                 // wire_exit_height
    3/4,                // wire_exit_width_frac
    0.75,               // tolerance
    5,                  //wire_exit_amount
    MG996R_shaft_data,     //sg90shaft_data
];

default_data = [
    [20,10,15], // SIZE
    -5,          // SHAFT_OFFSET
    2,          // SHAFT_HEIGHT
    1,          // THICKNESS
    1,          // SCREW_COUNT
    2,          // SCREW_OFFSET
    2.5,        // SCREW_SEPARATION
    0.75,       // SCREW_RADIUS
    5,          // SCREW_DEPTH
    6,          // WIRE_EXIT_HEIGHT
    3/4,        // WIRE_EXIT_WIDTH_FRAC
    0.5,         // TOLERANCE
    5,			//WIRE_EXIT_AMOUNT
    SG90_shaft_data,
];


SG90_data = [
    [22.5, 11.75, 16.1], // SIZE (L, W, H)
    -6,                   // SHAFT_OFFSET
    10.4,                   // SHAFT_HEIGHT
    1,                // THICKNESS
    1,                   // SCREW_COUNT
    2.9,                 // SCREW_OFFSET
    0,                  // SCREW_SEPARATION
    1.2,                 // SCREW_RADIUS
    12,                  // SCREW_DEPTH
    11,                   // WIRE_EXIT_HEIGHT
    3/4,                 // WIRE_EXIT_WIDTH_FRAC
    0.5,                  // TOLERANCE
    5,                    // WIRE_EXIT_AMOUNT
    SG90_shaft_data,   
];


MG92B_data = [
    [22.5, 11.8, 20.8], // size
    4.4,                 // shaft_offset
    5,                 // shaft_height
    0.8,                // thickness
    
    1,                  // screw_count
    2.8,                // screw_offset
    0,                 // screw_separation
    0.8,                  // screw_radius
    14,                 // screw_depth
    
    12,                 // wire_exit_height
    3/4,                // wire_exit_width_frac
    0.5,               // tolerance
    5,                  //wire_exit_amount
    MG92B_shaft_data,     //sg90shaft_data
];