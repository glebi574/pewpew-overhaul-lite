mothership_type = {0, 0, 0, 1, 2, 3, 4}

local _et = pewpew.EntityType
entity_type = {
  asteroid = _et.ASTEROID,
  baf = _et.BAF,
  inertiac = _et.INERTIAC,
  mothership = _et.MOTHERSHIP,
  mothership_bullet = _et.MOTHERSHIP_BULLET,
  rolling_cube = _et.ROLLING_CUBE,
  rolling_sphere = _et.ROLLING_SPHERE,
  ufo = _et.UFO,
  wary = _et.WARY,
  crowder = _et.CROWDER,
  custom = _et.CUSTOMIZABLE_ENTITY,
  ship = _et.SHIP,
  bomb = _et.BOMB,
  baf_blue = _et.BAF_BLUE,
  baf_red = _et.BAF_RED,
  wary_missile = _et.WARY_MISSILE,
  ufo_bullet = _et.UFO_BULLET,
  player_bullet = _et.PLAYER_BULLET,
  bomb_explosion = _et.BOMB_EXPLOSION,
  player_explosion = _et.PLAYER_EXPLOSION,
  bonus = _et.BONUS,
  floating_message = _et.FLOATING_MESSAGE,
  pointonium = _et.POINTONIUM,
  bonus_implosion = _et.BONUS_IMPLOSION,
}
local _ct = pewpew.CannonType
cannon_type = {
  single = _ct.SINGLE,
  tic_toc = _ct.TIC_TOC,
  double = _ct.DOUBLE,
  triple = _ct.TRIPLE,
  four_directions = _ct.FOUR_DIRECTIONS,
  double_swipe = _ct.DOUBLE_SWIPE,
  hemisphere = _ct.HEMISPHERE,
}
local _cf = pewpew.CannonFrequency
cannon_frequency = {
  _30 = _cf.FREQ_30,
  _15 = _cf.FREQ_15,
  _10 = _cf.FREQ_10,
  _7_5 = _cf.FREQ_7_5,
  _6 = _cf.FREQ_6,
  _5 = _cf.FREQ_5,
  _3 = _cf.FREQ_3,
  _2 = _cf.FREQ_2,
  _1 = _cf.FREQ_1,
}
local _bt = pewpew.BombType
bomb_type = {
  freeze = _bt.FREEZE,
  repulsive = _bt.REPULSIVE,
  atomize = _bt.ATOMIZE,
  small_atomize = _bt.SMALL_ATOMIZE,
  small_freeze = _bt.SMALL_FREEZE,
}
local _nt = pewpew.BonusType
bonus_type = {
  reinstantiation = _nt.REINSTANTIATION,
  shield = _nt.SHIELD,
  speed = _nt.SPEED,
  weapon = _nt.WEAPON,
}
local _wt = pewpew.WeaponType
weapon_type = {
  bullet = _wt.BULLET,
  freeze_explosion = _wt.FREEZE_EXPLOSION,
  repulsive_explosion = _wt.REPULSIVE_EXPLOSION,
  atomize_explosion = _wt.ATOMIZE_EXPLOSION,
}


add_update_callback = pewpew.add_update_callback
stop_game = pewpew.stop_game
create_explosion = pewpew.create_explosion
entity_set_pos = pewpew.entity_set_posisiton
entity_is_alive = pewpew.entity_get_is_alive
entity_is_exploding = pewpew.entity_get_is_started_to_be_destroyed
entity_destroy = pewpew.entity_destroy
entity_set_mesh_color = pewpew.customizable_entity_set_mesh_color
entity_set_string = pewpew.customizable_entity_set_string
entity_set_mesh_xyz = pewpew.customizable_entity_set_mesh_xyz
entity_set_mesh_angle = pewpew.customizable_entity_set_mesh_angle
entity_set_music_sync = pewpew.customizable_entity_configure_music_response
entity_add_mesh_angle = pewpew.customizable_entity_add_rotation_to_mesh
entity_set_render_radius = pewpew.customizable_entity_set_visibility_radius
entity_start_spawning = pewpew.customizable_entity_start_spawning
entity_start_exploding = pewpew.customizable_entity_start_exploding

add_wall = pewpew.add_wall
remove_wall = pewpew.remove_wall
damage_player_ship = pewpew.add_damage_to_player_ship
add_arrow = pewpew.add_arrow_to_player_ship
remove_arrow = pewpew.remove_arrow_from_player_ship
make_player_ship_transparent = pewpew.make_player_ship_transparent
set_player_ship_speed = pewpew.set_player_ship_speed
get_all_entities = pewpew.get_all_entities
get_entities_in = pewpew.get_entities_colliding_with_disk
get_entity_count = pewpew.get_entity_count
get_entity_type = pewpew.get_entity_type
new_bomb = pewpew.new_bomb
new_bonus = pewpew.new_bonus
new_crowder = pewpew.new_crowder
new_inertiac = pewpew.new_inertiac
new_mothership = pewpew.new_mothership
new_pointonium = pewpew.new_pointonium
new_rolling_cube = pewpew.new_rolling_cube
new_rolling_sphere = pewpew.new_rolling_sphere
new_wary = pewpew.new_wary
new_ufo = pewpew.new_ufo
entity_get_pos = pewpew.entity_get_position
entity_set_radius = pewpew.entity_set_radius
entity_set_update_callback = pewpew.entity_set_update_callback
entity_set_wall_collision = pewpew.customizable_entity_configure_wall_collision
entity_set_player_collision = pewpew.customizable_entity_set_player_collision_callback
entity_set_weapon_collision = customizable_entity_set_weapon_collision_callback


