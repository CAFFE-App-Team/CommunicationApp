local widget = require( "widget" )
local usageData = require ("usageData")
local composer = require( "composer" )
local loadsave = require( "loadsave" ) 
local gameData = require( "gameData" )
local barScene = require "barScene"
local App42API = require("App42-Lua-API.App42API") 
local JSON = require("App42-Lua-API.JSON")
local coronaJson = require( "json" )
local lfs = require "lfs"
local mime=require("mime")
 
-- The "onRowRender" function may go here (see example under "Inserting Rows", above)
 local scene = composer.newScene()

 function scene:create( event )

        local sceneGroup = self.view

barScrollView.alpha=0
readBtn.alpha=0
deleteBtn.alpha=0
topSquare.alpha=0

--[[local function sendData()


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
    print("FIRST TIME SETUP")
    print("dbName is "..object:getDbName())
    print("collectionName is "..object:getCollectionName())
    print("DocId is "..object:getJsonDocList():getDocId())
    print("Created At is "..object:getJsonDocList():getCreatedAt())
    print("Updated At is "..object:getJsonDocList():getUpdatedAt())
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
    print("dbName is "..object:getDbName())
        for i=1,table.getn(object:getJsonDocList()) do
            print("DocId is "..object:getJsonDocList()[i]:getDocId())
            print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
        end
end
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())

    setUpTable();

end



end

end--]]


 local function onRowRender( event )
 
    -- Get reference to the row group
    local row = event.row
 
    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth

print (row.index);

