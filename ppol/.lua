emoji_error    = '\u{1f6d1}'
emoji_warning  = '\u{26a0}'
emoji_nice     = '\u{2705}'

PPOL_VERSION = '1.1.2'

function mpath(path)
  return string.format('%s%s%s', '/dynamic/', path ,'.lua')
end

local __require = require
function require(path)
  return __require(mpath(path))
end

function ppo_require(...)
  for _, path in ipairs{...} do
    require(string.format('%s%s', 'ppol/', path))
  end
end

function rm(a)
  for k, v in pairs(a) do
    if type(v) == 'table' then
      rm(v)
    end
    a[k] = nil
  end
end

function rmn(...)
  for _, name in ipairs{...} do
    local a = _ENV[name]
    if a then
      rm(a)
      _ENV[name] = nil
    end
  end
end

if not math then
  ppo_require('base', 'fmath', 'pewpew', 'camera')
elseif PPO_SOUND then
  ppo_require('base', 'sound')
else
  ppo_require('base', 'fmath', 'mesh')
end

if not PPO_NDEBUG then
  ppo_require('debug')
end

rmn('pewpew', 'fmath', 'fmath_old', 'pewpewinternal')

rm, rmn = nil, nil