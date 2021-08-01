-- Class = dofile("C:\\Users\\Wesley\\Documents\\Studies\\TwodyObject\\init.lua")
Class = dofile("init.lua")

newClass = Class:define({
  a = 30
})

newObject = Object:new(newClass)

newObject:setA(90)

for k,v in pairs(newObject) do print(k,v) end

function exit()
  os.exit()
end

exit()
