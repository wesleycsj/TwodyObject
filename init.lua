--[[

MIT License
Copyright (c) 2021 WesleyCSJ

--]]
Class = {
  _type = 'class'
}

function getGetName(k)
  local kLen = string.len(k)
  if kLen == 1 then
    return 'get' .. string.upper(k)
  elseif kLen > 1 then
    return 'get' .. string.upper(string.sub(k, 1, 1)) .. string.sub(k, 2, kLen)
  end
end

function getSetName(k)
  local kLen = string.len(k)
  if kLen == 1 then
    return 'set' .. string.upper(k)
  elseif kLen > 1 then
    return 'set' .. string.upper(string.sub(k, 1, 1)) .. string.sub(k, 2, kLen)
  end
end

function getPropertyName(k)
  local kLen = string.len(k)
  if kLen == 1 then
    return '_' .. string.upper(k)
  elseif kLen > 1 then
    return '_' .. string.upper(string.sub(k, 1, 1)) .. string.sub(k, 2, kLen)
  end
end

function Class:define(attributes)
  local o = attributes
  local properties = {}

  -- Create underlined and capitalized properties
  for k,v in pairs(o) do
    table.insert(properties, {
      name = getPropertyName(k),
      value = v,
      setName = getSetName(k),
      getName = getGetName(k)
    })
    o[k] = nil
  end

  -- Create getters and setters
  for k, v in pairs(properties) do
    o[v.name] = v.value
    o[v.setName] = function (self, value)
      if (type(self[v.name]) == type(value)) then
        self[v.name] = value
        return self[v.name]
      else
        error(string.format('%s() function has to get a `%s` instead `%s` value', v.setName, type(self[v.name]), type(value)))
      end
    end
    o[v.getName] = function ()
      return o[v.name]
    end
  end

  -- A class 'new' function creates a object and inherits from Object table
  setmetatable(o, {
    __index = Class,
    __newindex = function (t, k, v)
      local setName = getSetName(k)
      if string.lower(self._type) == 'object' then
        if (type(t[setName]) == 'function') then
          return t[setName](v)
        end
      end
      return nil
    end
  })

  return o
end

Object = {
  _type = 'object'
}

function Object:new(class)
  if string.lower(class._type) == 'class' then
    local o = class
    o._type = 'object'
    setmetatable(o, {_index = class})
    return o
  else
    error('Invalid class to create the object')
  end
end

function Object:typeof(typeName)
  assert((type(typeName) == 'string'), 'typeof() argument should be string')
  if string.lower(self._type) == string.lower(typeName) then return true end
  return false
end

return Class