local inc_scr = pewpew.increase_score_of_player
function increase_score(v)
  return inc_scr(0, v)
end

local get_scr = pewpew.get_score_of_player
function get_score()
  return get_scr(0)
end

local _get_inputs = pewpew.get_player_inputs
function get_inputs()
  return _get_inputs(0)
end

local cfg_hud = pewpew.configure_player_hud
function configure_hud_string(str)
  return cfg_hud(0, {top_left_line = str})
end

local _play_sound = pewpew.play_sound
local _play_soundA = pewpew.play_ambient_sound
function play_sound(path, v1, v2, v3)
  return v2 and _play_soundA(mpath(path), v1, v2, v3 or 0) or _play_sound(mpath(path), v1 or 0)
end

local _new_entity = pewpew.new_customizable_entity
local _entity_smooth = pewpew.customizable_entity_set_position_interpolation
function new_entity(x, y)
  local id = _new_entity(x, y)
  _entity_smooth(id, true)
  return id
end

local _set_mesh = pewpew.customizable_entity_set_mesh
local _set_anim = pewpew.entity_set_flipping_meshes
function entity_set_mesh(id, path, i1, i2)
  return i2 and _set_anim(id, mpath(path), i1, i2) or _set_mesh(id, mpath(path), i1 or 0)
end

local _set_scale = pewpew.customizable_entity_set_mesh_xyz_scale
function entity_set_mesh_scale(id, x, y, z)
  return _set_scale(id, x, y or x, z or y and 1fx or x)
end

local _conf = pewpew.configure_player
function configure_player(param)
  return _conf(0, param)
end

function set_is_lost(v)
  return _conf(0, {has_lost = v})
end

function set_shield(v)
  return _conf(0, {shield = v})
end

function set_joystick_color(c1, c2)
  return _conf(0, {move_joystick_color = c1, shoot_joystick_color = c2})
end

function set_camera_pos(x, y, z)
  return _conf(0, {camera_x_override = x, camera_y_override = y, camera_distance = z and z - 1000fx or 0fx})
end

function set_camera_z(z)
  return _conf(0, {camera_distance = z - 1000fx})
end

function set_camera_angle(x)
  return _conf(0, {camera_rotation_x_axis = x})
end

local _gconf = pewpew.get_player_configuration
function get_is_lost()
  return _gconf(0).has_lost
end

function get_shield()
  return _gconf(0).shield
end

local _set_size = pewpew.set_level_size
function set_level_size(x, y)
  return _set_size(x, y or x)
end

local _inc_streak = pewpew.increase_score_streak_of_player
function increase_score_streak(v)
  return _inc_streak(0, v)
end

local _get_streak = pewpew.get_score_streak_level
function get_score_streak_level()
  return _get_streak(0)
end

local _wconf = pewpew.configure_player_ship_weapon
function set_player_ship_weapon(id, frequency, cannon, duration)
  return _wconf(id, {frequency = frequency or 0, cannon = cannon or 0, duration = duration})
end

local _new_asteroid = pewpew.new_asteroid
local _new_asteroidS = pewpew.new_asteroid_with_size
function new_asteroid(x, y, size)
  return size and _new_asteroidS(x, y, size) or _new_asteroid(x, y)
end

local _new_baf = pewpew.new_baf
function new_baf(x, y, angle, speed, lifetime)
  return _new_baf(x, y, angle, speed, lifetime or -1)
end

local _new_bafR = pewpew.new_baf_red
function new_baf_red(x, y, angle, speed, lifetime)
  return _new_baf(x, y, angle, speed, lifetime or -1)
end

local _new_bafB = pewpew.new_baf_blue
function new_baf_blue(x, y, angle, speed, lifetime)
  return _new_baf(x, y, angle, speed, lifetime or -1)
end

function new_bonus_shield(x, y, shield, box_duration, callback)
  return new_bonus(x, y, bonus_type.shield, {number_of_shields = shield, box_duration = box_duration, taken_callback = callback})
end

function new_bonus_weapon(x, y, cannon, frequency, weapon_duration, box_duration, callback)
  return new_bonus(x, y, bonus_type.shield, {cannon = cannon, frequency = frequency, weapon_duration = weapon_duration, box_duration = box_duration, taken_callback = callback})
end

function new_bonus_speed(x, y, speed_factor, speed_offset, speed_duration, box_duration, callback)
  return new_bonus(x, y, bonus_type.shield, {speed_factor = speed_factor, speed_offset = speed_offset, speed_duration = speed_duration, box_duration = box_duration, taken_callback = callback})
end

local _new_message = pewpew.new_floating_message
function new_message(x, y, str, scale, duration, is_optional)
  return _new_message(x, y, str, {scale = scale, ticks_before_fade = duration, is_optional = is_optional})
end

local _new_ship = pewpew.new_player_ship
function new_player_ship(x, y)
  return _new_ship(x, y, 0)
end

local _new_bullet = pewpew.new_player_bullet
function new_player_bullet(x, y, angle)
  return _new_bullet(x, y, angle, 0)
end

local _rolling_cube_meh = pewpew.rolling_cube_set_enable_collisions_with_walls
function rolling_cube_set_wall_collision(id, v)
  return _rolling_cube_meh(id, v or true)
end

local _ufo_meh = pewpew.ufo_set_enable_collisions_with_walls
function ufo_set_wall_collision(id, v)
  return _ufo_meh(id, v or true)
end

local _entity_wreact = pewpew.entity_react_to_weapon
function entity_react_to_weapon(id, weapon_type, x, y)
  return _entity_wreact(id, {type = weapon_type, x = x, y = y, player_index = 0})
end

pewpew = nil