--if (row.index < #usageData.sampleData) then 
    local rowTitle = display.newText( row, usageData.sampleData[row.index].text.."   "..usageData.sampleData[row.index].count  , 0, 0, nil, 14 )
   
    rowTitle:setFillColor( 0 )
 
    -- Align the label left and vertically centered
    rowTitle.anchorX = 0
    rowTitle.x = 10
    rowTitle.y = rowHeight * 0.5
--end
end


-- Create the widget
local tableView = widget.newTableView(
    {
        left = 0,
        top = 0,
         width = display.contentWidth,
    height = display.contentHeight,
    bottomPadding = 50,
    topPadding = 50,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        listener = scrollListener,
        isBounceEnabled = true
    }
)

tableView:setIsLocked(false)
 
-- Insert 40 rows
for i = 1, #usageData.sampleData do
 
    local isCategory = false
    local rowHeight = 36
    local rowColor = { default={1,1,1}, over={1,0.5,0,0.2} }
    local lineColor = { 0.5, 0.5, 0.5 }
 
--[[    -- Make some rows categories
    if ( i == 1 or i == 21 ) then
        isCategory = false
        rowHeight = 40
        rowColor = { default={0.8,0.8,0.8,0.8} }
        lineColor = { 1, 0, 0 }
    end--]]
 
    -- Insert a row into the tableView
    tableView:insertRow(
        {
            --isCategory = isCategory,
            rowHeight = rowHeight,
            rowColor = rowColor,
            lineColor = lineColor
        }
    )

end

sceneGroup:insert(tableView)

local function  enterNameBox( event )

  if ( event.phase == "began" ) then

    local defaultField
 
local function textListener( event )
 
    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"
 
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        print( event.target.text )
 
    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end


local function submitValue( event )

    if ( event.phase == "began" ) then

       gameData.studentName = defaultField.text
       loadsave.saveTable (gameData.studentName, "studentName.json" )
       usageData.sampleData[1].text=gameData.studentName
       loadsave.saveTable (usageData.sampleData, "sampleData.json" )

       --print ("stud name "..usageData.sampleData[1].text)

    end

end 
 
-- Create text field
local myRectangle = display.newRect( 230, 120, 200, 50 )
myRectangle.strokeWidth = 3
myRectangle:setFillColor( 0.5 )
myRectangle:setStrokeColor( 1, 0, 0 )

local doneBtn = display.newImageRect("okTextBtn.png", 30*2.58,30)
doneBtn.x = 395
doneBtn.y = 120
doneBtn.id="done"
doneBtn:addEventListener( "touch", submitValue )

defaultField = native.newTextField( 233, 123, 180, 30 )
defaultField.text=gameData.studentName
defaultField:addEventListener( "userInput", textListener )

sceneGroup:insert(myRectangle)
sceneGroup:insert(defaultField)
sceneGroup:insert(doneBtn)

end

return true
end


local function restoreData(event)

    if ( event.phase == "began" ) then

print ('restoreData')

        local uploadWait  = display.newImageRect("uploadingWait.png", 200, 101)
uploadWait.x = display.contentCenterX
uploadWait.y = display.contentCenterY
sceneGroup:insert (uploadWait)

local temp_path = system.pathForFile( "", system.DocumentsDirectory )
 
-- Change current working directory
local success = lfs.chdir( temp_path )  -- Returns true on success
local new_folder_path
 
if success then

    local existsSound = lfs.chdir( temp_path.."/sounds" )
    if existsSound then
        print ("sounds exists already")
    else
    lfs.mkdir( "sounds" )
    new_folder_path = lfs.currentdir() .. "/sounds"
    end

    local existsImages = lfs.chdir( temp_path.."/images" )
    if existsImages then
        print ("it exists already")
    else
    lfs.mkdir( "images" )
    new_folder_path = lfs.currentdir() .. "/images"
end

end






  local function beginFileDownload(myUrl, myFile,fileType)

    local function networkListener( event )
    if ( event.isError ) then
        print( "Network error - download failed: ", event.response )
    elseif ( event.phase == "began" ) then
        print( "Progress Phase: began" )
    elseif ( event.phase == "ended" ) then
        print( "Displaying response image file" )
--[[        myImage = display.newImage( event.response.filename, event.response.baseDirectory, 60, 40 )
        myImage.alpha = 0
        transition.to( myImage, { alpha=1.0 } )--]]
    end
end

local decodedName = myFile

    if (fileType=="sounds") then
    

    print ('myFile as got '..myFile)

    local fixedName = myFile:gsub('@','/')

     print ('dencoded '..fixedName)

     local fixedName2 = fixedName:gsub('&','=')

     print ('dencoded '..fixedName2)

      decodedName = mime.unb64(fixedName2)
end

 
local params = {}
params.progress = true
 
network.download(
    myUrl,
    "GET",
    networkListener,
    params,
    fileType.."/"..decodedName,
    system.DocumentsDirectory
)

  end  

local function fileDowloads()

local userName = gameData.studentName;
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local uploadService  = App42API:buildUploadService()
uploadService:getAllFilesByUser(userName,App42CallBack)
function App42CallBack:onSuccess(object)  
  if table.getn(object:getFileList()) >1 then   
  for m=1,table.getn(object:getFileList()) do  
 
    if (object:getFileList()[m]:getType()=="UploadFileType.AUDIO") then
      local myType = "sounds"
      beginFileDownload (object:getFileList()[m]:getUrl(), object:getFileList()[m]:getName(), myType )

      elseif (object:getFileList()[m]:getType() == "UploadFileType.IMAGE") then
              local myType = "images"
      beginFileDownload (object:getFileList()[m]:getUrl(), object:getFileList()[m]:getName(), myType )

      end

    print("fileName is :".. object:getFileList()[m]:getName()); 
    print("Username is :".. object:getFileList()[m]:getUserName()); 
    print("Type is :".. object:getFileList()[m]:getType());     
    print("Url is :".. object:getFileList()[m]:getUrl());  
    print("Description is: ".. object:getFileList()[m]:getDescription()); 

    uploadWait:removeSelf()

  end
  else     
    print("fileName is :".. object:getFileList():getName());
    print("Username is :".. object:getFileList():getUserName());  
    print("Type is :".. object:getFileList():getType());     
    print("Url is :".. object:getFileList():getUrl());  
    print("fileDescription is: ".. object:getFileList():getDescription());  
  end
end  
function App42CallBack:onException(exception)
  print("Message is : "..exception:getMessage())
  print("App Error code is : "..exception:getAppErrorCode())
  print("Http Error code is "..exception:getHttpErrorCode())
  print("Detail is : "..exception:getDetails())
end

end


 print ('getting data')

          local dbName  = "WORDFREQUENCY"
            local collectionName = "wordStats"
            local key = "studentName"
            local value = gameData.studentName
            local App42CallBack = {}
            App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
            local storageService = App42API:buildStorageService()
            storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
            function App42CallBack:onSuccess(object)
                print("dbName is "..object:getDbName())
                for i=1,table.getn(object:getJsonDocList()) do
                    print("DocId is "..object:getJsonDocList()[i]:getDocId())
                    gameData.cardDocID = object:getJsonDocList()[i]:getDocId()

                    print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
                end

                print ('download card data ')
              
                 jsonCardData = JSON:encode(object:getJsonDocList()[1]:getJsonDoc())  
                 
                 cardData = coronaJson.decode(jsonCardData)

                  for top=1, #cardData.topics do

                 local jCopy = coronaJson.encode(cardData.topics[top])

                  gameData.topics[top] = coronaJson.decode(jCopy)

                end

                gameData.mainMenuItems = {}

                    for i = 1, #gameData.topics do

                    table.insert( gameData.mainMenuItems, gameData.topics[i][1].text   )
                    table.remove( gameData.topics[i], 1)

                    end

                    loadsave.saveTable (gameData.studentName, "studentName.json" )
                    loadsave.saveTable (cardData.topics, "cardDataTopics.json" )

                fileDowloads()
            end
            function App42CallBack:onException(exception)
                print("Message is : "..exception:getMessage())
                print("App Error code is : "..exception:getAppErrorCode())
                print("Http Error code is "..exception:getHttpErrorCode())
                print("Detail is : "..exception:getDetails())
      
            end



    end
    
    return true    


end    




local dataBtn = display.newImageRect( "restoreAllBtn.png", 70,35)
dataBtn.x=150
dataBtn.y=270
dataBtn.alpha=1

sceneGroup:insert(dataBtn)

dataBtn:addEventListener( "touch", restoreData )

--end


 local function loadDataScreen( event )

    if ( event.phase == "began" ) then

    local options =
    {
    effect = "crossFade",
    time = 400

    }
    composer.gotoScene( "mainMenu", options ) 


  end
    return true
 end 


local dataBtn = display.newImageRect( "backBtnPopUp.png", 30,30)
dataBtn.x=30
dataBtn.y=270

sceneGroup:insert(dataBtn)

dataBtn:addEventListener( "touch", loadDataScreen )


local t = os.date( '*t' )

local timeRun =  os.time( t ) - gameData.startTime

print ('time passed '..timeRun)

local function reUploadMissed(event)

if ( event.phase == "began" ) then

local uploadWait  = display.newImageRect("uploadingWait.png", 200, 101)
uploadWait.x = display.contentCenterX
uploadWait.y = display.contentCenterY
sceneGroup:insert (uploadWait)

local doc_path = system.pathForFile( "", system.DocumentsDirectory )
local allImages = {}
local allSounds = {}
 
--local skip=1 
for file in lfs.dir( doc_path.."/images" ) do
    -- File is the current file or directory name
  
local extension = file:sub(-4,-1)

    if (extension==".jpg") then
        local fileName = file:sub(1, -5)
        table.insert(allImages, file)
      
    end

end

for file in lfs.dir( doc_path.."/sounds" ) do
    -- File is the current file or directory name

local extension = file:sub(-4,-1)

    if (extension==".wav") then
      
        table.insert(allSounds, file)
     
    end

end


  

for f=1, #allImages do

  local myPath = system.pathForFile( "images/"..allImages[f], system.DocumentsDirectory )

local fileName = allImages[f]
local userName = gameData.studentName
local description = "File Description";    
local filePath = myPath;
local fileType = "UploadFileType.IMAGE"; 
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local uploadService  = App42API:buildUploadService()
uploadService:uploadFileForUser(fileName,userName,filePath ,fileType,description,App42CallBack)   
--uploadService:uploadFile(fileName,filePath ,fileType,description,App42CallBack)
function App42CallBack:onSuccess(object)   
    print("fileName is :".. object:getFileList():getName()); 
    print("Type is :".. object:getFileList():getType());     
    print("Url is :".. object:getFileList():getUrl());  
    print("fileDescription is: ".. object:getFileList():getDescription());         
end  
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())
end

