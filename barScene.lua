local ImageSize = require "imagesizelua"
local usageData = require "usageData"
local  barScene = {}
local widget = require( "widget" )
local gameData = require( "gameData" )
local loadsave = require( "loadsave" ) 

--[[ barScrollView = widget.newScrollView(
    {
 
    }
)--]]


local topIcons = {}
 local topPos = {60, 160, 260, 360}

 local topIconIndex=1

 local startScroll=10

 local midReading = false

 local noDelete=false

  local sentenceBuilder = {}
   local banglaSentenceBuilder = {}
  local audioSrc = {}

  local canPlaySentence=true

   local noDelete=false

  -- local readBtn
   --local deleteBtn

   local longNumber
   local hundredNumber

    local hasNumber = false

    local double=""
local hundred=""

local englishFolder=""


   

     topSquare = display.newRect (display.contentWidth-40, 65, 80,80)
    topSquare:setFillColor(27/255, 186/255, 161/255)



   topBar = display.newImageRect ("topBarStrip.png", 2,65)
    topBar.x = display.contentWidth-70
    topBar.y = 65


    local bottomBar = display.newImageRect ("bottomStrip.png", 1.5,180)
    bottomBar.x = display.contentWidth-70
    bottomBar.y = 200
  



local function deleteWord(event)

if(event.phase == "began" and noDelete==false) then

    if (topIconIndex >1) then

      topIconIndex = topIconIndex-1


if (topIconIndex>3) then

    barScrollView:scrollToPosition
{
    x = startScroll - ((topIconIndex-4)*85),

    time = 200
}
end

      topIcons[topIconIndex]:removeSelf()
      topIcons[topIconIndex] = nil

      topIcons[topIconIndex] = display.newGroup()


      table.remove( sentenceBuilder, topIconIndex )
      table.remove( banglaSentenceBuilder, topIconIndex )
      table.remove (audioSrc, topIconIndex)

    end

end

return true

end 


function createBar ()

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

 barScrollView = widget.newScrollView(
    {
        top = 25,
        left = 0,
        width = 405,
        height = 80,
        scrollWidth = 0,
        scrollHeight = 50,
        verticalScrollDisabled = true,
        backgroundColor = { 27/255, 186/255, 161/255 },
        listener = scrollListener
    }
)


--myScene:insert(scrollView)

    barScrollView:scrollToPosition
{
    x = startScroll,

    time = 200
}

for topicon = 1, 10 do

topIcons[topicon] = display.newGroup()

end 


local xforBtn=55
local yforBtn=xforBtn*1.34

readBtn = display.newImageRect("playBtn.png", xforBtn,yforBtn)
readBtn.x=display.contentWidth-35
readBtn.y=150
--imageGroup:insert(readBtn)

readBtn:addEventListener("touch", playSentenceTouch)

local xforBtnDel=55
local yforBtnDel=xforBtnDel*1.177

deleteBtn = display.newImageRect("deleteBtn.png", xforBtnDel,yforBtnDel)
deleteBtn.x=display.contentWidth-35
deleteBtn.y=66


deleteBtn:addEventListener("touch", deleteWord)


end


local function insertSentenceData(mySentence)


 local function tableContains(table, element)

