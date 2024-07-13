PLAYER_SHIP_SPEED = 10fx

local _et = pewpew.EntityType
entity_type = {
  asteroid          = _et.ASTEROID,
  baf               = _et.BAF,
  inertiac          = _et.INERTIAC,
  mothership        = _et.MOTHERSHIP,
  mothership_bullet = _et.MOTHERSHIP_BULLET,
  rolling_cube      = _et.ROLLING_CUBE,
  rolling_sphere    = _et.ROLLING_SPHERE,
  ufo               = _et.UFO,
  wary              = _et.WARY,
  crowder           = _et.CROWDER,
  custom            = _et.CUSTOMIZABLE_ENTITY,
  ship              = _et.SHIP,
  bomb              = _et.BOMB,
  baf_blue          = _et.BAF_BLUE,
  baf_red           = _et.BAF_RED,
  wary_missile      = _et.WARY_MISSILE,
  ufo_bullet        = _et.UFO_BULLET,
  player_bullet     = _et.PLAYER_BULLET,
  bomb_explosion    = _et.BOMB_EXPLOSION,
  player_explosion  = _et.PLAYER_EXPLOSION,
  bonus             = _et.BONUS,
  floating_message  = _et.FLOATING_MESSAGE,
  pointonium        = _et.POINTONIUM,
  bonus_implosion   = _et.BONUS_IMPLOSION,
}
local _mt = pewpew.MothershipType
mothership_type = {
  [3] = _mt.THREE_CORNERS,
  [4] = _mt. FOUR_CORNERS,
  [5] = _mt. FIVE_CORNERS,
  [6] = _mt.  SIX_CORNERS,
  [7] = _mt.SEVEN_CORNERS,
}
local _ct = pewpew.CannonType
cannon_type = {
  single          = _ct.SINGLE,
  tic_toc         = _ct.TIC_TOC,
  double          = _ct.DOUBLE,
  triple          = _ct.TRIPLE,
  four_directions = _ct.FOUR_DIRECTIONS,
  double_swipe    = _ct.DOUBLE_SWIPE,
  hemisphere      = _ct.HEMISPHERE,
}
local _cf = pewpew.CannonFrequency
cannon_frequency = {
  [1]   = _cf.FREQ_1,
  [2]   = _cf.FREQ_2,
  [3]   = _cf.FREQ_3,
  [5]   = _cf.FREQ_5,
  [6]   = _cf.FREQ_6,
  [7.5] = _cf.FREQ_7_5,
  [10]  = _cf.FREQ_10,
  [15]  = _cf.FREQ_15,
  [30]  = _cf.FREQ_30,
}
local _bt = pewpew.BombType
bomb_type = {
  freeze        = _bt.FREEZE,
  repulsive     = _bt.REPULSIVE,
  atomize       = _bt.ATOMIZE,
  small_atomize = _bt.SMALL_ATOMIZE,
  small_freeze  = _bt.SMALL_FREEZE,
}
local _nt = pewpew.BonusType
local bonus_type = {
  reinstantiation = _nt.REINSTANTIATION,
  shield          = _nt.SHIELD,
  speed           = _nt.SPEED,
  weapon          = _nt.WEAPON,
}
local _wt = pewpew.WeaponType
weapon_type = {
  bullet              = _wt.BULLET,
  freeze_explosion    = _wt.FREEZE_EXPLOSION,
  repulsive_explosion = _wt.REPULSIVE_EXPLOSION,
  atomize_explosion   = _wt.ATOMIZE_EXPLOSION,
}
if pewpew.AsteroidSize then -- fix due to latest available ppl-utils version being not up-to-date
  local _as = pewpew.AsteroidSize
  asteroid_size = {
    small      = _as.SMALL,
    medium     = _as.MEDIUM,
    large      = _as.LARGE,
    very_large = _as.VERY_LARGE,
  }
else
  asteroid_size = {
    small      = 0,
    medium     = 1,
    large      = 2,
    very_large = 3,
  }
end

_et = nil
_mt = nil
_ct = nil
_cf = nil
_bt = nil
_nt = nil
_wt = nil



local __set_level_size = pewpew.set_level_size
function set_level_size(x, y)
  return __set_level_size(x, y or x)
end

add_wall = pewpew.add_wall
remove_wall = pewpew.remove_wall

local update_callbacks = {}
local post_update_callbacks = {}
local tmp_update_callbacks = {}
pewpew.add_update_callback(function()
  for _, c in ipairs(update_callbacks) do
    c()
  end
  for _, c in ipairs(post_update_callbacks) do
    c()
  end
  for i = #tmp_update_callbacks, 1, -1 do
    tmp_update_callbacks[i]()
    table.remove(tmp_update_callbacks, i)
  end
end)

function add_update_callback(f)
  table.insert(update_callbacks, f)
end

function add_post_update_callback(f)
  table.insert(post_update_callbacks, 1, f)
end

function add_tmp_update_callback(f)
  table.insert(tmp_update_callbacks, f)
end

local __increase_score_of_player = pewpew.increase_score_of_player
function increase_score(v)
  return __increase_score_of_player(0, v)
end

