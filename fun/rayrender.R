# To install the latest version from Github:
# install.packages("devtools")
library(devtools)
devtools::install_github("tylermorganwall/rayrender")

library(rayrender)

scene = generate_ground(material=diffuse(checkercolor="grey20")) %>%
  add_object(sphere(y=0.2,material=glossy(color="#2b6eff",reflectance=0.05))) 
render_scene(scene, parallel = TRUE, width = 800, height = 800, samples = 1000)

scene = generate_ground(material=diffuse(checkercolor="grey20")) %>%
  add_object(sphere(y=0.2,material=glossy(color="#2b6eff",reflectance=0.05))) %>%
  add_object(sphere(y=6,z=1,radius=4,material=light(intensity=8))) %>%
  add_object(sphere(z=15,material=light(intensity=70)))
render_scene(scene, parallel = TRUE, width = 800, height = 800, samples = 1000, clamp_value=10)

scene = generate_ground(material=diffuse(checkercolor="grey20")) %>%
  add_object(sphere(y=0.2,material=glossy(color="#2b6eff",reflectance=0.05))) %>%
  add_object(obj_model(r_obj(),z=1,y=-0.05,scale_obj=0.45,material=diffuse())) %>%
  add_object(sphere(y=10,z=1,radius=4,material=light(intensity=8))) %>%
  add_object(sphere(z=15,material=light(intensity=70)))
render_scene(scene, parallel = TRUE, width = 800, height = 800, samples = 1000, clamp_value=10)