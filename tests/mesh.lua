require'/dynamic/ppol/.lua'
def_meshes(1)
a = 50
meshes[1]:add_polygon(0xffffffff, {-a, -a}, {-a, a}, {a, a}, {a, -a})