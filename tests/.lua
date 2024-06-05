function add_test_mesh(x, y, c, s)
  local id = new_entity(x, y)
  entity_start_spawning(id)
  entity_set_mesh(id, 'tests/mesh')
  entity_set_mesh_color(id, c)
  entity_set_mesh_scale(id, s or 1fx)
  return id
end

add_test_mesh(0fx, 0fx, 0x00ff00ff)
add_test_mesh(-300fx, -300fx, 0x00ff00ff)
add_test_mesh(-300fx, 300fx, 0x00ff00ff)
add_test_mesh(300fx, 300fx, 0x00ff00ff)

add_test_mesh(250fx, -250fx, 0x00ff00ff, 0.2048fx)
add_test_mesh(250fx, -350fx, 0x00ff00ff, 0.2048fx)
add_test_mesh(350fx, -350fx, 0x00ff00ff, 0.2048fx)
add_test_mesh(350fx, -250fx, 0x00ff00ff, 0.2048fx)

local id = add_test_mesh(10fx, 10fx, 0xff0000ff, 1fx)
entity_set_mesh_angle(id, FX_PI / 4fx, 0fx, 0fx, 1fx)

camera.set_args(camera_mode.entity, id)

add_update_callback(function()
  entity_change_pos(id, inputs.mdx * 10fx, inputs.mdy * 10fx)
end)
