#Robot arm torque calculator

#Segment (name, length/cm, segment_mass/g, effector)
#Servo_data (mass/g, torque/kgcm^-1)  --Other effectors use this with zero torque


#components
SG90 = (10, 1.8)
electromagnet = (10,0)



#SG90 arm
arm = [("base", 0, 0, SG90), ("middle_seg", 10, 20, SG90), ("magnet", 10, 20, electromagnet)]

#30cm work envelope
#arm = [("base", 0, 0,SG90),("middle", 16, 35, SG90),("end", 16, 35, electromagnet)]


print("<---------------->")

mass_distances = []

for segment in reversed(arm):

  torque_req = 0
  for md in mass_distances:
    torque_req += md[0]*md[1]

  if segment[3][1]<torque_req:
    print(f"_{segment[0]}_ has too little torque : has {segment[3][1]} requires {round(torque_req, 5)}")
  else:
    print(f"_{segment[0]}_ has enough torque : has {segment[3][1]} requires {round(torque_req, 5)}")

  for md in mass_distances:
    md[1]+= segment[1]


  mass_distances.append([segment[3][0]*0.001,segment[1]])
  mass_distances.append([segment[2]*0.001,segment[1]/2])

total_mass = 0

for md in mass_distances:
  total_mass += md[0]

print("total mass:", round(total_mass, 5), "kg")
print("total length: ", round(mass_distances[0][1], 5), "cm")

#MG90D_1 = ("MG90D_ 1", 0, 1.5, 0.013)
#MG90D_2 = ("MG90D_2", 6.5, 1.5, 0.013)
