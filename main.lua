local api = require("api")

local default_appearances_addon = {
    name = "DefaultAppearances",
    author = "Dope",
    version = "1.0.8",
    desc = "Easy toggle on and off for default appearances. Button looks and placement comes from Unsafe Portals by Notuli."
}

local SETTINGS_KEY = "default_appearances"

local settings = nil
local defaultAppearancesWindow = nil
local defaultAppearancesBtn = nil

local BUTTON_W = 194
local BUTTON_H = 28
local DEFAULT_X = 132
local DEFAULT_Y = -30

local function saveSettings()
    api.SaveSettings(SETTINGS_KEY, settings)
end

local function updateButtonText()
    if defaultAppearancesBtn == nil then
        return
    end

    if api.Option:GetCustomCloneModeSetting() ~= 0 then
        defaultAppearancesBtn:SetText("Default Appearances ON")
    else
        defaultAppearancesBtn:SetText("Default Appearances OFF")
    end
end

local function toggleDefaultAppearance()
    if api.Option:GetCustomCloneModeSetting() ~= 0 then
        api.Option:SetCustomCloneModeSetting(0)
    else
        api.Option:SetCustomCloneModeSetting(1)
    end

    updateButtonText()
end

local function startMovingButton()
    if defaultAppearancesWindow == nil then
        return
    end

    if api.Input:IsShiftKeyDown() then
        defaultAppearancesWindow:StartMoving()
        api.Cursor:ClearCursor()
        api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
    end
end

local function stopMovingButton()
    if defaultAppearancesWindow == nil then
        return
    end

    defaultAppearancesWindow:StopMovingOrSizing()
    api.Cursor:ClearCursor()

    settings.x, settings.y = defaultAppearancesWindow:GetOffset()
    saveSettings()
end

local function createButton()
    defaultAppearancesWindow = api.Interface:CreateEmptyWindow("defaultAppearancesWindow", "UIParent")
    defaultAppearancesWindow:SetExtent(BUTTON_W, BUTTON_H)
    defaultAppearancesWindow:AddAnchor("BOTTOMLEFT", "UIParent", settings.x or DEFAULT_X, settings.y or DEFAULT_Y)
    defaultAppearancesWindow:EnableDrag(true)

    function defaultAppearancesWindow:OnDragStart()
        startMovingButton()
    end
    defaultAppearancesWindow:SetHandler("OnDragStart", defaultAppearancesWindow.OnDragStart)

    function defaultAppearancesWindow:OnDragStop()
        stopMovingButton()
    end
    defaultAppearancesWindow:SetHandler("OnDragStop", defaultAppearancesWindow.OnDragStop)

    defaultAppearancesBtn = defaultAppearancesWindow:CreateChildWidget("button", "defaultAppearancesBtn", 0, true)
    ApplyButtonSkin(defaultAppearancesBtn, BUTTON_BASIC.DEFAULT)
    defaultAppearancesBtn:SetExtent(BUTTON_W, BUTTON_H)
    defaultAppearancesBtn:AddAnchor("TOPLEFT", defaultAppearancesWindow, 0, 0)
    defaultAppearancesBtn:EnableDrag(true)

    function defaultAppearancesBtn:OnClick()
        if api.Input:IsShiftKeyDown() then
            return
        end

        toggleDefaultAppearance()
    end
    defaultAppearancesBtn:SetHandler("OnClick", defaultAppearancesBtn.OnClick)

    function defaultAppearancesBtn:OnDragStart()
        startMovingButton()
    end
    defaultAppearancesBtn:SetHandler("OnDragStart", defaultAppearancesBtn.OnDragStart)

    function defaultAppearancesBtn:OnDragStop()
        stopMovingButton()
    end
    defaultAppearancesBtn:SetHandler("OnDragStop", defaultAppearancesBtn.OnDragStop)

    function defaultAppearancesBtn:OnEnter()
        local posX, posY = self:GetOffset()
        api.Interface:SetTooltipOnPos(
            "DefaultAppearances\n\nClick to toggle default appearances.\nShift + drag to move.",
            defaultAppearancesWindow,
            posX + 50,
            posY + 20
        )
    end
    defaultAppearancesBtn:SetHandler("OnEnter", defaultAppearancesBtn.OnEnter)

    function defaultAppearancesBtn:OnLeave()
        local posX, posY = self:GetOffset()
        api.Interface:SetTooltipOnPos(nil, defaultAppearancesWindow, posX + 50, posY + 20)
    end
    defaultAppearancesBtn:SetHandler("OnLeave", defaultAppearancesBtn.OnLeave)

    updateButtonText()
    defaultAppearancesWindow:Show(true)
end

local function OnLoad()
    settings = api.GetSettings(SETTINGS_KEY)
    if settings == nil then
        settings = {
            x = DEFAULT_X,
            y = DEFAULT_Y
        }
        saveSettings()
    end

    createButton()
end

local function OnUnload()
    if defaultAppearancesWindow ~= nil then
        defaultAppearancesWindow:Show(false)
        defaultAppearancesWindow = nil
        defaultAppearancesBtn = nil
    end
end

default_appearances_addon.OnLoad = OnLoad
default_appearances_addon.OnUnload = OnUnload

return default_appearances_addon