--print (#table)
for i = 1, #table  do
  --print (table[i].text..'  '..element)
  if table[i].text==element then
    local count = table[i].count
    count=count+1
    table[i].count=count
    loadsave.saveTable (usageData.sentences, "sentenceData.json" )
    return true;
  end
  end  
return false;
end  


local hasValue = tableContains(usageData.sentences, mySentence);

--print ('table has value ')
 -- print(hasValue)

if (hasValue==false) then

table.insert( usageData.sentences,  { text=mySentence, count=1 }  )
  loadsave.saveTable (usageData.sentences, "sentenceData.json" )
end 


end  


local function  playSentence( wordStart )

local scrollPlace

print( "start playSentence ".. wordStart)

if (wordStart==1) then

    local fullSentence=""

    for s=1, #sentenceBuilder do

      fullSentence = fullSentence.." "..banglaSentenceBuilder[s]

    end  

    print ("full sentence is "..fullSentence)

    insertSentenceData(fullSentence)

end

if (gameData.selectedCardIndex==3) then

  englishFolder="english/"

else

  englishFolder=""

end

wordCount = wordStart
scrollPlace = wordCount

    local function wordFinished( event )
      print( "Narration Finished on channel", event.channel )
      if ( event.completed ) then
          print( "Narration completed playback naturally" )
      else
          print( "Narration was stopped before completion" )
      end

         local child = topIcons[wordCount][2]


          child.isVisible=false

          midReading=false

      playSentence(wordCount+1)

    end


    local function wordFinishedDouble( event )
      print( "Narration Finished on channel", event.channel )
      if ( event.completed ) then
          print( "Narration completed playback naturally" )
      else
          print( "Narration was stopped before completion" )
      end

         local child1 = topIcons[wordCount][2]

          child1.isVisible=false

        local child2 = topIcons[wordCount+1][2]

          child2.isVisible=false

          midReading=false

      playSentence(wordCount+2)

    end


    local function wordFinishedHundred( event )
      print( "Narration Finished on channel", event.channel )
      if ( event.completed ) then
          print( "Narration completed playback naturally" )
      else
          print( "Narration was stopped before completion" )
      end

         local child1 = topIcons[wordCount][2]

          child1.isVisible=false

        local child2 = topIcons[wordCount+1][2]

          child2.isVisible=false


        local child3 = topIcons[wordCount+2][2]

          child3.isVisible=false

          midReading=false

      playSentence(wordCount+3)

    end

    local function readDouble( event )

         print ("i am double reader")

        if (double ~="0") then 

          if (audio.isChannelPlaying(2)) then
           audio.stop(2)
         end

        local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..englishFolder..double..".mp3" )

          if (soundToPlay==nil)then
               soundToPlay = audio.loadSound( "sounds/"..double..".wav", system.DocumentsDirectory )
          end 

 

         local playMe = audio.play( soundToPlay, {onComplete=wordFinishedHundred, channel=2 } )

       else

        
         local child1 = topIcons[wordCount][2]

          child1.isVisible=false

        local child2 = topIcons[wordCount+1][2]

          child2.isVisible=false


        local child3 = topIcons[wordCount+2][2]

          child3.isVisible=false

          midReading=false

      playSentence(wordCount+3)

       end

    end



if (wordCount <= #sentenceBuilder) then





-- deal with 3 digit numbers


local singleFlag=true
local doubleFlag=false
local hundredFlag=false

  if (tonumber(sentenceBuilder[wordCount])) then

     print ("i am single number")

     singleFlag = true

     scrollPlace = wordCount

    if ( wordCount+1 <= #sentenceBuilder) then

      if (tonumber(sentenceBuilder[wordCount+1])) then

        print ("i am double number")

        if (sentenceBuilder[wordCount]=="0") then

        double = sentenceBuilder[wordCount+1]

        else

        double = sentenceBuilder[wordCount] .. sentenceBuilder[wordCount+1]

        end

        singleFlag = false
        doubleFlag = true

        scrollPlace = wordCount+1

      if ( wordCount+2 <= #sentenceBuilder) then

      if (tonumber(sentenceBuilder[wordCount+2])) then

        print ("i am triple number")

        hundred = sentenceBuilder[wordCount].."00"

        if (sentenceBuilder[wordCount+1]=="0") then

        double = sentenceBuilder[wordCount+2]

        else

        double = sentenceBuilder[wordCount+1] .. sentenceBuilder[wordCount+2]

        end


        singleFlag = false
        doubleFlag = false
        hundredFlag = true

        scrollPlace = wordCount+2

      end

    end 


      end

    end  

  end



----

  if (hundredFlag) then

  local child1 = topIcons[wordCount][2]
   child1.isVisible=true

    local child2 = topIcons[wordCount+1][2]
   child2.isVisible=true 

    local child3 = topIcons[wordCount+2][2]
   child3.isVisible=true 

   midReading=true

   if (hundred ~= "000") then
          if (audio.isChannelPlaying(2)) then
           audio.stop(2)
         end

        local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..englishFolder..hundred..".mp3" )

          if (soundToPlay==nil)then
               soundToPlay = audio.loadSound( "sounds/"..hundred..".wav", system.DocumentsDirectory )
          end 



         local playMe = audio.play( soundToPlay, {onComplete=readDouble, channel=2 } )

       else

           midReading=true

        local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..englishFolder..double..".mp3" )

          if (soundToPlay==nil)then
               soundToPlay = audio.loadSound( "sounds/"..double..".wav", system.DocumentsDirectory )
          end 



         local playMe = audio.play( soundToPlay, {onComplete=wordFinishedHundred, channel=2 } )

       end

  end 


  if (doubleFlag) then

  local child1 = topIcons[wordCount][2]
   child1.isVisible=true

    local child2 = topIcons[wordCount+1][2]
   child2.isVisible=true 

   midReading=true

             if (audio.isChannelPlaying(2)) then
           audio.stop(2)
         end

        local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..englishFolder..double..".mp3" )

          if (soundToPlay==nil)then
               soundToPlay = audio.loadSound( "sounds/"..double..".wav", system.DocumentsDirectory )
          end 




         local playMe = audio.play( soundToPlay, {onComplete=wordFinishedDouble, channel=2 } )

  end  


  if (singleFlag) then

   local child = topIcons[wordCount][2]
   child.isVisible=true

   midReading=true

            if (audio.isChannelPlaying(2)) then
           audio.stop(2)
         end

        local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..englishFolder..sentenceBuilder[wordCount]..".mp3" )

          if (soundToPlay==nil)then
               soundToPlay = audio.loadSound( "sounds/"..sentenceBuilder[wordCount]..".wav", system.DocumentsDirectory )
          end 

 

         local playMe = audio.play( soundToPlay, {onComplete=wordFinished, channel=2 } )

   end  

   if (scrollPlace>4) then
    barScrollView:scrollToPosition
{
    x = startScroll - ((scrollPlace-3)*85),

    time = 200
}

