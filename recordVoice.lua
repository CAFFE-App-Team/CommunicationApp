local composer = require( "composer" )
local gameData = require( "gameData" )
local widget = require( "widget" )
local lfs = require "lfs"

local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight
local defaultField
local enteredText
local noSndName
local okNsBtn
local soundSaved
local recordText
local recordText2
local oldFileName
local newFileName
local shouldRename
local pressTimer
local canFire=true
local pressRuntimer

local thisTimeName={}

local iMayPlay=true

 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
  local imageGroup = display.newGroup()


   local bg = display.newImageRect ("whiteBG.png", 405, 255)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg)

  enteredText=""

local platVersion = system.getInfo( "platformVersion" )
platVersion = string.sub( platVersion, 1, 1 )
if system.getInfo( "platformName" ) == "iPhone OS" and platVersion == "5" then
    if audio.supportsSessionProperty then
        audio.setSessionProperty(audio.MixMode, audio.PlayAndRecordMixMode)
    end
end


local isAndroid = false

local background = display.newRect( 0, 0, 400, 250 )

background:setFillColor( 69/255, 39/255, 160/255 )
background.x = display.contentCenterX
background.y = display.contentCenterY
imageGroup:insert(background)




oldFileName = "temp"
if "simulator" == system.getInfo("environment") then
    oldFileName = oldFileName .. ".wav"
else
    local platformName = system.getInfo( "platformName" )
    if "iPhone OS" == platformName then
        oldFileName = oldFileName .. ".aif"
    elseif "Android" == platformName then
        oldFileName = oldFileName .. ".wav"
        isAndroid = true
    else
        print("Unknown OS " .. platformName )
    end
end
print (oldFileName)

            local destDir = system.DocumentsDirectory  -- Location where the file is stored
            local result, reason = os.remove( system.pathForFile("sounds/"..oldFileName, destDir ) )
              
            if result then
               print( "File removed" )
            else
               print( "File does not exist", reason )  --> File does not exist    apple.txt: No such file or directory
            end

soundSaved=false
shouldRename=true
-- title

for empTable = #thisTimeName,1,-1 do
    table.remove(thisTimeName,empTable)
end





local recordingStatus = display.newText( " ", centerX, 100, native.systemFont, 32 )
recordingStatus:setFillColor( 10/255, 240/255, 102/255 )
imageGroup:insert( recordingStatus)




local r                 -- media object for audio recording
local recButton         -- gui buttons
local fSoundPlaying = false   -- sound playback state
local fSoundPaused = false    -- sound pause state





-- Update the state dependent texts
local function updateStatus ( event )
    local statusText = " "
    local statusText2 = " "
    if r then
        local recString = ""
        local fRecording = r:isRecording ()
        if fRecording then 
            recString = "RECORDING" 
            recButton.isVisible=false
            stopButton.isVisible=true

        recordText:removeSelf()
        recordText=nil  


        recordText2:removeSelf()
        recordText2=nil   

        recordText = display.newText( "রেকর্ডিং বন্ধ করতে বোতামে", display.contentCenterX-110, 200, native.systemFont, 14 )
        recordText:setFillColor( 1, 1, 1 )
        imageGroup:insert(recordText)


        recordText2 = display.newText( "আলতো করে চাপ দিন।", display.contentCenterX-100, 220, native.systemFont, 14 )
        recordText2:setFillColor( 1, 1, 1 )
        imageGroup:insert(recordText2)

        elseif fSoundPlaying then


        elseif fSoundPaused then
            --recString = "Paused"
            --recButton:setLabel( "Resume playback") 
        else
            recButton.isVisible=true
            stopButton.isVisible=false

         if (recordText~=nil) then   
            
        recordText:removeSelf()
        recordText=nil  

        recordText2:removeSelf()
        recordText2=nil   


        recordText = display.newText( "রেকর্ড করতে বোতামে", display.contentCenterX-100, 200, native.systemFont, 14 )
recordText:setFillColor( 1, 1, 1 )
imageGroup:insert(recordText)

recordText2 = display.newText( "আলতো করে চাপ দিন।", display.contentCenterX-90, 220, native.systemFont, 14 )
recordText2:setFillColor( 1, 1, 1 )
imageGroup:insert(recordText2)


    end

        end

        --statusText =  recString 
        --statusText2 = "Sampling rate: " .. tostring (r:getSampleRate() .. "Hz")
    end
    --recordingStatus.text = statusText

    --s:setText (statusText)
    --s2:setText (statusText2)
end

-------------------------------------------------------------------------------
--  *** Event Handlers ***
-------------------------------------------------------------------------------

