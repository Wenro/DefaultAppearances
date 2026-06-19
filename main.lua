local api = require("api")

local default_appearances_addon = {
    name = "DefaultAppearances",
    author = "Dope",
    version = "1.0.6",
    desc = "Easy toggle on and off for default appearances. Button looks and placement comes from Unsafe Portals by Notuli."
}

local defaultAppearancesWindow = nil
local defaultAppearancesBtn = nil
local appearanceEnabled = false

local VALUE_OFF = 2
local VALUE_ON = 3
local BUTTON_W = 194
local BUTTON_H = 28
local BUTTON_X = 132
local BUTTON_Y = -30

local function log(msg)
    if api ~= nil and api.Log ~= nil and api.Log.Info ~= nil then
        api.Log:Info("[DefaultAppearances] " .. tostring(msg))
    end
end

local function setModelLimit(value)
    pcall(function()
        api.Option:SetCustomCloneModelCountSetting(value)
    end)

    pcall(function()
        if ADDON ~= nil and ADDON.ImportAPI ~= nil then
            ADDON:ImportAPI(31)
        end
    end)

    pcall(function()
        if X2Option ~= nil and X2Option.SetConsoleVariable ~= nil then
            X2Option:SetConsoleVariable("e_custom_max_model", tostring(value))
        end
    end)
end

local function setAppearanceCheckbox(on)
    local value = 0
    if on then
        value = 1
    end

    pcall(function() api.Option:SetCustomCloneModeSetting(value) end)
    pcall(function() api.Option:SetUseCustomCloneModeSetting(value) end)
    pcall(function() api.Option:SetDefaultAppearanceSetting(value) end)
    pcall(function() api.Option:SetDefaultAppearancesSetting(value) end)
    pcall(function() api.Option:SetDefaultPlayerAppearanceSetting(value) end)
    pcall(function() api.Option:SetDefaultPlayerAppearancesSetting(value) end)
    pcall(function() api.Option:SetUseDefaultPlayerAppearanceSetting(value) end)

    pcall(function()
        if ADDON ~= nil and ADDON.ImportAPI ~= nil then
            ADDON:ImportAPI(31)
        end
    end)

    pcall(function()
        if X2Option ~= nil and X2Option.SetItemFloatValue ~= nil and OIT_E_CUSTOM_CLONE_MODE ~= nil then
            X2Option:SetItemFloatValue(OIT_E_CUSTOM_CLONE_MODE, value)
        end
    end)
end

local function updateButtonText()
    if defaultAppearancesBtn == nil then
        return
    end

    if appearanceEnabled then
        defaultAppearancesBtn:SetText("Default Appearances ON")
    else
        defaultAppearancesBtn:SetText("Default Appearances OFF")
    end
end

local function applyAppearanceState()
    local value = VALUE_OFF
    if appearanceEnabled then
        value = VALUE_ON
    end

    setAppearanceCheckbox(appearanceEnabled)
    setModelLimit(value)
    updateButtonText()

    if appearanceEnabled then
        log("Default Appearances ON")
    else
        log("Default Appearances OFF")
    end
end

local function createButton()
    defaultAppearancesWindow = api.Interface:CreateEmptyWindow("defaultAppearancesWindow", "UIParent")
    defaultAppearancesWindow:SetExtent(BUTTON_W, BUTTON_H)
    defaultAppearancesWindow:AddAnchor("BOTTOMLEFT", "UIParent", BUTTON_X, BUTTON_Y)

    defaultAppearancesBtn = defaultAppearancesWindow:CreateChildWidget("button", "defaultAppearancesBtn", 0, true)
    ApplyButtonSkin(defaultAppearancesBtn, BUTTON_BASIC.DEFAULT)
    defaultAppearancesBtn:SetExtent(BUTTON_W, BUTTON_H)
    defaultAppearancesBtn:AddAnchor("TOPLEFT", defaultAppearancesWindow, 0, 0)
    updateButtonText()

    function defaultAppearancesBtn:OnClick()
        appearanceEnabled = not appearanceEnabled
        applyAppearanceState()
    end
    defaultAppearancesBtn:SetHandler("OnClick", defaultAppearancesBtn.OnClick)

    defaultAppearancesWindow:Show(true)
end

local function OnLoad()
    createButton()
    log("Loaded")
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
