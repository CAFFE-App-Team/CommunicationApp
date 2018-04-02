--author Himanshu Sharma
local FacebookProfile = {}
local name = nil
local picture = nil
local id= nil
local firstName= nil
local lastName= nil
local gender= nil
local link= nil
local locale= nil
local userName= nil
    
function FacebookProfile:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function FacebookProfile:getName()
    return name
end
function FacebookProfile:setName(_name)
    name = _name  
end
function FacebookProfile:getPicture()
    return picture
end
function FacebookProfile:setPicture(_picture)
    picture = _picture  
end
function FacebookProfile:getId()
    return id
end
function FacebookProfile:setId(_id)
    id = _id  
end

function FacebookProfile:getFirstName() 
        return firstName;
end
function FacebookProfile:setFirstName(_firstName) 
        firstName = _firstName;
end
function FacebookProfile:getLastName() 
        return lastName;
end
function FacebookProfile:setLastName(_lastName) 
       lastName = _lastName;
end
function FacebookProfile:getGender() 
        return gender;
end
function FacebookProfile:setGender(_gender) 
        gender = _gender;
end
    
function FacebookProfile:getLink()
        return link;
end
function FacebookProfile:setLink(_link) 
        link = _link;
end
function FacebookProfile:getLocale() 
        return locale;
end
function FacebookProfile:setLocale(_locale) 
        locale = _locale;
end
    
function FacebookProfile:getUserName() 
        return userName;
end
function FacebookProfile:setUserName(_userName)
        userName = _userName;
end
return FacebookProfile