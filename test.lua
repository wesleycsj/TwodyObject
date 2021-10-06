-- Class = dofile("C:\\Users\\Wesley\\Documents\\Studies\\TwodyObject\\init.lua")
Class = require("init").Class
Object = require("init").Object
Utils = require("Utils.init")
--
-- newClass = Class:create({
--   a = 30,
--   number = 0
-- })
--
--
-- newObject = Object:new(newClass)
--
-- newObject:setA(90)
-- newObject:setA(390)
--
-- --for k,v in pairs(newClass) do print(k,v) end
-- print('Class type',newClass._type)

a = {}
b = Class:create({
  a = 30,
  b = 25,
  c = {
    a = 20,
    b = 35,
    d = {
      'a', 'b', 'c', 'd'
    }
  }
})
--c = Object:new(b)
c = {}
Utils:clone(c, b)
d = {}

-- clone(a, b)
-- clone(d, c)

-- print(a._B)
-- d.C = {30,30}
-- printTable(d)
print('B CLASS TYPE:', b._type)
print('c OBJECT TYPE', c._type)
print('b type', b._type, c._type)

function exit()
  os.exit()
end

exit()
