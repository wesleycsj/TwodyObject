--[[

MIT License
Copyright (c) 2021 WesleyCSJ

--]]
ClassType = require('ClassType.init').CLASS
Utils = require('Utils.init')

local Class = {
  _type = ClassType
}

function Class:create(attributes)
  local o = attributes
  local properties = {}
  -- Sets Class type
  --o._type = ClassType.CLASS
  -- Create underlined and capitalized properties
  for k,v in pairs(o) do
    table.insert(properties, {
      name = Utils:getPropertyName(k),
      value = v,
      setName = Utils:getSetName(k),
      getName = Utils:getGetName(k)
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
      error('Classes attributes should be defined using Class:create() function.')
    end
  })

  return o
end

return Class