local function textListener( event )
 
    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"
 
    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        print( event.target.text )
        shouldRename=true
        
        print ("entere to table "..event.target.text)  
        enterSoundValue()
 
    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end

local function numberConvert (english)

local bangla

if (english==1) then

    bangla="১"

    elseif (english==2) then

        bangla="২"

        elseif (english==3) then

            bangla="৩"

            elseif (english==4) then

                bangla="৪"       

                elseif (english==5) then

                    bangla="৫"

                    elseif (english==6) then

                        bangla="৬"

                        elseif (english==7) then

                            bangla="৭"

                            elseif (english==8) then

                                bangla="৮"

                                elseif (english==9) then

                                bangla="৯"

                                else

                                    bangla=english

                                end

                                print ("bangla "..bangla)

return bangla

end    


--local function setSoundName()

    function enterSoundValue( event )

        if (shouldRename==true) then

        if (defaultField ~= nil) then

        if (defaultField.text==nil) then
        enteredText = ""
        else
        enteredText = defaultField.text
        end 

        else
        enteredText = ""
        end

        --check if filename already exists

        local numberSuffix=1
        local checkName = enteredText
        local suffix=""
 

        local function addNumberToName()

            local path = system.pathForFile( "/sounds/"..checkName..suffix..".wav", system.DocumentsDirectory )
            local fhd = io.open( path )

            local usedName=false
            for check=1, #thisTimeName do
                if (thisTimeName[check]==checkName..suffix) then
                    print ("true true true")
                    usedName=true
                end    
             end   

             print ("used name ")
             print (usedName)
                    -- Determine if file exists
            if (fhd and usedName==false) then
               print( "File exists" )
               suffix = numberConvert(numberSuffix)
               numberSuffix=numberSuffix+1
               fhd:close()
               addNumberToName()
            else
                print( "save name is "..enteredText..suffix )
                local bSuffix = numberConvert(suffix)
                enteredText = enteredText..bSuffix
            end

        end


        if (enteredText~="") then

        addNumberToName()
          


        local destDir = system.DocumentsDirectory  -- Location where the file is stored
        local result, reason = os.rename(
        system.pathForFile( "/sounds/"..oldFileName, destDir ),
        system.pathForFile( "/sounds/"..enteredText..".wav", destDir )
        )
  
        if result then

            --newly recorded sound was being set as card sound straight away... removed this
            --hope for new ill effects!

--[[            print( "File renamed to "..enteredText )
            --soundSaved=true
            oldFileName=enteredText..".wav"
            gameData.workingScreen[gameData.indexEdit].audio=enteredText
            shouldRename=false
            table.insert( thisTimeName, enteredText)
            native.setKeyboardFocus( nil )--]]
        else
            print( "File not renamed", reason )  --> File not renamed    orange.txt: No such file or directory
        
  
        end

      

    end

  
end

end  

     function setSoundValue( event )

     if(event.phase == "began") then

        enterSoundValue()

    end

    end  

local function onCompleteSound (event)
    fSoundPlaying = false
    fSoundPaused = false
        shouldRename=true
    --setSoundName()
    -- Free the audio memory and close the file now that we are done playing it.
    audio.dispose(event.handle)
    event.handle=nil

    soundSaved=true

    iMayPlay=true
end 


local function listen(event)

  if (event.phase == "began") then

          if (iMayPlay) then

            iMayPlay=false

        local filePath = system.pathForFile( "/sounds/"..oldFileName, system.DocumentsDirectory )
            -- Play back the recording
            print ("fp "..filePath)
            local file = io.open( filePath, "r" )
            
            if file then
                io.close( file )
                fSoundPlaying = true
                fSoundPaused = false
                
                playbackSoundHandle = audio.loadStream( "/sounds/"..oldFileName, system.DocumentsDirectory )
                

                audio.play( playbackSoundHandle, { onComplete=onCompleteSound } )
            end 
end

  end  

return true

end  

local function stopOnTimeLimit()

if r then
        if r:isRecording() then
            r:stopRecording()

            local filePath = system.pathForFile( "/sounds/"..oldFileName, system.DocumentsDirectory )
            -- Play back the recording
            print ("fp "..filePath)
            local file = io.open( filePath, "r" )
            
            if file then
                io.close( file )
                fSoundPlaying = true
                fSoundPaused = false
                
                playbackSoundHandle = audio.loadStream( "/sounds/"..oldFileName, system.DocumentsDirectory )
                audio.play( playbackSoundHandle, { onComplete=onCompleteSound } )
            end 
        end
    end        

end    

local function longPressUpdate()

  local timeHeld = os.time() - pressTimer
  if (timeHeld >= 8 and canFire) then
    canFire=false
    print("8 sec record")
    timer.cancel(pressRuntimer)
    stopOnTimeLimit()
   end 

end  

local function recordTimer( )

    pressTimer = os.time()
    canFire=true
    pressRuntimer = timer.performWithDelay(1, longPressUpdate, -1)

end  
 
local function recButtonPress ( event )
    if fSoundPlaying == false then

     if r then
        if r:isRecording() then
            r:stopRecording()

            local filePath = system.pathForFile( "/sounds/"..oldFileName, system.DocumentsDirectory )
            -- Play back the recording
            print ("fp "..filePath)
            local file = io.open( filePath, "r" )
            
            if file then
                io.close( file )
                fSoundPlaying = true
                fSoundPaused = false
                
                playbackSoundHandle = audio.loadStream( "/sounds/"..oldFileName, system.DocumentsDirectory )
                audio.play( playbackSoundHandle, { onComplete=onCompleteSound } )
            end                
        else


            local filePath = system.pathForFile( "/sounds/"..oldFileName, system.DocumentsDirectory )
            
            if (r~=nil) then
            r=nil
            end    

            r = media.newRecording(filePath)



            fSoundPlaying = false
            fSoundPaused = false
            r:startRecording()
            recordTimer()
        end
    end
end
end

-- Increase the sample rate if possible
-- Valid rates are 8000, 11025, 16000, 22050, 44100 but many devices do not
-- support all rates 
local rateUpButtonPress = function( event )
    local theRates = {8000, 11025, 16000, 22050, 44100}
    if not r:isRecording () and not fSoundPlaying and not fSoundPaused then
--        r:stopTuner()
        local f = r:getSampleRate()
        --  get next higher legal sampling rate
        local i, v = next (theRates, nil)                 
        while i do
            if v <= f then 
                i, v = next (theRates, i) 
            else
                i = nil
            end
        end    
        if v then 
            r:setSampleRate(v) 
        else
            r:setSampleRate(theRates[1])
        end   
--        r:startTuner()
    end
end

-- Decrease the sample rate if possible
-- Valid rates are 8000, 11025, 16000, 22050, 44100 but many devices do not
-- support all rates.
local rateDownButtonPress = function( event )
    local theRates = {44100, 22050, 16000, 11025, 8000}
    if not r:isRecording () and not fSoundPlaying and not fSoundPaused then
--        r:stopTuner()
        local f = r:getSampleRate()
        --  get next lower legal sampling rate
        local i, v = next (theRates, nil)                 
        while i do
                if v >= f then 
                    i, v = next (theRates, i) 
                else
                    i = nil
                end
        end    
        if v then 
            r:setSampleRate(v) 
        else
            r:setSampleRate(theRates[1])
        end            
--        r:startTuner()
    end
end


-------------------------------------------
-- *** Create Buttons ***
-------------------------------------------

-- Record Button
recButton = widget.newButton
{
    defaultFile = "recordIcon.png",
    overFile = "buttonRedOver.png",
    onPress = recButtonPress,
    fontSize = 20,
    emboss = true
}

imageGroup:insert( recButton )

stopButton = widget.newButton
{
    defaultFile = "stopRecBtn.png",
    onPress = recButtonPress,
    fontSize = 20,
    emboss = true
}

imageGroup:insert( stopButton )

-----------------------------------------------
-- *** Locate the buttons on the screen ***
-----------------------------------------------
recButton.x = centerX;         recButton.y = 200
stopButton.x = centerX;         stopButton.y = 200

stopButton.isVisible=false


local function noRecordNameWarn()

print ("nsnd name")

    local function closeMe( event )
        
        if ( event.phase == "began" ) then

            noSndName:removeSelf()
            noSndName=nil
            okNsBtn:removeSelf()
            okNsBtn=nil

            --setSoundName()

        end  

    return true

    end

        local function catch( event )
        
        if ( event.phase == "began" ) then

            -- just catch the touch

        end  
        return true 
    end

noSndName = display.newImageRect("noSoundRecord.png", 500*1.517, 500)
noSndName.x = display.contentCenterX
noSndName.y = display.contentCenterY+40
sceneGroup:insert(noSndName)

noSndName:addEventListener("touch", catch)


okNsBtn = display.newImageRect("okTextBtn.png", 35*2.58,35)
okNsBtn.name = "ok"
okNsBtn.x = display.contentCenterX 
okNsBtn.y = display.contentCenterY + 50
sceneGroup:insert(okNsBtn)

okNsBtn:addEventListener("touch", closeMe)

end


local function noSoundNameWarn()

