local composer = require( "composer" )
local gameData = require( "gameData" )
local widget = require( "widget" )
local lfs = require "lfs"
local loadsave = require( "loadsave" ) 
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local myFiles = {}
 local imageBoxes={}
 local backBoxes={}
 local deleteBtn={}
 local labelBox
 local okBtn

 local startLabelText
 local parent

local imageCounter = 1

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    local phase = event.phase


 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 -- ScrollView listener

--create images folder if doesn'r exist

local temp_path = system.pathForFile( "", system.DocumentsDirectory )
 
-- Change current working directory
local success = lfs.chdir( temp_path )  -- Returns true on success
local new_folder_path
 
if success then

    local exists = lfs.chdir( temp_path.."/images" )
    if exists then
        print ("it exists already")
    else
    lfs.mkdir( "images" )
    new_folder_path = lfs.currentdir() .. "/images"
end
end


 startLabelText = gameData.workingScreen[gameData.indexEdit].text

 local imageGroup = display.newGroup()
local function scrollListener( event )
 
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end
 
    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end
 
    return true
end

 local bg = display.newImageRect ("whiteBG.png", 405, 255)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg)
 
-- Create the widget
local scrollView = widget.newScrollView(
    {
        top = 100,
        left = 10,
        width = 400,
        height = 250,
        backgroundColor = { 69/255, 39/255, 160/255 },
        scrollWidth = 600,
        scrollHeight = 300,
        listener = scrollListener
    }
)
 
scrollView.x = display.contentCenterX
scrollView.y = display.contentCenterY

-- Create a image and insert it into the scroll view
--[[local background = display.newImageRect( "fillBg.png", 400, 450 )
background.x = scrollView.x -50
background.y = scrollView.y -50
scrollView:insert(background)--]]



local function backToImages( event )
 
      if ( event.phase == "began" ) then

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

composer.showOverlay( "imagePicker", options )

    end

end
 

local function  setImage( event)

    if(event.phase == "began") then

     gameData.workingScreen[gameData.indexEdit].image=event.target.imageName

       print ("go")
    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

composer.showOverlay( "iconFill", options )

    end
return true
end


local function imageCount()

local imageSuffix


local imageCounter = #myFiles

local freeFound = false

local checkedNumber

for i=1, imageCounter do

    for j=1, imageCounter do

   

        print ("my file "..myFiles[j]:sub(1, -5))
        print ("my count "..tostring(i))

        freeFound=true

        checkedNumber=i

        if (myFiles[j]:sub(1,-5) == tostring(i)) then

            freeFound=false

            break
        
        end 
       

    end

            --print ("suff pre"..imageSuffix)

            print ("free found")
            print (freeFound)

            print ("checkedNumber "..checkedNumber)
            print ("myFiles counter "..myFiles[imageCounter]:sub(1,-5))

    if (freeFound) then

        imageSuffix = checkedNumber

        break

    elseif (checkedNumber== imageCounter) then

        imageSuffix = checkedNumber+1

    end    



    end    

          
   

return imageSuffix
end    

local function takePic( event )
      if(event.phase == "began") then

local function onPhotoComplete( event )
   if ( event.completed ) then


    table.insert( gameData.customImages, 1, imageCounter..".jpg" )
loadsave.saveTable (gameData.customImages, "customImageList.json" )

for i=1, #imageBoxes do

        imageBoxes[i]:removeSelf()
        imageBoxes[i] = nil

end   



displayMyImages()

   end
end



