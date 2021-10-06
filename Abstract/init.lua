ClassType = require('ClassType.init')

local AbstractClass = {
  _type = ClassType.ABSTRACT
}

function AbstractClass.new()
  print("ok")
end
return AbstractClass