end


for f=1, #allSounds do

  local myPath = system.pathForFile( "sounds/"..allSounds[f], system.DocumentsDirectory )
    print ('name is '..myPath)

local fileName = allSounds[f]
local userName = gameData.studentName
local description = "File Description";    
local filePath = myPath;
local fileType = "UploadFileType.AUDIO"; 
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local uploadService  = App42API:buildUploadService()
uploadService:uploadFileForUser(fileName,userName,filePath ,fileType,description,App42CallBack)   
--uploadService:uploadFile(fileName,filePath ,fileType,description,App42CallBack)
function App42CallBack:onSuccess(object)   
    print("fileName is :".. object:getFileList():getName()); 
    print("Type is :".. object:getFileList():getType());     
    print("Url is :".. object:getFileList():getUrl());  
    print("fileDescription is: ".. object:getFileList():getDescription());         
end  
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())
end

end


local dbName  = "WORDFREQUENCY"
local collectionName = "wordStats"
local key = "studentName"
local value = gameData.studentName
print ("value is "..gameData.studentName)
local jsonTable = {}
jsonTable = JSON:encode(cardData)
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local storageService = App42API:buildStorageService()
storageService:updateDocumentByKeyValue(dbName,collectionName,key,value,jsonTable,App42CallBack)
function App42CallBack:onSuccess(object)
    print ("UPDATED")
    uploadWait:removeSelf()
end
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())


end



end

return true

end 

local reuploadBtn = display.newImageRect( "uploadAllBtn.png", 88,30)
reuploadBtn.x=300
reuploadBtn.y=270
reuploadBtn.alpha=1

sceneGroup:insert(reuploadBtn)

reuploadBtn:addEventListener( "touch", reUploadMissed )


end -- of create

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

         composer.removeScene( "mainMenu")

 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene