local composer = require( "composer" )
local gameData = require( "gameData" )
local loadsave = require( "loadsave" ) 
local widget = require( "widget" )
local barScene = require "barScene"
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local topImage1
 local topImage2
 local topImage3
 local topImage4
 local mainImageBox
 local letterBox1
 local letterBox2
 local letterBox3
 local letterBox4
 local availLetter1
 local availLetter2
 local availLetter3
local canPlaySentence=true

local canCollide=false;

 local boxHit

 local wordCount

 local wordLength
 local wordNeeded

 local rightArrow
 local leftArrow

 local collectedImages = {}
 local wordSpelling = {}

 local collectedLetters = {}

 local sentenceBuilder = {}

local gridBoxes = {grid1, grid2, grid2, grid4, grid5, grid6, grid7, grid8}

 local letterBoxes = { letterBox1, letterBox2, letterBox3, letterBox4  }
  local topImages = { topImage1, topImage2, topImage3, topImage4  }
  local bottomLetters ={availLetter1, availLetter2, availLetter3}
 
 local letterPlaced ={}
local iconGroups = {}
local topIcons = {}
local collRect = {}
   local editBtn={}
   local screenGrid={}

   local inEditMode=false

   local canPressRightArrow=true
   local canPressLeftArrow=true

 local collidedLetterBox

 local topPos = {60, 160, 260, 360}

 local topIconIndex=1

 local startScroll=10

 local midReading = false

 local noDelete=false

 local iconScale
 local rowCount
 local iconMax

 local startYTable={150,150}
 local startXTable={-15,-15}
 local addX={95}
 local addY={90}

 local gridX={0}
  --local gridX={0, display.contentWidth-15, 2*(display.contentWidth-15)}

 local gridDisplayed=1

 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

gameData.isNumberScreen=true


-- This is added by Kobir for BG
--[[local bg = display.newImageRect ("whiteBG.png", display.contentWidth, display.contentHeight)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg)

    -- Kobir end
    --]]


local imageGroup = display.newGroup()

  iconScale=0.8
  rowCount=6
  iconMax=10





--[[

-- ScrollView listener
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

local scrollView = widget.newScrollView(
    {
        top = 25,
        left = 0,
        width = 405,
        height = 80,
        scrollWidth = 0,
        scrollHeight = 50,
        verticalScrollDisabled = true,
        backgroundColor = { 0.1, 0.6, 0.1 },
        listener = scrollListener
    }
)



sceneGroup:insert(scrollView)

    scrollView:scrollToPosition
{
    x = startScroll,

    time = 200
}

]]--

-- load all data from saves to gd.


local function SaveToTable()

  loadsave.saveTable (gameData.screenList, "screenList.json" )

--[[if (gameData.saveFile=="homeScreen") then

gameData.homeScreen = gameData.workingScreen
  loadsave.saveTable (gameData.homeScreen, gameData.saveFile..".json" )
  

  elseif (gameData.saveFile=="schoolScreen") then

 gameData.schoolScreen = gameData.workingScreen
    loadsave.saveTable (gameData.schoolScreen, gameData.saveFile..".json" )
     

    elseif (gameData.saveFile=="emergencyScreen") then

 gameData.emergencyScreen = gameData.workingScreen
      loadsave.saveTable (gameData.emergencyScreen, gameData.saveFile..".json" )
       

end ]]--     

end  

--load everything


--print ("from screen list "..gameData.screenList[1][1].image)

print ("sae file is "..gameData.saveFile)




  --[[      if (loadsave.loadTable( "homeScreen.json" ) ~= nil) then
      gameData.homeScreen = loadsave.loadTable( "homeScreen.json"  )
    end


        if (loadsave.loadTable( "schoolScreen.json" ) ~= nil) then
      gameData.schoolScreen = loadsave.loadTable( "schoolScreen.json"  )
    end


        if (loadsave.loadTable( "emergencyScreen.json" ) ~= nil) then
      gameData.emergencyScreen = loadsave.loadTable( "emergencyScreen.json"  )
    end

        if (loadsave.loadTable( gameData.saveFile..".json" ) ~= nil) then
      gameData.workingScreen = loadsave.loadTable( gameData.saveFile..".json"  )

print ("i loaded")
    end]]--

        if (loadsave.loadTable( "screenList.json" ) ~= nil) then
      gameData.screenList = loadsave.loadTable( "screenList.json"  )
      end

      if (loadsave.loadTable( "customImageList.json" ) ~= nil) then
      gameData.customImages = loadsave.loadTable( "customImageList.json")
      end



    gameData.workingScreenNumber=gameData.screenList[gameData.screenIndex]

for icon = 1, #gameData.workingScreenNumber do

iconGroups[icon] = display.newGroup()

end

for screenGridCount = 1, 3 do

screenGrid[screenGridCount] = display.newGroup()

end

for topicon = 1, #gameData.workingScreenNumber do

topIcons[topicon] = display.newGroup()

end  

wordSpelling = gameData.collectedWords
collectedLetters = gameData.collectedLetters

for t = 1, #wordSpelling do
table.insert( collectedImages, t, wordSpelling[t]..".png" )

end


local gridsNeeded = math.ceil(#gameData.workingScreenNumber/iconMax)

if (gridsNeeded>1) then

for grids = 2, gridsNeeded do

gridX[grids] = (grids-1)*(display.contentWidth-15)

print (gridX[grids])

end


  local function rightArrowPress( event )

      local function scrollComplete(obj)

          canPressLeftArrow=true
          leftArrow.alpha=1

        if (gridDisplayed < #gridX) then

          canPressRightArrow=true
          rightArrow.alpha=1


        else

          canPressRightArrow=false
          rightArrow.alpha=0.3



        end


      gameData.screenGridPositions[gameData.screenIndex] = gridDisplayed
      loadsave.saveTable (gameData.screenGridPositions, "screenGridPositions.json" )

     end 

  if ( event.phase == "began" ) then

      if (canPressRightArrow) then

      canPressRightArrow=false

      gridDisplayed=gridDisplayed+1
  
     --screenGrid[2].x =-520

     for i = 1, #screenGrid do

     transition.to( screenGrid[i], { time=400, x=screenGrid[i].x-465, y=screenGrid[i].y, onComplete=scrollComplete } )
   end

    end

  end

end

  local function leftArrowPress( event )

      local function scrollComplete(obj)

          canPressRightArrow=true
          rightArrow.alpha=1

        if (gridDisplayed>1) then

          canPressLeftArrow=true
          leftArrow.alpha=1

        else

          canPressLeftArrow=false
          leftArrow.alpha=0.3

        end

      gameData.screenGridPositions[gameData.screenIndex] = gridDisplayed
      loadsave.saveTable (gameData.screenGridPositions, "screenGridPositions.json" )

     end 

    if ( event.phase == "began" ) then

if (canPressLeftArrow) then

  canPressLeftArrow=false

gridDisplayed=gridDisplayed-1

    
     for i = 1, #screenGrid do

     transition.to( screenGrid[i], { time=400, x=screenGrid[i].x+465, y=screenGrid[i].y,  onComplete=scrollComplete } )
   end


    end

  end

end


local arrowWidth=30
local arrowHeight=arrowWidth*3.566

rightArrow = display.newImageRect( "rightArrow.png",arrowWidth,arrowHeight)
imageGroup:insert(rightArrow)
rightArrow.x=400
rightArrow.y=200
rightArrow:addEventListener( "touch", rightArrowPress )

leftArrow = display.newImageRect( "leftArrow.png",arrowWidth,arrowHeight)
imageGroup:insert(leftArrow)
leftArrow.x=20
leftArrow.y=200
leftArrow.alpha=0.3
leftArrow:addEventListener( "touch", leftArrowPress )
canPressLeftArrow=false

end

local function checkWordMade()


--print ("word neeed is "..wordNeeded)

local match = true

local placedLength = #letterPlaced
--print ("pl " .. placedLength)

--for j= 1, placedLength do

--print (letterPlaced[j])

 -- end

for i = 1, wordLength do

if (wordNeeded:sub(i,i)==letterPlaced[i]) then
--match=true
else
match=false
end

end

print ("Your Answer is ")
print (match)

if (match==true) then
  local correctWordAudio = audio.loadSound( wordNeeded..".m4a" )
  local wordPlay = audio.play( correctWordAudio )
end

end

local function hasCollidedCards( obj1, obj2, index1, index2)

print (obj1)
print (obj2)

    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end
 
 local actualBox1X, actualBox1Y = obj1:localToContent( 0,0 )
  local actualBox2X, actualBox2Y = obj2:localToContent( 0,0 )

    local dx = actualBox1X - actualBox2X
    local dy = actualBox1Y - actualBox2Y
 
    local distance = math.sqrt( dx*dx + dy*dy )
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)
 
    if ( distance < objectSize ) then
        return true
    end
    return false
end

local function hasCollidedCircle( obj1, obj2, myIndex )

    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end
 
 local actualBoxX, actualBoxY = letterBoxes[myIndex]:localToContent( 0,0 )
--print( actualBoxX, actualBoxY )
    local dx = actualBoxX - obj2.x
    local dy = actualBoxY - obj2.y
 
    local distance = math.sqrt( dx*dx + dy*dy )
    local objectSize = (obj2.contentWidth/2) + (obj1.contentWidth/2)
 
    if ( distance < objectSize ) then
        return true
    end
    return false
end


local function checkAllCollisions(movedLetter)

  if (canCollide) then

local boxIndex = movedLetter.myIndex
local noSwap = false

print ("size ")
print (boxIndex)
for collOther = 1, #letterBoxes do


 if (hasCollidedCards(letterBoxes[boxIndex], letterBoxes[collOther], boxIndex, collOther)) then


if (movedLetter ~= iconGroups[collOther]) then

  local firstX = collRect[iconGroups[collOther].currentIndex].x - collRect[movedLetter.myIndex].x 
  local firstY = collRect[iconGroups[collOther].currentIndex].y - collRect[movedLetter.myIndex].y 
  local firstIndex = iconGroups[collOther].currentIndex

  local secondX = collRect[movedLetter.currentIndex].x - collRect[iconGroups[collOther].myIndex].x
  local secondY = collRect[movedLetter.currentIndex].y - collRect[iconGroups[collOther].myIndex].y
  local secondIndex = movedLetter.currentIndex

  movedLetter.x = firstX
  movedLetter.y = firstY
  movedLetter.currentIndex = firstIndex

  iconGroups[collOther].x = secondX
  iconGroups[collOther].y = secondY
  iconGroups[collOther].currentIndex = secondIndex


  gameData.workingScreenNumber[movedLetter.tablePos].ind = movedLetter.currentIndex
  gameData.workingScreenNumber[iconGroups[collOther].tablePos].ind = iconGroups[collOther].currentIndex

--print ("orog ind ".. gameData.homeScreen[movedLetter.tablePos].ind)
--print ("touch ind ".. gameData.homeScreen[iconGroups[collOther].tablePos].ind)
--loadsave.saveTable (gameData.workingScreen, gameData.saveFile..".json" )

loadsave.saveTable (gameData.screenList, "screenList.json" )

SaveToTable()

print ("SAVED SAVED")


  noSwap = true

end

 end


end

if (noSwap==false) then

for coll = 1, #gameData.workingScreenNumber do

 if (hasCollidedCircle(movedLetter, collRect[coll], boxIndex)) then
print ("coolided")

  --movedLetter:insert(collRect[coll])
local actualBoxX, actualBoxY = collRect[coll]:localToContent( 0,0 )
--print (actualBoxX)

-- destroy and make new one in place
-- track starter pos and hard code each collRect[coll] pos for each block????

local newX =  collRect[coll].x - collRect[movedLetter.myIndex].x 
local newY = collRect[coll].y - collRect[movedLetter.myIndex].y

--local newX = math.sqrt((movedLetter.startMoveX-collRect[coll].x)^2)



movedLetter.x =  newX
movedLetter.y = newY

gameData.workingScreenNumber[movedLetter.tablePos].ind = coll
movedLetter.currentIndex = coll
--print ("new in "..gameData.homeScreen[movedLetter.tablePos].ind )

--loadsave.saveTable (gameData.workingScreen, gameData.saveFile..".json" )

SaveToTable()

print ("SAVED SAVED")


  end

end



end

--check coll with other letter first

end


end





 --[[
          scrollView:scrollToPosition
{
    x = startScroll - ((topIconIndex-1)*60),

    time = 200
}
]]--


 






    local function editTouch( event )

     if(event.phase == "began") then

      gameData.indexEdit = event.target.index

      --print(gameData.indexEdit)


      insertToScene(sceneGroup)

      local options =
{
    isModal = true,
    effect = "crossFade",
    time = 400,

}

composer.showOverlay( "iconFill", options )


      end

      return true

    end


local function movePlatform(event)
local platformTouched = event.target
local platformDockX = platformTouched.dockX
local platformDockY = platformTouched.dockY


   
        if (event.phase == "began") then
                display.getCurrentStage():setFocus( platformTouched )
 
   -- here the first position is stored in x and y         
                platformTouched.startMoveX = platformTouched.x
                platformTouched.startMoveY = platformTouched.y
 
                platformTouched:toFront( )
             
        elseif (event.phase == "moved") then

          if (platformTouched.startMoveX~=nil) then
                
                -- here the distance is calculated between the start of the movement and its current position of the drag  
                platformTouched.x = (event.x - event.xStart) + platformTouched.startMoveX
                platformTouched.y = (event.y - event.yStart) + platformTouched.startMoveY

              end

 --local actualBoxX, actualBoxY = platformTouched:localToContent( 0,0 )


                elseif event.phase == "ended" or event.phase == "cancelled"  then
             
              -- here the focus is removed from the last position
                    display.getCurrentStage():setFocus( nil )

                    checkAllCollisions(platformTouched)
                       
                end
                 return true
        end


 local function letterBoxSetup(theWord)
 -- local startX = display.contentCenterX - (wordLength/2 * 70)

--print ("the word"..theWord)

wordNeeded=theWord

 local startX = -15
 local startY = 150

local loop =-10;

-- outer for loop to set up grid screens
for gridSetup = 1 , math.ceil(#gameData.workingScreenNumber/iconMax) do
  print("rounded to set a"..gridSetup)

  startX = (-15)+(gridX[gridSetup])
  startY = 150 

  loop=loop+10

  print('loop start x '..startX)


    for grid = 1+loop, iconMax+loop do

         gridBoxes[grid] = display.newImageRect( "blankSlate.png",80*iconScale,80*iconScale)
         

    if (grid==rowCount+loop) then
        startY = 240
        startX = (-15+95*iconScale)+(gridX[gridSetup])
        --startX = -15+95*iconScale
      else
        startX=startX+(95*iconScale)


      end

        gridBoxes[grid].x = startX
        gridBoxes[grid].y = startY

        print ('adds startx '..startX)

        screenGrid[gridSetup]:insert(gridBoxes[grid])

        collRect[grid] = display.newRect( imageGroup, startX, startY , 10, 10 )
        collRect[grid]:setFillColor( 1,1,1 )
        collRect[grid].alpha=0

  
        screenGrid[gridSetup]:insert(collRect[grid])

    end  

imageGroup:insert(screenGrid[gridSetup])



end

   startX = -15
  startY = 150  

loop=-10

for gridSetup = 1 , math.ceil(#gameData.workingScreenNumber/iconMax) do
  print("rounded to set b"..gridSetup) 

  startX = (-15)+(gridX[gridSetup])
  startY = 150 

  loop=loop+10 

for i = 1+loop, iconMax+loop do

local indexRequired = 1
local skip = true


for ind = 1+loop, iconMax+loop do

  if (i == gameData.workingScreenNumber[ind].ind) then
    indexRequired = ind
    skip = false
  end
end

 



 if (skip==true) then
if (i==rowCount+loop) then
    startY = 240

    startX = (-15+95*iconScale)+(gridX[gridSetup])
  else
    startX=startX+95*iconScale
  end
 end

 if (skip==false) then

  --print (gameData.workingScreen[indexRequired].ind.."  ".. gameData.workingScreen[indexRequired].text)



  letterBoxes[i] = display.newImageRect( "blankIcon.png", 80*iconScale, 80*iconScale)
  local iconImage = display.newImageRect( "pecs/"..gameData.workingScreenNumber[indexRequired].image..".png", 40*iconScale,40*iconScale)
  if (iconImage==nil) then
    iconImage = display.newImageRect(gameData.workingScreenNumber[indexRequired].image,system.DocumentsDirectory,40*iconScale,40*iconScale)
  end 


  local iconText = display.newText( gameData.workingScreenNumber[indexRequired].text, 100*iconScale, 200*iconScale, native.systemFont, 14*iconScale )
  iconText:setFillColor( 0, 0, 0 )
  local editIndex = #editBtn
  if (editIndex==nil) then
    editIndex=0
  end  
  editBtn[editIndex+1] = display.newImage( "pencil.png")
  editBtn[editIndex+1].index = indexRequired
  editBtn[editIndex+1]:scale( 1*iconScale, 1*iconScale )
  editBtn[editIndex+1]:addEventListener( "touch", editTouch )
--print ("ed "..editIndex)
  

  iconGroups[i]:insert(letterBoxes[i],true)
  iconGroups[i]:insert(iconImage)
  iconGroups[i]:insert(iconText)
  iconGroups[i]:insert(editBtn[editIndex+1], true)



  iconGroups[i].myIndex = i
  iconGroups[i].currentIndex = i
  iconGroups[i].myAudio = gameData.workingScreenNumber[indexRequired].audio

  iconGroups[i].tablePos = indexRequired
 

if (i==rowCount+loop) then
    startY = 240
    startX = (-15+95*iconScale)+(gridX[gridSetup])
  else
    startX=startX+95*iconScale

  end

    letterBoxes[i].x = startX
    letterBoxes[i].y = startY
    letterBoxes[i].startPosX = startX
    letterBoxes[i].startPosY = startY

    editBtn[editIndex+1].x = startX + 30*iconScale
    editBtn[editIndex+1].y = startY -30*iconScale

    iconImage.x = startX
    iconImage.y = startY - 20*iconScale

    iconText.x = startX
    iconText.y = startY + 20*iconScale

    iconGroups[i].startX = iconGroups[i].x+10*iconScale

    screenGrid[gridSetup]:insert(iconGroups[i])

    imageGroup:insert(screenGrid[gridSetup])

    --imageGroup:insert(iconGroups[i])

if (iconGroups[i].myAudio ~="") then
iconGroups[i]:addEventListener("touch", movePlatform)
end


   -- if (gameData.homeScreen[indexRequired].image=="non") then
 -- iconGroups[i].isVisible=false
--end 

  end
end




end



end





--

local function previousScreen( event )
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



local function onImageTouch( event )
    if ( event.phase == "began" ) then
        --print( "Touch event began on: " .. event.target.id )

        local theIndex = table.indexOf( collectedImages, event.target.id )


        if (wordSpelling[theIndex] ~= mainImageBox.myContent) then

         for b = 1, #bottomLetters do
          bottomLetters[b].x = bottomLetters[b].dockX
          bottomLetters[b].y = bottomLetters[b].dockY
         end

        mainImageBox:removeSelf()
        mainImageBox = nil
        mainImageBox = display.newImage (event.target.id)
        mainImageBox.x = 60
        mainImageBox.y = display.contentCenterY-10


        

        --print (wordSpelling[theIndex])

        wordLength = string.len( wordSpelling[theIndex] )
        letterBoxSetup(wordSpelling[theIndex])

        mainImageBox.myContent = wordSpelling[theIndex]

      end


    elseif ( event.phase == "ended" ) then
       -- print( "Touch event ended on: " .. event.target.id )
    end
    return true
end

 function scene:resetTopBar()

insertToScene(sceneGroup)
 end 

 function scene:updateBoxes()
--print ("resume"..gameData.homeScreen[gameData.indexEdit].text)

canCollide=false

for i=1, #gridBoxes do


        if (gridBoxes[i] ~= nil) then
            gridBoxes[i]:removeSelf()
            gridBoxes[i]=nil
            collRect[i]:removeSelf( )
            collRect[i]=nil
        end
end  

for j=1, #iconGroups do

        if (iconGroups[j] ~= nil) then
            iconGroups[j]:removeSelf()
            iconGroups[j]=nil
        end  
end

for icon = 1, #gameData.workingScreenNumber do

iconGroups[icon] = display.newGroup()

end

wordSpelling = gameData.collectedWords
collectedLetters = gameData.collectedLetters

for t = 1, #wordSpelling do
table.insert( collectedImages, t, wordSpelling[t]..".png" )

end

insertToScene(sceneGroup)

composer.removeScene("number")
composer.gotoScene("number")

  


end  

 

letterBoxSetup()

local function makeNewIcon( event )
      if ( event.phase == "began" ) then



      end


end

local function enterEditMode( )

    if (loadsave.loadTable( gameData.saveFile..".json"  ) ~= nil) then
      gameData.workingScreenNumber = loadsave.loadTable( gameData.saveFile..".json"  )
    end

if (inEditMode==false) then

  inEditMode=true
--print  ("tix ed "..topIconIndex)

--remove any icons from top row 




---

for c=1, #collRect do

collRect[c]:removeEventListener ("touch", makeNewIcon)

end  


  for i=1, #editBtn do

    editBtn[i].isVisible=false
  end  

  for d=1, #iconGroups do

if (gameData.workingScreenNumber[d].image=="non") then
  --print ("to ind "..gameData.workingScreen[d].ind)
  --print ("to hide "..gameData.workingScreen[d].image)

  -- d does not match position of gameData !!! change

  for hide=1, #iconGroups do

    local indexRequired = gameData.workingScreenNumber[d].ind

    if (iconGroups[hide].currentIndex == indexRequired) then

       iconGroups[hide].isVisible=false

    end  

  end  

 
end 

end 

  for j=1 , #gameData.workingScreenNumber do

    if (iconGroups[j] ~= nil) then
      iconGroups[j]:removeEventListener("touch", movePlatform)

 
      iconGroups[j]:addEventListener("touch", buildSentence)

    
    end  

  end  

else

  inEditMode = false


  local itemCount = topIconIndex
--print  ("tix "..topIconIndex)

for topRow = 1, itemCount do

--print ("top row"..topRow)

    if (topIconIndex >1) then

      topIconIndex = topIconIndex-1

      topIcons[topIconIndex]:removeSelf()
      topIcons[topIconIndex] = nil

      topIcons[topIconIndex] = display.newGroup()


      table.remove( sentenceBuilder, topIconIndex )

    end
end


for c=1, #collRect do

collRect[c]:addEventListener ("touch", makeNewIcon)

end 


for d=1, #iconGroups do

if (gameData.workingScreenNumber[d].image=="non") then
    for hide=1, #iconGroups do

    local indexRequired = gameData.workingScreenNumber[d].ind

    if (iconGroups[hide].currentIndex == indexRequired) then

       iconGroups[hide].isVisible=true

    end  

  end 
end 

end  


  for i=1, #editBtn do
    print("vis")
    editBtn[i].isVisible=true
  end 

    for j=1 , #gameData.workingScreenNumber do

    if (iconGroups[j] ~= nil) then

      iconGroups[j]:removeEventListener("touch", buildSentence)

      print ("ig aud "..iconGroups[j].myAudio)

      if (iconGroups[j].myAudio ~="") then
      iconGroups[j]:addEventListener("touch", movePlatform)
    end

    end  

  end 

end  
end

local pressTimer
local pressRuntimer
local canFire=false

local function longPressUpdate()

  local timeHeld = os.time() - pressTimer
  if (timeHeld >= 2 and canFire) then
    canFire=false
  print("Held for 2 sec or longer, do something")
  enterEditMode()
   end 

end  

    
    local function handleButtonEvent( event )
        local phase = event.phase
        if "began" == phase then
             pressTimer = os.time()
             canFire=true
             pressRuntimer = timer.performWithDelay(1, longPressUpdate, -1)
        elseif "ended" == phase then
             local timeHeld = os.time() - pressTimer
             if timeHeld >= 2 then
                timer.cancel(pressRuntimer)
             else
                  print("Held short, do something")
                  timer.cancel(pressRuntimer)
             end
        end
    end

--[[local editBtn = display.newImageRect("editBtn.png", 45,45)
editBtn.x=display.contentWidth-40
editBtn.y=210
imageGroup:insert(editBtn)

editBtn:addEventListener("touch", handleButtonEvent)--]]


local homeWidth = 55
local homeHeight = homeWidth * 1.32


local previousBtn = display.newImageRect("homeBtn.png", homeWidth,homeHeight)
previousBtn.x=display.contentWidth-35
previousBtn.y=240
imageGroup:insert(previousBtn)

previousBtn:addEventListener("touch", previousScreen)

if (gameData.enterEditMode==true) then
  enterEditMode()
end  

if (gameData.screenGridPositions [gameData.screenIndex]>1) then

  for setUp=1, #screenGrid do

  print (' i moved by '..gameData.screenGridPositions [gameData.screenIndex])

  screenGrid[setUp].x = screenGrid[setUp].x-(465* (gameData.screenGridPositions [gameData.screenIndex]-1) )

  end
end  


local gridsNeeded = math.ceil(#gameData.workingScreenNumber/iconMax)

if (gridsNeeded>1) then

gridDisplayed = gameData.screenGridPositions[gameData.screenIndex]

        if (gridDisplayed < #gridX) then

          canPressRightArrow=true
          rightArrow.alpha=1


        else

          canPressRightArrow=false
          rightArrow.alpha=0.3

        end

        if (gridDisplayed>1) then

          canPressLeftArrow=true
          leftArrow.alpha=1

        else

          canPressLeftArrow=false
          leftArrow.alpha=0.3

        end

end

sceneGroup:insert(imageGroup)
--sceneGroup:insert(editBtn)



end

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

         composer.removeScene( "mainMenu")
         canCollide=true
 
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