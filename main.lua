local composer = require( "composer" )
local App42API = require("App42-Lua-API.App42API") 
local usageData = require ("usageData")
local loadsave = require( "loadsave" ) 
local gameData = require( "gameData" )
local timeData = require( "timeData" )
local cardData = require ("cardData")
local studentUsers = require( "studentUsers" )

local JSON = require("App42-Lua-API.JSON")
local coronaJson = require( "json" )


display.setDefault( "background", 69/255, 39/255, 160/255 )

--[[gameData.studentName="kobir"
cardData.studentName="kobir"

local jCopy = coronaJson.encode(cardData.topics)

gameData.topics = coronaJson.decode(jCopy)


for i = 1, #gameData.topics do

table.insert( gameData.mainMenuItems, gameData.topics[i][1].text   )
table.remove( gameData.topics[i], 1)

end


composer.gotoScene("mainMenu")--]]


function sendData()

--loadsave.saveTable (usageData.timeData, "timeData.json" )

local function setUpTable() 

local dbName  = "WORDFREQUENCY"
local collectionName = "wordStats"
local jsonTable = {}
jsonTable = JSON:encode(usageData)
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local storageService = App42API:buildStorageService()
storageService:insertJSONDocument(dbName, collectionName, jsonTable ,App42CallBack)
function App42CallBack:onSuccess(object)
	
end
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())
end


end    

if (gameData.studentName~="none") then


local dbName  = "WORDFREQUENCY"
local collectionName = "wordStats"
local key = "sampleData.text"
local value = gameData.studentName
print ("value is "..gameData.studentName)
local jsonTable = {}
jsonTable = JSON:encode(usageData)
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local storageService = App42API:buildStorageService()
storageService:updateDocumentByKeyValue(dbName,collectionName,key,value,jsonTable,App42CallBack)
function App42CallBack:onSuccess(object)
    print ("UPDATED")

			

end
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())

    setUpTable();

end



end

end


local function onSystemEvent( event )
    
    if (event.type == "applicationStart") then

       if (loadsave.loadTable( "studentName.json") ~= nil) then
            gameData.studentName = loadsave.loadTable( "studentName.json")
            cardData.topics = loadsave.loadTable( "cardDataTopics.json")
            studentUsers.names = loadsave.loadTable ("userNames.json")
        if (loadsave.loadTable( "sampleData.json" ) ~= nil) then
      usageData.sampleData = loadsave.loadTable( "sampleData.json")
  else
    usageData.sampleData[1].text=gameData.studentName
      end

    if (loadsave.loadTable( "sentenceData.json" ) ~= nil) then
      usageData.sentences = loadsave.loadTable( "sentenceData.json")
      end

    if (loadsave.loadTable( "timeData.json" ) ~= nil) then
      usageData.timeData = loadsave.loadTable( "timeData.json")
      end 

            local jCopy = coronaJson.encode(cardData.topics)

gameData.topics = coronaJson.decode(jCopy)


for i = 1, #gameData.topics do

table.insert( gameData.mainMenuItems, gameData.topics[i][1].text   )
                    table.insert (gameData.pictureScale, gameData.topics[i][1].ind)

             table.remove( gameData.topics[i], 1)