end    

else

  wordCount=0
  canPlaySentence=true
  noDelete=false

end  


end

 
function playSentenceTouch(event)

  print (canPlaySentence)

 if(event.phase == "began") then

  if (canPlaySentence) then


            barScrollView:scrollToPosition
{
    x = startScroll,

    time = 200
}

  noDelete=true

  canPlaySentence=false

  playSentence(1)

end

 end

return true

end 


local function playTopIcon( event )

local icon = event.target

if (gameData.selectedCardIndex==3) then

  englishFolder="english/"

else

  englishFolder=""

end

    local function wordFinished( event )
      print( "Narration Finished on channel", event.channel )
      if ( event.completed ) then
          print( "Narration completed playback naturally" )
      else
          print( "Narration was stopped before completion" )
      end

         local child = icon[2]

         if (child ~= nil) then

          child.isVisible=false

        end



    end



if(event.phase == "began" and midReading==false) then

          if (audio.isChannelPlaying(2)) then
           audio.stop(2)
         end

          local child = event.target[2]
          child.isVisible=true

           local soundName = event.target.myAudio
           local src = event.target.src

          local soundToPlay = nil

         

            soundToPlay = audio.loadSound( "voice/"..englishFolder..soundName..".mp3" )

           if (soundToPlay==nil) then
             soundToPlay = audio.loadSound( "sounds/"..soundName..".wav", system.DocumentsDirectory  )

          end



--[[        local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..englishFolder..soundName..".mp3" )

          if (soundToPlay==nil)then
               soundToPlay = audio.loadSound( "sounds/"..soundName..".wav", system.DocumentsDirectory )
          end --]]
 
            local playMe = audio.play( soundToPlay, {onComplete=wordFinished, channel=2 } )

  end
  return true          

end

local function insertTopImage (mainIcon)

  if (gameData.selectedCardIndex==3) then

  englishFolder="english/"

else

  englishFolder=""

end

  if (topIconIndex<10) then

  local pos = topIconIndex

  print ("pos "..pos)

if (pos>4) then

    barScrollView:scrollToPosition
{
    x = startScroll - ((pos-3)*85),

    time = 200
}

end


  local mainBox = display.newImageRect( "blankIcon.png",77,77)
  local highlight = display.newImageRect ("highlight.png",80,80)

  local useImage
  local useText
  local useAudio

  if (gameData.isNumberScreen) then

    useImage = gameData.workingScreenNumber[mainIcon.tablePos].image
    useText = gameData.workingScreenNumber[mainIcon.tablePos].text
    useAudio = gameData.workingScreenNumber[mainIcon.tablePos].audio

  else

    useImage = gameData.workingScreen[mainIcon.tablePos].image
    useText = gameData.workingScreen[mainIcon.tablePos].text
    useAudio = gameData.workingScreen[mainIcon.tablePos].audio


  end

 --local width, height, format = ImageSize.imgsize("pecs/"..useImage..".png")

local ratio = 1

local tempImg = display.newImage("pecs/"..useImage..".png")

if (tempImg) then

    ratio = tempImg.width/tempImg.height
       tempImg:removeSelf()
        tempImg = nil


  end

local default=45

