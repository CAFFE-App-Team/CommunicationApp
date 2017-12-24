local widget = require( "widget" )
local usageData = require ("usageData")
local composer = require( "composer" )
local loadsave = require( "loadsave" ) 
local barScene = require "barScene"
 
-- The "onRowRender" function may go here (see example under "Inserting Rows", above)
 local scene = composer.newScene()

 function scene:create( event )

        local sceneGroup = self.view

barScrollView.alpha=0
readBtn.alpha=0
deleteBtn.alpha=0
topSquare.alpha=0



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

sceneGroup:insert(tableView)

end


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


local dataBtn = display.newImageRect( "settings.png", 25,25)
dataBtn.x=30
dataBtn.y=270

sceneGroup:insert(dataBtn)

dataBtn:addEventListener( "touch", loadDataScreen )


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