if (#myFiles>0) then

imageCounter = imageCount()

end

local hasAccessToCamera, hasCamera = media.hasSource( media.Camera )
 
if ( hasAccessToCamera == true ) then
    -- There is access to the camera
       media.capturePhoto( {
   listener = onPhotoComplete,
   destination = {
      baseDir = system.DocumentsDirectory,
      filename = "images/"..imageCounter..".jpg",
      type = "image"
   }
} )






elseif ( hasCamera == true and native.canShowPopup( "requestAppPermission" ) ) then
    -- A camera exists, but there is no access to it!
    native.showPopup( "requestAppPermission", { appPermission="Camera" } )
else
    native.showAlert( "Corona", "This device does not have a camera.", { "OK" } )
end
 


       end

       
  return true      
end

local function returnMe(event)

 if(event.phase == "began") then

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

composer.showOverlay( "iconFill", options )
end
return true

end 

local function SaveToTable()

 loadsave.saveTable (gameData.screenList, "screenList.json" )     

end 


local function imageBeingUsed()

print ("nsw")

    local function closeMe( event )
        
        if ( event.phase == "began" ) then

            noObjects:removeSelf()
            noObjects=nil
            okBtn:removeSelf()
            okBtn=nil

        end   
    end

        local function catch( event )
        
        if ( event.phase == "began" ) then

            -- just catch the touch

        end  
        return true 
    end

noObjects = display.newImageRect("imageInUse.png", 500*1.517, 500)
noObjects.x = display.contentCenterX
noObjects.y = display.contentCenterY
sceneGroup:insert(noObjects)

noObjects:addEventListener("touch", catch)

okBtn = display.newImageRect("okTextBtn.png", 35*2.58,35)
okBtn.name = "ok"
okBtn.x = display.contentCenterX 
okBtn.y = display.contentCenterY + 50
sceneGroup:insert(okBtn)

okBtn:addEventListener("touch", closeMe)

end 


local function checkCanDelete(toDelete)

local canDelete = true

    print ("to delete from lists is "..toDelete)

for a=1, #gameData.screenList do

    for b=1, #gameData.screenList[a] do

        print ("looking at "..gameData.screenList[a][b].image)

        if (gameData.screenList[a][b].image=="images/"..toDelete) then

            canDelete=false

            print ("cannot delete")

        end    

    end
    
end 

return canDelete  

end  


  




local function deleteImage(event)

 if(event.phase == "began") then


local fileToDelete = event.target.imageName

print ("to delete is "..fileToDelete)

    local function closeMe( event )
        
        if ( event.phase == "began" ) then


            reallyDel:removeSelf()
            reallyDel=nil
            yesDel:removeSelf()
            yesDel=nil
            okNsBtn:removeSelf()
            okNsBtn=nil

        end  

    return true

    end

        local function deleteMe( event )
        
        if ( event.phase == "began" ) then

            if (checkCanDelete(fileToDelete)) then

            print ("file to delete "..fileToDelete)

            local destDir = system.DocumentsDirectory  -- Location where the file is stored
            local result, reason = os.remove( system.pathForFile( "images/"..fileToDelete, destDir ) )
              
            if result then
               print( "File removed" )

               for i = 1, #gameData.customImages do
                if (gameData.customImages[i]==fileToDelete) then
                table.remove(gameData.customImages,i)
                end
               end

               
            loadsave.saveTable (gameData.customImages, "customImageList.json" )


            else
               print( "File does not exist", reason )  --> File does not exist    apple.txt: No such file or directory
            end

            reallyDel:removeSelf()
            reallyDel=nil
            yesDel:removeSelf()
            yesDel=nil
            okNsBtn:removeSelf()
            okNsBtn=nil


composer.showOverlay("myImagePicker")

            else

            reallyDel:removeSelf()
            reallyDel=nil
            yesDel:removeSelf()
            yesDel=nil
            okNsBtn:removeSelf()
            okNsBtn=nil

                imageBeingUsed()

            end

        end  

    return true

    end

    local function catch( event )
        
        if ( event.phase == "began" ) then

            -- just catch the touch

        end  
        return true 
    end

reallyDel = display.newImageRect("reallyDeleteWindow.png", 500*1.517, 500)
reallyDel.x = display.contentCenterX
reallyDel.y = display.contentCenterY
sceneGroup:insert(reallyDel)

reallyDel:addEventListener("touch", catch)

yesDel = display.newImageRect("yesBtn.png", 40*2.1875,40 )
yesDel.x = display.contentCenterX+90
yesDel.y = display.contentCenterY+50
sceneGroup:insert(yesDel)

yesDel:addEventListener("touch", deleteMe)

okNsBtn = display.newImageRect("noBtn.png", 40*2.1875,40 )
okNsBtn.name = "no"
okNsBtn.x = display.contentCenterX - 100
okNsBtn.y = display.contentCenterY + 50
sceneGroup:insert(okNsBtn)

okNsBtn:addEventListener("touch", closeMe)

end

return true

end 



function displayMyImages()

 local startX = 50
 local startY = 50



 local camBox =  display.newImageRect ("camera.png", 45*1.252,45)
scrollView:insert(camBox)
camBox.x=startX
camBox.y=startY
camBox:addEventListener("touch", takePic)

startX=startX+70

 for i = #gameData.customImages,1,-1 do
   table.remove(gameData.customImages,i)
end 

      if (loadsave.loadTable( "customImageList.json" ) ~= nil) then
      gameData.customImages = loadsave.loadTable( "customImageList.json")
      end

--system.DocumentsDirectory
local doc_path = system.pathForFile( "", system.DocumentsDirectory )
 


--local skip=1 
for file in lfs.dir( doc_path.."/images" ) do
    -- File is the current file or directory name
    print( "Found file: " .. file )
local extension = file:sub(-4,-1)
print (extension)

    if (extension==".jpg") then

        table.insert(myFiles, file)
end

end

for fileList=1, #gameData.customImages do
print ("my file is "..gameData.customImages[fileList])
end    

for i=1, #gameData.customImages do
    print ("my files zie "..#gameData.customImages)

    backBoxes[i]= display.newImageRect("selectImageBtn.png",55,55)
scrollView:insert(backBoxes[i])
backBoxes[i].x=startX
backBoxes[i].y=startY

imageBoxes[i]=display.newImageRect("images/"..gameData.customImages[i],system.DocumentsDirectory,50,50)
scrollView:insert(imageBoxes[i])
imageBoxes[i].imageName="images/"..gameData.customImages[i]
imageBoxes[i].x=startX
imageBoxes[i].y=startY
imageBoxes[i]:addEventListener("touch", setImage)

deleteBtn[i] = display.newImageRect("closeCross.png",20,20)
scrollView:insert(deleteBtn[i])
deleteBtn[i].x = imageBoxes[i].x-15
deleteBtn[i].y = imageBoxes[i].y-20
deleteBtn[i].imageName = gameData.customImages[i]
deleteBtn[i]:addEventListener("touch", deleteImage)


startX=startX+70


if (startX>260) then

startX=50
startY=startY+80

end  

--[[  

if (resetY==true) then

print ("resetYYYYY")
   -- startY=startY-80
    resetY=false

end    

print ("i si "..i)

    local it = i%4
    print ("it "..it)

   if (i == 3) then
    print ("go below 3")
    startY=startY+80

    startX = 50
    resetY=true

end

    if (i>4 and i % 4 == 0) then
    print ("go below 4")
    startY=startY+80
    startX = 50
    end

]]--

end 



end

-- Create text field

displayMyImages()

local picturePic = display.newImageRect("folder.png", 40,40)
picturePic.x=420
picturePic.y=40

picturePic:addEventListener("touch", backToImages)

local closeCross = display.newImageRect("backBtnPopUp.png", 35,35)
closeCross.x=50
closeCross.y=45

closeCross:addEventListener("touch", returnMe)


sceneGroup:insert (imageGroup)
sceneGroup:insert (scrollView)
sceneGroup:insert (picturePic)
sceneGroup:insert (closeCross)



end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

      parent=event.parent

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  -- Reference to the parent scene object
 
    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene

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