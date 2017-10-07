local _widget = require( "widget" )

local M = 
{
    _options = {},
    _widgetName = "widget.newPickerList",
}

local function initPickerList( pickerList, options )
    local opt = options
    
    
    local function onCancel(event)
        pickerList:cancel()  
        return true;
    end
    
        local function onSelect(event)
        pickerList:closeUp()  
        if pickerList._onSelect then
            pickerList._onSelect(event)
        end
        return true;
    end
    
    local function onTouch(event)
        if "began" == event.phase then
            display.getCurrentStage():setFocus(view);
            if pickerList.cancelOnBackgroundClick then
                onCancel(event)
                
            else    
                onSelect(event)
            end
            
        elseif ( "ended" == phase or "off" == phase or "cancelled" == phase )  then
            --release focus
            display.getCurrentStage():setFocus(nil);
            
        end
        return true;
    end
    

    
    local function onScroll(event)
        
        if pickerList._onScroll then
            local values = pickerList.pickerWheel:getValues();
            event.values = values
            pickerList._onScroll(event)
        end
    end
    
    local view = display:newGroup();
    pickerList._view = view;
    view.top = opt.top
    local rect = display.newRect( view, opt.left + opt.width / 2, opt.top + opt.height / 2, opt.width, opt.height);
    rect:setFillColor (unpack(opt.backgroundColor))
    pickerList.editField = opt.editField;
    if pickerList.editField then
        pickerList._initialValue = pickerList.editField:getText();
    end    
    pickerList._onSelect = opt.onSelectData;
    view:insert(rect);
    rect.isHitTestable = true;
    rect:addEventListener("touch", onTouch)   
    
    local toolbar = display.newRect( view, opt.toolbarWidth / 2,opt.top+opt.toolbarTop + opt.toolbarHeight / 2, opt.toolbarWidth, opt.toolbarHeight);
    toolbar:setFillColor (unpack(opt.toolbarColor))
    
    local cancelButton = _widget.newButton(
    {label = opt.cancelLabel,
        x = opt.buttonsMargin + opt.buttonsWidth / 2,
        y = opt.top+opt.toolbarTop + opt.toolbarHeight / 2,
        width = opt.buttonsWidth,
        onRelease = onCancel
    }
    ) 
    view:insert(cancelButton)
    
    local doneButton = _widget.newButton(
    {label = opt.doneLabel,
        x = opt.toolbarWidth - opt.buttonsMargin - opt.buttonsWidth / 2,
        y = opt.top+opt.toolbarTop + opt.toolbarHeight / 2,
        width = opt.buttonsWidth,
        onRelease = onSelect
    }
    ) 
    view:insert(doneButton)
    
    pickerList.pickerWheel = _widget.newPickerWheel
    {
        top = opt.top+opt.height - opt.pickerHeight,
        overlayFrameHeight = opt.pickerHeight,
        rowHeight = opt.pickerRowHeight,
        columns = opt.pickerData,
        columnColor = opt.pickerColumnColor,
        backgroundColor = opt.pickerColumnColor,
        font = opt.pickerFont,
        fontColor = opt.pickerFontColor,
        fontSize = opt.pickerFontSize,
        onScroll = onScroll,
        
    }
    view:insert(pickerList.pickerWheel)

    pickerList._onScroll = opt.onScroll
    pickerList._onClose = opt.onClose
    pickerList.cancelOnBackgroundClick = opt.cancelOnBackgroundClick;
    native.setKeyboardFocus(nil)
    
    
    function pickerList:_finalize()
        
    end
    
    
    function pickerList:closeUp()
        if self._onClose then
            local event = {}
            event.target = self
            self._onClose(event)
        end
        self._view:removeSelf();
        self:removeSelf()
    end
    
    function pickerList:cancel()
        if self.editField then
            self.editField:setText(self._initialValue);
            self.editField.id = self.initialId;
        end    
        self:closeUp()
    end;
end
-- Function to create a new editfield object ( widget.newEditField)
function M.new( options )	
    local customOptions = options or {}
    
    -- Create a local reference to our options table
    local opt = M._options
    -------------------------------------------------------
    -- Properties
    -------------------------------------------------------	
    -- Positioning & properties
    opt.left = customOptions.left or 0
    opt.top = customOptions.top or 0
    opt.x = customOptions.x or nil
    opt.y = customOptions.y or nil
    if customOptions.x and customOptions.y then
        opt.left = 0
        opt.top = 0
    end    
    opt.width = customOptions.width or display.contentWidth
    opt.height = customOptions.height or display.contentHeight
    
    opt.backgroundColor =  customOptions.backgroundColor or {0,0,0,0.5}
    opt.editField = customOptions.editField
    opt.onScroll = customOptions.onScroll
    opt.onClose  = customOptions.onClose
    opt.cancelOnBackgroundClick = customOptions.cancelOnBackgroundClick 
    
    opt.toolbarWidth  = customOptions.toolbarWidth or display.contentWidth
    opt.toolbarHeight = customOptions.toolbarHeight or 50
    opt.toolbarTop = customOptions.toolbarTop or 0
    opt.toolbarColor = customOptions.toolbarColor or {1,1,1,1}
    
    opt.buttonsWidth = customOptions.buttonsWidth or 75
    opt.buttonsMargin = customOptions.buttonsMargin or 10
    opt.cancelLabel = customOptions.cancelLabel or "Cancel"
    opt.doneLabel = customOptions.doneLabel or "Done"
    
    
    opt.pickerHeight = customOptions.pickerHeight or 222
    opt.pickerRowHeight = customOptions.pickerRowHeight or 35
    opt.pickerData = customOptions.pickerData
    opt.pickerColumnColor = customOptions.pickerColumnColor
    opt.pickerFont = customOptions.pickerFont
    opt.pickerFontColor = customOptions.pickerFontColor
    opt.pickerFontSize = customOptions.pickerFontSize
    -- Create the editField object
    local pickerList = _widget._new
    {
        left = opt.left,
        top = opt.top,
        id = opt.id or "widget_pickerList",
        baseDir = opt.baseDir,
    }
    
    
    initPickerList( pickerList, opt )
    
    -- Set the editField's position ( set the reference point to center, just to be sure )
    
    local x, y = opt.x, opt.y
    if not opt.x or not opt.y then
        x = opt.left + pickerList.contentWidth * 0.5
        y = opt.top + pickerList.contentHeight * 0.5
    end
    pickerList.x, pickerList.y = x, y
    
    return pickerList
end

return M

