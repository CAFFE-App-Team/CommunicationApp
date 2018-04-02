--author Himanshu Sharma
local Profile ={}
local firstName= ""
local lastName= ""
local sex= ""
local mobile = ""
local line1= ""
local line2= ""
local city= ""
local state= ""
local country= ""
local pincode= ""
local homeLandLine= ""
local officeLandLine= ""
local dateOfBirth = ""

function Profile:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Profile:getFirstName()
    return self.firstName
end
function Profile:setFirstName(_firstName)
    self.firstName = _firstName  
end
function Profile:getLastName()
    return self.lastName
end
function Profile:setLastName(_lastName)
    self.lastName = _lastName  
end
function Profile:getCity()
    return self.city
end
function Profile:setCity(_city)
    self.city = _city  
end
function Profile:getState()
    return self.state
end
function Profile:setState(_state)
    self.state = _state  
end
function Profile:getCountry()
    return self.country
end
function Profile:setCountry(_country)
    self.country = _country  
end
function Profile:getPincode()
    return self.pincode
end
function Profile:setPincode(_pincode)
    self.pincode = _pincode  
end
function Profile:getLine1()
    return self.line1
end
function Profile:setLine1(_line1)
    self.line1 = _line1  
end
function Profile:getLine2()
    return self.line2
end
function Profile:setLine2(_line2)
    self.line2 = _line2  
end
function Profile:getOfficeLandLine()
    return self.officeLandLine
end
function Profile:setOfficeLandLine(_officeLandLine)
    self.officeLandLine = _officeLandLine  
end
function Profile:getHomeLandLine()
    return self.homeLandLine
end
function Profile:setHomeLandLine(_homeLandLine)
    self.homeLandLine = _homeLandLine  
end
function Profile:getDateOfBirth()
    return self.dateOfBirth
end
function Profile:setDateOfBirth(_dateOfBirth)
    self.dateOfBirth = _dateOfBirth  
end
function Profile:getSex()
    return self.sex
end
function Profile:setSex(_sex)
    self.sex = _sex  
end
function Profile:getMobile()
    return self.mobile
end
function Profile:setMobile(_mobile)
    self.mobile = _mobile  
end
return Profile