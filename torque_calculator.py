
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