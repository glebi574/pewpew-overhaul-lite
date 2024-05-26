emoji_error    = '\u{1f6d1}'
emoji_warning  = '\u{26a0}'
emoji_nice     = '\u{2705}'

function mpath(path)
  return string.format('%s%s%s', '/dynamic/', path ,'.lua')
end

local _r = require
function require(path)
  return _r(mpath(path))
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

if not PPO_NDEBUG then
  ppo_require('debug')
end

if math then
  add_memory_print, add_memory_warning = nil, nil
  ppo_require('base', 'fmath', 'mesh')
else
  ppo_require('base', 'fmath', 'pewpew')
end

rmn('pewpew', 'fmath', 'fmath_old', 'pewpewinternal')

rm, rmn = nil, nil