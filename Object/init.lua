ClassType = require('ClassType.init')
Utils = require('Utils.init')

local Object = {
  _type = ClassType.OBJECT
}

function Object:new(class)
  if string.lower(class._type) == 'class' then
    local o = {}
    Utils:clone(o, class)
    setmetatable(o, {
      __index = Object,
      __newindex = function(t, k, v)
        if (t._type == 'object') then
          local getName = Utils:getGetName(k)
          local setName = Utils:getSetName(k)
          if type(t[setName]) == 'function' then
            print('Assigning ', k, v, getName, setName)
            t[setName](t, v)
          else
            error(string.format('Unknown property `%s`', k))
          end
        end
      end
    })
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

return Object