local __increase_score_streak_of_player = pewpew.increase_score_streak_of_player
function increase_score_streak(v)
  return __increase_score_streak_of_player(0, v)
end

local __get_score_streak_level = pewpew.get_score_streak_level
function get_score_streak_level()
  return __get_score_streak_level(0)
end

stop_game = pewpew.stop_game

local __get_score_of_player = pewpew.get_score_of_player
function get_score()
  return __get_score_of_player(0)
end

local __configure_player_hud = pewpew.configure_player_hud
function set_hud_string(str)
  return __configure_player_hud(0, {top_left_line = str})
end

local __configure_player_ship_weapon = pewpew.configure_player_ship_weapon
function set_player_ship_weapon(id, frequency, cannon, duration)
  return __configure_player_ship_weapon(id, {frequency = frequency, cannon = cannon, duration = duration})
end

local __add_damage_to_player_ship = pewpew.add_damage_to_player_ship
function damage_player_ship(id, v)
  return __add_damage_to_player_ship(id, v or 1)
end

add_arrow = pewpew.add_arrow_to_player_ship
remove_arrow = pewpew.remove_arrow_from_player_ship
make_player_ship_transparent = pewpew.make_player_ship_transparent

local __set_player_ship_speed = pewpew.set_player_ship_speed
function set_player_ship_speed(id, speed, duration)
  return __set_player_ship_speed(id, 0fx, speed, duration or -1)
end

get_all_entities = pewpew.get_all_entities
get_entities_in = pewpew.get_entities_colliding_with_disk
get_entity_count = pewpew.get_entity_count
get_entity_type = pewpew.get_entity_type

local __play_sound = pewpew.play_sound
local __play_ambient_sound = pewpew.play_ambient_sound
function play_sound(path, v1, v2, v3)
  if v2 then
    __play_sound(mpath(path), v3 or 0, v1, v2)
  else
    __play_ambient_sound(mpath(path), v1 or 0)
  end
end

create_explosion = pewpew.create_explosion

local __new_asteroid = pewpew.new_asteroid
local __new_asteroid_with_size = pewpew.new_asteroid_with_size
function new_asteroid(x, y, size)
  return size and __new_asteroid_with_size(x, y, size) or __new_asteroid(x, y)
end

local __new_baf = pewpew.new_baf
function new_baf(x, y, angle, speed, lifetime)
  return __new_baf(x, y, angle, speed, lifetime or -1)
end

local __new_baf_red = pewpew.new_baf_red
function new_baf_red(x, y, angle, speed, lifetime)
  return __new_baf_red(x, y, angle, speed, lifetime or -1)
end

local __new_baf_blue = pewpew.new_baf_blue
function new_baf_blue(x, y, angle, speed, lifetime)
  return __new_baf_blue(x, y, angle, speed, lifetime or -1)
end

new_bomb = pewpew.new_bomb
new_crowder = pewpew.new_crowder

local __new_floating_message = pewpew.new_floating_message
function new_floating_message(x, y, str, scale, duration, is_optional)
  return __new_floating_message(x, y, str, {scale = scale, ticks_before_fade = duration, is_optional = is_optional})
end

local __new_customizable_entity = pewpew.new_customizable_entity
function new_entity(x, y, v)
  local id = __new_customizable_entity(x, y)
  entity_set_position_interpolation(id, v == nil or v)
  return id
end

new_inertiac = pewpew.new_inertiac
new_mothership = pewpew.new_mothership
new_pointonium = pewpew.new_pointonium

local __new_player_ship = pewpew.new_player_ship
function new_player_ship(x, y)
  local id =  __new_player_ship(x, y, 0)
  set_player_ship_speed(id, PLAYER_SHIP_SPEED)
  return id
end

local __new_player_bullet = pewpew.new_player_bullet
function new_player_bullet(x, y, angle)
  return __new_player_bullet(x, y, angle, 0)
end

local __new_rolling_cube = pewpew.new_rolling_cube
local __rolling_cube_set_enable_collisions_with_walls = pewpew.rolling_cube_set_enable_collisions_with_walls
function new_rolling_cube(x, y, v)
  local id = __new_rolling_cube(x, y)
  __rolling_cube_set_enable_collisions_with_walls(id, v == nil or v)
  return id
end

new_rolling_sphere = pewpew.new_rolling_sphere
new_wary = pewpew.new_wary

local __new_ufo = pewpew.new_ufo
local __ufo_set_enable_collisions_with_walls = pewpew.ufo_set_enable_collisions_with_walls
function new_ufo(x, y, dx, v)
  local id = __new_ufo(x, y, dx)
  __ufo_set_enable_collisions_with_walls(id, v == nil or v)
  return id
end

entity_get_pos = pewpew.entity_get_position
entity_get_is_alive = pewpew.entity_get_is_alive
entity_get_is_exploding = pewpew.entity_get_is_started_to_be_destroyed
entity_set_pos = pewpew.entity_set_position
entity_set_radius = pewpew.entity_set_radius
entity_set_update_callback = pewpew.entity_set_update_callback
entity_destroy = pewpew.entity_destroy

