local __configure_player = pewpew.configure_player

camera_mode = {
  free = 0, -- direct control from movement joystick
  entity = 1, -- follow entity with set id
  entities = 2, -- follow entities with set ids
  entity_type = 3, -- follow entities with set type; unoptimized
  entity_types = 4, -- follow entities with set types; unoptimized
  everything = 5, -- follow every entity
}

local function ease_function_no_ease(...)
  return ...
end

local function default_ease_xy(dx, dy)
  local l = fx_sqrt(dx * dx + dy * dy)
  if l > 100fx then
    return dx / l * camera.speed, dy / l * camera.speed
  else
    return fx_sin(dx / 100fx) * camera.speed, fx_sin(dy / 100fx) * camera.speed
  end
end

local function default_ease_z(dz)
  if fx_abs(dz) > 50fx then
    return fx_abs(dz) / dz * 50fx
  else
    return fx_sin(dz / 50fx) * camera.speed
  end
end

local function default_ease_angle(da)
  return fx_sin(da / 2fx) * camera.angle_speed
end

camera = {
  
  current_x = 0fx, -- current camera states
  current_y = 0fx,
  current_z = 0fx,
  current_angle = 0fx,
  
  offset_x = 0fx, -- offset applied at any moment
  offset_y = 0fx,
  offset_z = 0fx,
  offset_angle = 0fx,
  
  static_x = nil, -- value will be static and can't be changed any other way
  static_y = nil,
  static_z = nil,
  static_angle = nil,
  
  min_x = nil, -- value can't get lower than this
  min_y = nil,
  min_z = nil,
  min_angle = nil,
  
  max_x = nil, -- value can't get bigger than this
  max_y = nil,
  max_z = nil,
  max_angle = nil,
  
  ease_function_xy = ease_function_no_ease, -- functions to ease change of respective values
  ease_function_z = ease_function_no_ease, -- input and output are respective delta values
  ease_function_angle = ease_function_no_ease,
  
  speed = 10fx, -- speed of camera. Used in free mode and should be used for ease functions
  angle_speed = 0.512fx,
  
  mode = camera_mode.entity_type, -- camera mode, controls which entities are followed or if it's in free mode
  args = entity_type.ship, -- arguments for respective camera mode
  
  movement_xy_offset = nil, -- respective offsets on joysticks movements
  movement_z_offset = nil,
  movement_angle_offset = nil,
  shooting_xy_offset = nil,
  shooting_z_offset = nil,
  shooting_angle_offset = nil,
  
}

local function update_camera()
  __configure_player(0, {camera_x_override = camera.current_x, camera_y_override = camera.current_y, camera_distance = camera.current_z, camera_rotation_x_axis = camera.current_angle})
end