print ("nsnd name")

    local function closeMe( event )
        
        if ( event.phase == "began" ) then

            noSndName:removeSelf()
            noSndName=nil
            okNsBtn:removeSelf()
            okNsBtn=nil

            --setSoundName()

        end  

    return true

    end

        local function catch( event )
        
        if ( event.phase == "began" ) then

            -- just catch the touch

        end  
        return true 
    end

noSndName = display.newImageRect("enterSoundName.png", 500*1.517, 500)
noSndName.x = display.contentCenterX
noSndName.y = display.contentCenterY+40
sceneGroup:insert(noSndName)

noSndName:addEventListener("touch", catch)


okNsBtn = display.newImageRect("okTextBtn.png", 35*2.58,35)
okNsBtn.name = "ok"
okNsBtn.x = display.contentCenterX 
okNsBtn.y = display.contentCenterY + 50
sceneGroup:insert(okNsBtn)

okNsBtn:addEventListener("touch", closeMe)

end 



local filePath = system.pathForFile( "/sounds/"..oldFileName, system.DocumentsDirectory )
r = media.newRecording(filePath)
Runtime:addEventListener( "enterFrame", updateStatus )   



local function closeToMySounds( event )
 
      if ( event.phase == "began" ) then

        Runtime:removeEventListener( "enterFrame", updateStatus )

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }


            local destDir = system.DocumentsDirectory  -- Location where the file is stored
            local result, reason = os.remove( system.pathForFile("sounds/"..oldFileName, destDir ) )
              
            if result then
               print( "File removed" )
            else
               print( "File does not exist", reason )  --> File does not exist    apple.txt: No such file or directory
            end

            if (newFileName~=nil) then

            local destDir = system.DocumentsDirectory  -- Location where the file is stored
            local result, reason = os.remove( system.pathForFile("sounds/"..newFileName, destDir ) )
              
            if result then
               print( "File removed" )
            else
               print( "File does not exist", reason )  --> File does not exist    apple.txt: No such file or directory
            end

        end

    audio.stop()

composer.showOverlay( "mySoundPicker", options )

    end

end 

local function  backToMySounds( event)

    if(event.phase == "began") then

enterSoundValue()

   if (soundSaved==false) then

    noRecordNameWarn()

    elseif (enteredText == "") then

    noSoundNameWarn()
    

    else



    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

    Runtime:removeEventListener( "enterFrame", updateStatus )  



audio.stop()

composer.showOverlay( "mySoundPicker", options )

    end
end
return true
end 


        defaultField = native.newTextField( centerX, 100, 100, 30 )
        defaultField.text = tempText
        imageGroup:insert( defaultField)

        defaultField:addEventListener( "userInput", textListener )
        --scrollView:insert(defaultField)
        native.setKeyboardFocus( defaultField )

        okBtn = display.newText(  "OK", defaultField.x+120, defaultField.y, native.systemFont, 16 ) 
        imageGroup:insert( okBtn )
        --scrollView:insert(okBtn)
        okBtn:addEventListener( "touch", setSoundValue )
        okBtn.isVisible=false

local doneBtn = display.newImageRect(  "okTextBtn.png", 40*2.58,40 ) 
doneBtn.x = 380
doneBtn.y = 250
doneBtn:addEventListener( "touch", backToMySounds )
imageGroup:insert( doneBtn)



local labelText = display.newText( "দয়া করে এই শব্দটির নাম দিন।", display.contentCenterX, 70, native.systemFont, 14 )
labelText:setFillColor( 1, 1, 1 )
imageGroup:insert(labelText)

recordText = display.newText( "রেকর্ড করতে বোতামে", display.contentCenterX-100, 200, native.systemFont, 14 )
recordText:setFillColor( 1, 1, 1 )
imageGroup:insert(recordText)

recordText2 = display.newText( "আলতো করে চাপ দিন।", display.contentCenterX-90, 220, native.systemFont, 14 )
recordText2:setFillColor( 1, 1, 1 )
imageGroup:insert(recordText2)


local listenBtn = display.newImageRect(  "playIcon.png", 50, 50 ) 
listenBtn.x = 350
listenBtn.y = 100
listenBtn:addEventListener( "touch", listen )
imageGroup:insert( listenBtn)

local closeCross = display.newImageRect("backBtnPopUp.png", 35,35)
closeCross.x=55
closeCross.y=50

closeCross:addEventListener("touch", closeToMySounds)
imageGroup:insert( closeCross)

sceneGroup:insert( imageGroup)

-- must track latest sound save name.. starts as temp, then hold rename etc... for play and overwrite
-- need last name, new name update replace!!!!

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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