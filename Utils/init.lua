local Utils = {}

-- Should be called like clone(tableDestiny, TableToBeCloned)
-- index argument should be not intentionally provided to be interpreted as nil
-- It makes the usage easier and avoids an additional unwanted index as root of the result
-- Well, td and to are not tables all the time, in some moment they turn into normal values(like number, string..etc)
-- Maybe renaming this should be better, but not now since it's 3AM o'clock.
function Utils:clone(td, to, index)
  if type(to) == 'table' then
    -- When index is nil(only in the first execution) td table itself is passed as table(root) to receive the values,
    -- when its not, a new table is created, added to td table and passed as table to receive the values
    -- It avoids {{myAttribute = 'value'}} instead {myAttribute = 'value'} as result
    -- t is only an alias to be passed to clone function, avoids an additional if-else between `td[index]` and `td`
    local t = td
    if index ~= nil then
      --td[index] = {}
      rawset(td, index, {})
      t = td[index]
    end
    -- Copy every element in the table origin
    for k,v in pairs(to) do
      -- Clone the to T table
      self:clone(t, v, k)
      -- Sets metatable when it exists
      if getmetatable(to) ~= nil then setmetatable(td, getmetatable(to)) end
    end
  else
    -- Sets the value or reference when is not table
    --td[index] = to
    rawset(td, index, to)
  end
end

function Utils:getGetName(k)
  local kLen = string.len(k)
  if kLen == 1 then
    return 'get' .. string.upper(k)
  elseif kLen > 1 then
    return 'get' .. string.upper(string.sub(k, 1, 1)) .. string.sub(k, 2, kLen)
  end
end

function Utils:getSetName(k)
  local kLen = string.len(k)
  if kLen == 1 then
    return 'set' .. string.upper(k)
  elseif kLen > 1 then
    return 'set' .. string.upper(string.sub(k, 1, 1)) .. string.sub(k, 2, kLen)
  end
end

function Utils:getPropertyName(k)
  local kLen = string.len(k)
  if kLen == 1 then
    return '_' .. string.upper(k)
  elseif kLen > 1 then
    --return '_' .. string.upper(string.sub(k, 1, 1)) .. string.sub(k, 2, kLen)
    return '_' .. string.upper(k)
  end
end

-- TO REMOVE
tab = ''
function printTable(v, k)
  if type(v) == 'table' then
    if k == nil then
      print(tab .. '{')
    else
      print(tab .. k .. '= {')
    end
    tab = tab .. ' '
    for tk,tv in pairs(v) do
      printTable(tv, tk)
    end
    tab = string.sub(tab, 1, string.len(tab) - 1)
    print(tab .. '}')
  else
    tab = tab .. ' '
    print(tab .. k .. '=' .. getValue(v) .. ',')
    tab = string.sub(tab, 1, string.len(tab) - 1)
  end
end


-- TO REMOVED
function getValue(v)
  local type = type(v)
  if type == 'table' then
    return  'table'
  elseif type == 'function' then
    return 'function'
  elseif type == 'number' or type == 'string' then
    return v
  elseif type == 'boolean' then
    if v then
      return 'True'
    else
      return 'False'
    end
  end
end

return Utils
