
g = 9.81

#Servo_data (name, mass/g, torque/kgcm^-1)


SG90a = ("A_SG90", 9, 1.8)
SG90b = ("B_SG90", 9, 1.8)
SG90c = ("C_SG90", 9, 1.8)

#Segment (length/cm, segment_mass/g, effector)
seg1 = (10, 20, SG90a)
seg2 = (10, 20, SG90b)
seg3 = (10, 20, SG90c)

arm = [seg1, seg1, seg1]

weight_distances = []

print("----------------")

for segment in reversed(arm):
  for wd in weight_distances:
    wd[1]+= segment[0]

  weight_distances.append([segment[2][1]*0.001*g,0])
  weight_distances.append([segment[1]*0.001*g,segment[0]/2])

  torque_req = 0
  for wd in weight_distances:
    torque_req += wd[0]*wd[1]

  if segment[2][2]<torque_req:
    print(f"_{segment[2][0]}_ has too little torque : has {segment[2][2]} requires {round(torque_req, 2)}")
  else:
    print(f"_{segment[2][0]}_ has enough torque : has {segment[2][2]} requires {round(torque_req, 2)}")



#MG90D_1 = ("MG90D_ 1", 0, 1.5, 0.013)
#MG90D_2 = ("MG90D_2", 6.5, 1.5, 0.013)