end
            sendData()
            composer.gotoScene("mainMenu")
        else

            if (#studentUsers.names<1) then

            local dbName  = "WORDFREQUENCY"
            local collectionName = "wordStats"
            local key = "names"
            local value = "users"
            local App42CallBack = {}
            App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
            local storageService = App42API:buildStorageService()
            storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
            function App42CallBack:onSuccess(object)
                print("dbName is "..object:getDbName())


                print ('download user data ')
              
                 jsonUserData = JSON:encode(object:getJsonDocList()[1]:getJsonDoc())  
                 
                 studentUsersTemp = coronaJson.decode(jsonUserData)


                table.remove( studentUsersTemp.names, 1)

                studentUsers.names = studentUsersTemp.names


                loadsave.saveTable (studentUsers.names, "userNames.json" )
                  composer.gotoScene("login")

            end
            function App42CallBack:onException(exception)
                print("Message is : "..exception:getMessage())
                print("App Error code is : "..exception:getAppErrorCode())
                print("Http Error code is "..exception:getHttpErrorCode())
                print("Detail is : "..exception:getDetails())
             
            end


        end




          

        end



    	  function round(number)
      				return number - (number % 1)
    		end

       local t = os.date( '*t' )
       gameData.startTime = os.time( t ) 

         print("Application started "..gameData.startTime)


         --download studentUsers

         



         --download cardData

--[[            local dbName  = "WORDFREQUENCY"
            local collectionName = "wordStats"
            local key = "studentName"
            local value = "kobir"
            local App42CallBack = {}
            App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
            local storageService = App42API:buildStorageService()
            storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
            function App42CallBack:onSuccess(object)
                print("dbName is "..object:getDbName())
                for i=1,table.getn(object:getJsonDocList()) do
                    print("DocId is "..object:getJsonDocList()[i]:getDocId())
                    print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
                end
                --gameData.cardData = object:getJsonDocList()[1]
                print ('download card data ')
                --local decodeTable = JSON:decode(object:getJsonDocList()[1]:getJsonDoc().topics)
                --print(object:getJsonDocList()[1]:getJsonDoc().topics[1].ind)
                -- print("jsonDoc is "..JSON:encode(object:getJsonDocList()[1]:getJsonDoc())); 
                 jsonCardData = JSON:encode(object:getJsonDocList()[1]:getJsonDoc())  
                 
                 cardData = coronaJson.decode(jsonCardData)

                  for top=1, #cardData.topics do

                 local jCopy = coronaJson.encode(cardData.topics[top])

                  gameData.topics[top] = coronaJson.decode(jCopy)

                end


                    for i = 1, #gameData.topics do

                    table.insert( gameData.mainMenuItems, gameData.topics[i][1].text   )
                    table.remove( gameData.topics[i], 1)

                    end

                 composer.gotoScene("mainMenu")
            end
            function App42CallBack:onException(exception)
                print("Message is : "..exception:getMessage())
                print("App Error code is : "..exception:getAppErrorCode())
                print("Http Error code is "..exception:getHttpErrorCode())
                print("Detail is : "..exception:getDetails())
            end--]]


    elseif (event.type == "applicationExit") then 
    
        print("Application exited")

       local t = os.date( '*t' )

		local seconds =  os.time( t ) - gameData.startTime

        local minutesLeft = seconds / 60
    	local myHours = round (minutesLeft / 60)
    	local myMinutes = round (minutesLeft - (myHours*60))
    	
    	--print ('hours '..hours)
    	--print ('minutes '..minutes) 

    	table.insert( usageData.timeData,  { date=os.date( "%c" ), hours=myHours, minutes=myMinutes }  )
        loadsave.saveTable (usageData.timeData, "timeData.json" )

    	print (usageData.timeData[2].date)
    	print (usageData.timeData[2].minutes)

        --sendData()
        
    elseif ( event.type == "applicationSuspend" ) then
        
        print("Application suspended") 

		local t = os.date( '*t' )

		local seconds =  os.time( t ) - gameData.startTime

        local minutesLeft = seconds / 60
    	local myHours = round (minutesLeft / 60)
    	local myMinutes = round (minutesLeft - (myHours*60))
    	
    	--print ('hours '..hours)
    	--print ('minutes '..minutes) 

    	table.insert( usageData.timeData,  { date=os.date( "%c" ), hours=myHours, minutes=myMinutes }  )
        loadsave.saveTable (usageData.timeData, "timeData.json" )
    	print (usageData.timeData[2].date)
    	print (usageData.timeData[2].minutes)

        --sendData()  
    
    elseif event.type == "applicationResume" then
        
               local t = os.date( '*t' )
        gameData.startTime = os.time( t ) 




           sendData()             

    end

end

--setup the system listener to catch applicationExit etc
Runtime:addEventListener( "system", onSystemEvent )



