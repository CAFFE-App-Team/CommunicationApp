local composer = require( "composer" )
local gameData = require( "gameData" )
local widget = require( "widget" )
local lfs = require "lfs"
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local myFiles = {}
 local imageBoxes={}
 local checkMarks={}
 local deleteBtn={}
 local labelBox
 local okBtn

  local parent

 local startLabelText
 local parent

 local resetY=false

 local iMayPlay=true
 
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

    local exists = lfs.chdir( temp_path.."/sounds" )
    if exists then
        print ("it exists already")
    else
    lfs.mkdir( "sounds" )
    new_folder_path = lfs.currentdir() .. "/sounds"
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



local function backToSounds( event )
 
      if ( event.phase == "began" ) then

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

audio.stop()
composer.showOverlay( "soundPicker", options )

    end

end
 

local function  playSound( event)


    local function onCompleteSound (event)

    -- Free the audio memory and close the file now that we are done playing it.
    audio.dispose(event.handle)
    event.handle=nil
    iMayPlay=true
end 

    if(event.phase == "began") then
         local soundName = event.target.soundName

  

          local soundToPlay = audio.loadSound( "sounds/"..soundName..".wav", system.DocumentsDirectory )
          
          if (iMayPlay) then
            iMayPlay=false
          local playMe = audio.play( soundToPlay,  { onComplete=onCompleteSound }  )
            end
    end

    return true
end 

local function  setSound( event)

    if(event.phase == "began") then

     gameData.workingScreen[gameData.indexEdit].audio=event.target.soundName
    

       print ("go")
    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

audio.stop()


composer.showOverlay( "iconFill", options )

    end
return true
end

local function record( event )
      if(event.phase == "began") then

            local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }
audio.stop()
composer.showOverlay( "recordVoice", options )
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
audio.stop()
composer.showOverlay( "iconFill", options )
end
return true

end 


local function soundBeingUsed()


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

noObjects = display.newImageRect("soundInUse.png", 500*1.517, 500)
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

        print ("looking at "..gameData.screenList[a][b].audio)

        if (gameData.screenList[a][b].audio..".wav"==toDelete) then

            canDelete=false

            print ("cannot delete")

        end    

    end
    
end 

return canDelete  

end 




local function deleteSound(event)

 if(event.phase == "began") then


local fileToDelete = event.target.soundName

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

            local destDir = system.DocumentsDirectory  -- Location where the file is stored
            local result, reason = os.remove( system.pathForFile( "sounds/"..fileToDelete, destDir ) )
              
            if result then
               print( "File removed" )


            else
               print( "File does not exist", reason )  --> File does not exist    apple.txt: No such file or directory
            end

            reallyDel:removeSelf()
            reallyDel=nil
            yesDel:removeSelf()
            yesDel=nil
            okNsBtn:removeSelf()
            okNsBtn=nil

audio.stop()
composer.showOverlay("mySoundPicker")

            else

            reallyDel:removeSelf()
            reallyDel=nil
            yesDel:removeSelf()
            yesDel=nil
            okNsBtn:removeSelf()
            okNsBtn=nil

            soundBeingUsed()

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

--system.DocumentsDirectory
local doc_path = system.pathForFile( "", system.DocumentsDirectory )
 
local skip=1 
for file in lfs.dir( doc_path.."/sounds" ) do
    -- File is the current file or directory name
    print( "Found file: " .. file )
    
    if (skip>2) then
        table.insert(myFiles, file)
    end    
    skip=skip+1

end

local boxBack = display.newImageRect ("blankIcon.png", 40,40 * 1.549)
scrollView:insert(boxBack)
boxBack.x=startX
boxBack.y=startY
local camBox =  display.newImageRect ("recordIcon.png", 30,30*1.549)
scrollView:insert(camBox)
camBox.x=startX
camBox.y=startY
camBox:addEventListener("touch", record)

startX=startX+70

for fileList=1, #myFiles do
print ("my file is "..myFiles[fileList])
end    

for i=1, #myFiles do
    print ("my files zie "..#myFiles)

local tempSoundName =  myFiles[i]  

print ("my f "..myFiles[i]) 

imageBoxes[i]=display.newImageRect("playIcon.png",50,50)
scrollView:insert(imageBoxes[i])
imageBoxes[i].soundName=tempSoundName:sub(1, -5)
imageBoxes[i].x=startX
imageBoxes[i].y=startY
imageBoxes[i]:addEventListener("touch", playSound)

checkMarks[i] = display.newImageRect("select.png",20,20)
scrollView:insert(checkMarks[i])
checkMarks[i].x = imageBoxes[i].x+20
checkMarks[i].y = imageBoxes[i].y+22
checkMarks[i].soundName = tempSoundName:sub(1, -5)
checkMarks[i]:addEventListener("touch", setSound)

deleteBtn[i] = display.newImageRect("closeCross.png",20,20)
scrollView:insert(deleteBtn[i])
deleteBtn[i].x = imageBoxes[i].x-20
deleteBtn[i].y = imageBoxes[i].y-22
deleteBtn[i].soundName = tempSoundName
deleteBtn[i]:addEventListener("touch", deleteSound)

local soundLabel = display.newText(  tempSoundName:sub(1, -5), imageBoxes[i].x, imageBoxes[i].y+38, native.systemFont, 14 )  
scrollView:insert(soundLabel)



startX=startX+70

if (startX>260) then

startX=50
startY=startY+80

end 

end 



end

-- Create text field

displayMyImages()

local picturePic = display.newImageRect("folder.png", 40,40)
picturePic.x=420
picturePic.y=40

picturePic:addEventListener("touch", backToSounds)

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