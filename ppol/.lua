emoji_error    = '\u{1f6d1}'
emoji_warning  = '\u{26a0}'
emoji_nice     = '\u{2705}'

fmath_old = nil
pewpewinternal = nil

local _sf = string.format
function mpath(path)
  return _sf('%s%s%s', '/dynamic/', path ,'.lua')
end

local _require = require
function require(path)
  return _require(mpath(path))
end

function ppo_require(...)
  for _, path in ipairs{...} do
    require(_sf('%s%s', 'ppol/', path))
  end
end


if not PPO_NDEBUG then
  ppo_require('debug', 'tests')
end

ppo_require('base', 'fmath', 'pewpew')