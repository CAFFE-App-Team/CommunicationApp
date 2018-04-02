local BravoBoard = {}
local userId= nil
local itemId= nil
local status= nil
local comment= nil
local activityId= nil
local createdOn= nil
local tags = require("App42-Lua-API.Tags")  
local json = nil
local totalRecords
local success = false
function BravoBoard:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function BravoBoard:getUserId() 
		return self.userId;
end
  
function BravoBoard:setUserId(_userId)
		self.userId = _userId;
end

function BravoBoard:getItemId() 
		return self.itemId;
end

function BravoBoard:setItemId(_itemId)
		self.itemId = _itemId;
end

function BravoBoard:getStatus() 
		return self.status;
end

function BravoBoard:setStatus(_status) 
		self.status = _status;
end


function BravoBoard:getComment() 
		return self.comment;
end


function BravoBoard:setComment(_comment) 
		self.comment = _comment;
end



function BravoBoard:getCreatedOn() 
		return self.createdOn;
end

function BravoBoard:setCreatedOn(_createdOn)
		self.createdOn = _createdOn;
end

function BravoBoard:setActivityId(_activityId) 
		self.activityId = _activityId;
end

function BravoBoard:getActivityId() 
		return self.activityId;
end

function BravoBoard:getTagList() 
  return self.tags;
end
function BravoBoard:setTagList(_tagList) 
		self.tags = _tagList;
end

function BravoBoard:getStrResponse()
    return self.json
end
function BravoBoard:setStrResponse(_json)
    self.json = _json  
end
function BravoBoard:setResponseSuccess(_success)
    self.success = _success  
end
function BravoBoard:getResponseSuccess()
    return self.success  
end
function BravoBoard:getTotalRecords()
    return self.totalRecords
end
function BravoBoard:setTotalRecords(_totalRecords)
    self.totalRecords = _totalRecords  
end

	function BravoBoard:getStringView() 
		return "UserId :".. self.userId .. " : ItemId : " .. self.itemId .. " : Comment : " .. self.comment ..  " : CreatedOn : " .. self.createdOn .. " : activityId : "
				.. self.activityId;
end
return BravoBoard