local function camera_main()
  if camera.mode == camera_mode.free then
    camera.current_x = camera.current_x + inputs.mdx * camera.speed
    camera.current_y = camera.current_y + inputs.mdy * camera.speed
    camera.current_z = camera.current_z + camera.ease_function_z(camera.offset_z - camera.current_z)
    camera.current_angle = camera.current_angle + camera.ease_function_angle(camera.offset_angle - camera.current_angle)
    update_camera()
    return
  end
  
  local goal_x, goal_y, goal_z, goal_angle = 0fx, 0fx, 0fx, 0fx
  local entity_amount = 0fx
  local no_goal = true
  
  if camera.mode == camera_mode.entity and entity_get_is_alive(camera.args) then
    goal_x, goal_y = entity_get_pos(camera.args)
    no_goal = false
  elseif camera.mode == camera_mode.entities then
    for i = #camera.args, 1, -1 do
      if entity_get_is_alive(camera.args[i]) then
        local x, y = entity_get_pos(camera.args[i])
        goal_x, goal_y = goal_x + x, goal_y + y
      else
        table.remove(camera.args, i)
      end
    end
    if #camera.args ~= 0 then
      entity_amount = to_fx(#camera.args)
      goal_x, goal_y = goal_x / entity_amount, goal_y / entity_amount
      no_goal = false
    end
  elseif camera.mode == camera_mode.entity_type then
    for _, id in ipairs(get_all_entities()) do
      if entity_get_is_alive(id) and get_entity_type(id) == camera.args then
        local x, y = entity_get_pos(id)
        goal_x, goal_y = goal_x + x, goal_y + y
        entity_amount = entity_amount + 1fx
      end
    end
    if entity_amount ~= 0fx then
      goal_x, goal_y = goal_x / entity_amount, goal_y / entity_amount
      no_goal = false
    end
  elseif camera.mode == camera_mode.entity_types then
    for _, id in ipairs(get_all_entities()) do
      if entity_get_is_alive(id) then
        local is_correct_type = false
        local et = get_entity_type(id)
        for _, t in ipairs(camera.args) do
          if et == t then
            is_correct_type = true
            break
          end
        end
        if is_correct_type then
          local x, y = entity_get_pos(id)
          goal_x, goal_y = goal_x + x, goal_y + y
          entity_amount = entity_amount + 1fx
        end
      end
    end
    if entity_amount ~= 0fx then
      goal_x, goal_y = goal_x / entity_amount, goal_y / entity_amount
      no_goal = false
    end
  elseif camera.mode == camera_mode.everything then
    local entities = get_all_entities()
    if #entities ~= 0 then
      for _, id in ipairs(entities) do
        if entity_get_is_alive(id) then
          local x, y = entity_get_pos(id)
          goal_x, goal_y = goal_x + x, goal_y + y
          entity_amount = entity_amount + 1fx
        end
      end
      if entity_amount ~= 0fx then
        goal_x, goal_y = goal_x / entity_amount, goal_y / entity_amount
        no_goal = false
      end
    end
  end
  
  if no_goal then
    goal_x, goal_y = camera.current_x, camera.current_y
  end
  
  if camera.movement_xy_offset then
    goal_x, goal_y = goal_x + inputs.mdx * camera.movement_xy_offset, goal_y + inputs.mdy * camera.movement_xy_offset
  end
  if camera.movement_z_offset then
    goal_z = goal_z + inputs.md * camera.movement_z_offset
  end
  if camera.movement_angle_offset then
    goal_angle = goal_angle + inputs.mdy * camera.movement_angle_offset
  end
  
  if camera.shooting_xy_offset then
    goal_x, goal_y = goal_x + inputs.sdx * camera.shooting_xy_offset, goal_y + inputs.sdy * camera.shooting_xy_offset
  end
  if camera.shooting_z_offset then
    goal_z = goal_z + inputs.sd * camera.shooting_z_offset
  end
  if camera.shooting_angle_offset then
    goal_angle = goal_angle + inputs.sdy * camera.shooting_angle_offset
  end
  
  goal_x = goal_x + (camera.offset_x or 0fx)
  goal_y = goal_y + (camera.offset_y or 0fx)
  goal_z = goal_z + (camera.offset_z or 0fx)
  goal_angle = goal_angle + (camera.offset_angle or 0fx)
  
  goal_x = camera.min_x and goal_x < camera.min_x and camera.min_x or goal_x
  goal_y = camera.min_y and goal_y < camera.min_y and camera.min_y or goal_y
  goal_z = camera.min_z and goal_z < camera.min_z and camera.min_z or goal_z
  goal_angle = camera.min_angle and goal_angle < camera.min_angle and camera.min_angle or goal_angle
  
  goal_x = camera.max_x and goal_x > camera.max_x and camera.max_x or goal_x
  goal_y = camera.max_y and goal_y > camera.max_y and camera.max_y or goal_y
  goal_z = camera.max_z and goal_z > camera.max_z and camera.max_z or goal_z
  goal_angle = camera.max_angle and goal_angle > camera.max_angle and camera.max_angle or goal_angle
  
  goal_x = camera.static_x or goal_x
  goal_y = camera.static_y or goal_y
  goal_z = camera.static_z or goal_z
  goal_angle = camera.static_angle or goal_angle
  
  local dx = goal_x - camera.current_x
  local dy = goal_y - camera.current_y
  local dz = goal_z - camera.current_z
  local da = goal_angle - camera.current_angle
  
  if dx ~= 0fx or dy ~= 0fx then
    dx, dy = camera.ease_function_xy(goal_x - camera.current_x, goal_y - camera.current_y)
    camera.current_x = camera.current_x + dx
    camera.current_y = camera.current_y + dy
  end
  if dz ~= 0fx then
    dz = camera.ease_function_z(goal_z - camera.current_z)
    camera.current_z = camera.current_z + dz
  end
  if da ~= 0fx then
    da = camera.ease_function_angle(goal_angle - camera.current_angle)
    camera.current_angle = camera.current_angle + da
  end
  
  update_camera()
end

add_post_update_callback(camera_main)


function camera.set_args(t, args)
  camera.mode = t
  camera.args = args
end

function camera.set_ease_functions(xy, z, angle)
  camera.ease_function_xy = xy
  camera.ease_function_z = z
  camera.ease_function_angle = angle
end

function camera.remove_ease()
  camera.ease_function_xy = ease_function_no_ease
  camera.ease_function_z = ease_function_no_ease
  camera.ease_function_angle = ease_function_no_ease
end

function camera.set_default_ease()
  camera.ease_function_xy = default_ease_xy
  camera.ease_function_z = default_ease_z
  camera.ease_function_angle = default_ease_angle
end

function camera.force_pos(x, y, z)
  camera.current_x = x
  camera.current_y = y
  camera.current_z = z
  update_camera()
end

function camera.force_angle(a)
  camera.current_angle = a
  update_camera()
end

function camera.set_offset_pos(x, y, z)
  camera.offset_x = x
  camera.offset_y = y
  camera.offset_z = z
end

function camera.set_offset_angle(a)
  camera.offset_angle = a
end

function camera.set_static_pos(x, y, z)
  camera.static_x = x
  camera.static_y = y
  camera.static_z = z
end

function camera.set_static_angle(a)
  camera.static_angle = a
end

function camera.remove_static_pos()
  camera.static_x = nil
  camera.static_y = nil
  camera.static_z = nil
end

function camera.remove_static_angle()
  camera.static_angle = nil
end

function camera.set_min_pos(x, y, z)
  camera.min_x = x
  camera.min_y = y
  camera.min_z = z
end

function camera.set_min_angle(a)
  camera.min_angle = a
end

function camera.remove_min_pos()
  camera.min_x = nil
  camera.min_y = nil
  camera.min_z = nil
end

function camera.remove_min_angle()
  camera.min_a = nil
end

function camera.set_max_pos(x, y, z)
  camera.max_x = x
  camera.max_y = y
  camera.max_z = z
end

function camera.set_max_angle(a)
  camera.max_angle = a
end

function camera.remove_max_pos()
  camera.max_x = nil
  camera.max_y = nil
  camera.max_z = nil
end

function camera.remove_max_angle()
  camera.max_a = nil
end

function camera.remove_joystick_offsets()
  camera.movement_xy_offset = nil
  camera.movement_z_offset = nil
  camera.movement_angle_offset = nil
  camera.shooting_xy_offset = nil
  camera.shooting_z_offset = nil
  camera.shooting_angle_offset = nil
end
