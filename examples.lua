
-- Update callbacks

--[[
  
  There are 3 types of update callbacks:
    usual - added by add_update_callback()
    post - added by add_post_update_callback()
    temporary - added by add_tmp_update_callback()
  
  They're stored in their respective lists in order you've added them.
  
  First usual update callbacks are called from first to last, then post update callbacks are called from last to first, then temporary update callbacks are called from last to first. In addition to that temporary update callbacks are removed from their list, after they were called.
  
  This diversity allows you to properly set what you want to be executed at which point.
  
  Temporary update callbacks are mainly used for specific cases, such as certain pewpew functions working only after level was initialized, including playing sounds and loading meshes. Still, that type of update callbacks can be used if you want some code to be executed before next tick starts, after all the callbacks of current tick.
  
]]

local function tick1() end
local function tick2() end
local function tick3() end
local function tick4() end
local function tick5() end

add_update_callback(tick1)
-- update callbacks are called in order: tick1

add_post_update_callback(tick2)
-- update callbacks are called in order: tick1   tick2

add_update_callback(tick3)
-- update callbacks are called in order: tick1 tick3   tick2

add_tmp_update_callback(tick4)
-- update callbacks are called in order: tick1 tick3   tick2   tick4
-- after first tick, update callbacks are called in order: tick1 tick3   tick2

add_post_update_callback(tick5)
-- update callbacks are called in order: tick1 tick3   tick5 tick2   tick4
-- after first tick, update callbacks are called in order: tick1 tick3   tick5 tick2


-- Player ship weapons

set_player_ship_weapon(ship_id, cannon_frequency[30], cannon_type.double) -- sets cannon of specified ship to one of the defaults forever
set_player_ship_weapon(ship_id, cannon_frequency[7.5], cannon_type.tic_toc, 120) -- sets cannon of specified ship to one of the powerups for 4 seconds
set_player_ship_weapon(ship_id, cannon_frequency[7.5], cannon_type.tic_toc) -- sets cannon of specified ship to one of the powerups forever, but player's bullets will be used instead