local __entity_react_to_weapon = pewpew.entity_react_to_weapon
function entity_react_to_weapon(id, weapon_type, x, y)
  return __entity_react_to_weapon(id, {type = weapon_type, x = x, y = y, player_index = 0})
end

entity_set_position_interpolation = pewpew.customizable_entity_set_position_interpolation

local __customizable_entity_set_mesh = pewpew.customizable_entity_set_mesh
local __customizable_entity_set_flipping_meshes = pewpew.customizable_entity_set_flipping_meshes
function entity_set_mesh(id, path, i1, i2)
  return i2 and __customizable_entity_set_flipping_meshes(id, mpath(path), i1, i2) or __customizable_entity_set_mesh(id, mpath(path), i1 or 0)
end

entity_set_mesh_color = pewpew.customizable_entity_set_mesh_color
entity_set_string = pewpew.customizable_entity_set_string
entity_set_mesh_xyz = pewpew.customizable_entity_set_mesh_xyz
entity_set_mesh_z = pewpew.customizable_entity_set_mesh_z

local __customizable_entity_set_mesh_xyz_scale = pewpew.customizable_entity_set_mesh_xyz_scale
function entity_set_mesh_scale(id, x, y, z)
  return __customizable_entity_set_mesh_xyz_scale(id, x, y or x, z or y and 1fx or x)
end

entity_set_mesh_angle = pewpew.customizable_entity_set_mesh_angle
entity_set_music_sync = pewpew.customizable_entity_configure_music_response
entity_add_mesh_angle = pewpew.customizable_entity_add_rotation_to_mesh
entity_set_render_radius = pewpew.customizable_entity_set_visibility_radius

local __customizable_entity_configure_wall_collision = pewpew.customizable_entity_configure_wall_collision
function entity_set_wall_collision(id, v, f)
  local t = get_entity_type(id)
  if t == entity_type.custom then
    __customizable_entity_configure_wall_collision(id, v, f)
  elseif t == entity_type.rolling_cube then
    __rolling_cube_set_enable_collisions_with_walls(id, v)
  else
    __ufo_set_enable_collisions_with_walls(id, v)
  end
end

entity_set_player_collision = pewpew.customizable_entity_set_player_collision_callback
entity_set_weapon_collision = pewpew.customizable_entity_set_weapon_collision_callback

local __customizable_entity_start_spawning = pewpew.customizable_entity_start_spawning
function entity_start_spawning(id, t)
  return __customizable_entity_start_spawning(id, t or 0)
end

entity_start_exploding = pewpew.customizable_entity_start_exploding



local __configure_player = pewpew.configure_player
function set_has_lost(v)
  return __configure_player(0, {has_lost = v})
end

function set_shield(v)
  return __configure_player(0, {shield = v})
end

function set_joystick_colors(c1, c2)
  return __configure_player(0, {move_joystick_color = c1, shoot_joystick_color = c2})
end

local __get_player_configuration = pewpew.get_player_configuration
function get_has_lost()
  return __get_player_configuration(0).has_lost
end

function get_shield()
  return __get_player_configuration(0).shield
end

local __new_bonus = pewpew.new_bonus
function new_bonus_shield(x, y, shield, box_duration, callback)
  return __new_bonus(x, y, bonus_type.shield, {number_of_shields = shield, box_duration = box_duration, taken_callback = callback})
end

function new_bonus_weapon(x, y, cannon, frequency, weapon_duration, box_duration, callback)
  return __new_bonus(x, y, bonus_type.weapon, {cannon = cannon, frequency = frequency, weapon_duration = weapon_duration, box_duration = box_duration, taken_callback = callback})
end

function new_bonus_speed(x, y, speed, speed_duration, box_duration, callback)
  return __new_bonus(x, y, bonus_type.speed, {speed_factor = 0fx, speed_offset = speed, speed_duration = speed_duration, box_duration = box_duration, taken_callback = callback})
end

function entity_change_pos(id, dx, dy)
  local x, y = entity_get_pos(id)
  entity_set_pos(id, x + dx, y + dy)
end

function preload_sounds(folder, ...)
  local args = {...}
  add_tmp_update_callback(function()
    if #args == 1 or type(args[2]) == 'string' then
      for _, file in ipairs(args) do
        play_sound(string.format('%s/%s', folder, file), -10000fx, -10000fx)
      end
    else
      for i = 1, #args, 2 do
        for k = 0, args[i + 1] - 1 do
          play_sound(string.format('%s/%s', folder, args[i]), -10000fx, -10000fx, k)
        end
      end
    end
  end)
end

local __get_player_inputs = pewpew.get_player_inputs
inputs = {}
add_update_callback(function()
  inputs.ma, inputs.md, inputs.sa, inputs.sd = __get_player_inputs(0)
  inputs.mdy, inputs.mdx = fx_sincos(inputs.ma)
  inputs.mdy, inputs.mdx = inputs.mdy * inputs.md, inputs.mdx * inputs.md
  inputs.sdy, inputs.sdx = fx_sincos(inputs.sa)
  inputs.sdy, inputs.sdx = inputs.sdy * inputs.sd, inputs.sdx * inputs.sd
end)