local rat = ratio*45
if (rat>80) then
  default=35
  end

  local iconImage = display.newImageRect( "pecs/"..useImage..".png", ratio*default,default)
  
  --print ('my ratio '..useImage..' '..rat)
  if (iconImage==nil) then

      local tempImg = display.newImage(useImage,system.DocumentsDirectory,system.DocumentsDirectory)

    if (tempImg) then

    ratio = tempImg.width/tempImg.height
       tempImg:removeSelf()
        tempImg = nil


  end

    iconImage = display.newImageRect(useImage,system.DocumentsDirectory,ratio*default,default)
  end
  iconImage.y=iconImage.y-10  
  local iconText = display.newText( useText, iconImage.x, iconImage.y+35, native.systemFont, 14 )
  iconText:setFillColor( 0, 0, 0 )
    if (gameData.workingScreen == gameData.englishLetterScreen
        or gameData.workingScreen == gameData.banglaSorbornoScreen
        or gameData.workingScreen == gameData.banglaBenjorbornoScreen) then
    iconText.alpha=0
  end

 

  topIcons[pos]:insert(mainBox,true)
  topIcons[pos]:insert(highlight,true)


  topIcons[pos]:insert(iconImage)
  topIcons[pos]:insert(iconText)

  topIcons[pos].myAudio = useAudio

  topIcons[pos]:addEventListener( "touch", playTopIcon )


   local child = topIcons[pos][2]
   child.isVisible=false



local setX=60

  if (pos==1) then
    setX=60
  else
    setX = topIcons[pos-1].x+100
  end


  topIcons[pos].x = setX
  topIcons[pos].y = 40


  barScrollView:insert(topIcons[pos])



--imageGroup:insert(topIcons[pos])

topIconIndex=topIconIndex+1

--print  ("tix add"..topIconIndex)

end

end  

function buildSentence(event)

 if(event.phase == "began") then

  if (gameData.canTouch) then

 --print ("my text "..event.target.text)

 local function tableContains(table, element)

--print (#table)
for i = 1, #table  do
  --print (table[i].text..'  '..element)
  if table[i].text==element then
    local count = table[i].count
    count=count+1
    table[i].count=count
    loadsave.saveTable (usageData.sampleData, "sampleData.json" )
    return true;
  end
  end  
return false;
end  


local hasValue = tableContains(usageData.sampleData, event.target.text);

--print ('table has value ')
 -- print(hasValue)

if (hasValue==false) then

table.insert( usageData.sampleData,  { text=event.target.text, count=1 }  )
  loadsave.saveTable (usageData.sampleData, "sampleData.json" )
end 


insertTopImage(event.target)

 local soundName = event.target.myAudio
 local src = event.target.src

    if (gameData.classMode==false) then

       if (audio.isChannelPlaying(2)) then
           audio.stop(2)
         end

          local soundToPlay = nil

--[[          if (src=="local") then

            soundToPlay = audio.loadSound( "voice/"..englishFolder..soundName..".mp3" )

          else
             soundToPlay = audio.loadSound( "sounds/"..soundName..".wav", system.DocumentsDirectory  )

          end--]]

      local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..englishFolder..soundName..".mp3" )

          if (soundToPlay==nil)then

               soundToPlay = audio.loadSound( "sounds/"..soundName..".wav", system.DocumentsDirectory  )
          end
   
            local playMe = audio.play( soundToPlay, {channel=2} )

            --limit to 9 words
    end
             

          if (#sentenceBuilder<9) then


            table.insert (sentenceBuilder, soundName)
            table.insert (banglaSentenceBuilder, event.target.text)
            table.insert (audioSrc, event.target.src)
   

          end

        

 end 

end

end  

-- local commonBtn = display.newImageRect( "category/common.png", 50,50)
-- commonBtn.x=display.contentWidth-35
-- commonBtn.y=220

-- sceneGroup:insert(commonBtn)

-- commonBtn:addEventListener( "touch", loadScreen )

function setQuickButton()


end


function insertToScene(theScene)

if (gameData.toInsert==true) then

print ("in scene")
print (theScene)

gameData.toInsert=false
theScene:insert(topSquare)
theScene:insert(topBar)
theScene:insert(bottomBar)
theScene:insert(readBtn)
theScene:insert(deleteBtn)
theScene:insert(barScrollView)




else

    print ("on stage")

gameData.toInsert=true
display.getCurrentStage():insert(topSquare)
display.getCurrentStage():insert(topBar)
display.getCurrentStage():insert(bottomBar)
display.getCurrentStage():insert(readBtn)
display.getCurrentStage():insert(deleteBtn)
display.getCurrentStage():insert( barScrollView )
   

end    

end    




return barScene