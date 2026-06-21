local api = require("api")

local default_appearances_addon = {
    name = "DefaultAppearances",
    author = "Dope",
    version = "1.1.8",
    desc = "Easy toggle on and off for default appearances."
}

local settings = nil
local defaultAppearancesWindow = nil
local defaultAppearancesBtn = nil
local modelCountWindow = nil
local modelCountButtons = {}

local SETTINGS_KEY = "default_appearances"
local BUTTON_W = 194
local BUTTON_H = 28
local DEFAULT_X = 132
local DEFAULT_Y = -30
local MODEL_WINDOW_W = BUTTON_W
local MODEL_BUTTON_H = 24
local MODEL_BUTTON_GAP = 3
local MODEL_PADDING = 8
local MENU_GAP = 4

-- The client uses one-based slider values for Max Players Displayed.
-- This only applies while Default Appearances are ON.
-- 50 = 1, 80 = 2, 100 = 3, 150 = 4, 200 = 5
local MODEL_COUNT_OPTIONS = {
    { label = "50", value = 1 },
    { label = "80", value = 2 },
    { label = "100", value = 3 },
    { label = "150", value = 4 },
    { label = "200", value = 5 }
}

local destroyModelCountWindow

local function logMessage(message)
    if api ~= nil and api.Log ~= nil and api.Log.Info ~= nil then
        api.Log:Info("[DefaultAppearances] " .. tostring(message))
    end
end

local function saveSettings()
    api.SaveSettings(SETTINGS_KEY, settings)
end

local function isDefaultAppearanceOn()
    return api.Option:GetCustomCloneModeSetting() ~= 0
end

local function updateButtonText()
    if defaultAppearancesBtn == nil then
        return
    end

    if isDefaultAppearanceOn() then
        defaultAppearancesBtn:SetText("Default Appearances ON")
    else
        defaultAppearancesBtn:SetText("Default Appearances OFF")
    end
end

local function setMaxPlayersDisplayed(value)
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

destroyModelCountWindow = function()
    if modelCountWindow ~= nil then
        modelCountWindow:Show(false)
        modelCountWindow = nil
        modelCountButtons = {}
    end
end

local function toggleDefaultAppearance()
    if isDefaultAppearanceOn() then
        api.Option:SetCustomCloneModeSetting(0)
        logMessage("Default Appearances: OFF")
    else
        api.Option:SetCustomCloneModeSetting(1)
        logMessage("Default Appearances: ON")
    end

    updateButtonText()
    destroyModelCountWindow()
end

local function setModelCount(option)
    if not isDefaultAppearanceOn() then
        destroyModelCountWindow()
        return
    end

    setMaxPlayersDisplayed(option.value)

    if api ~= nil and api.DoIn ~= nil then
        api:DoIn(100, function()
            setMaxPlayersDisplayed(option.value)
        end)
    end

    settings.modelCountLabel = option.label
    settings.modelCountValue = option.value
    saveSettings()

    logMessage("Max Players Displayed: " .. option.label)

    destroyModelCountWindow()
end

local function createModelCountWindow()
    destroyModelCountWindow()

    if not isDefaultAppearanceOn() then
        return
    end

    local modelWindowH = (MODEL_PADDING * 2) + (#MODEL_COUNT_OPTIONS * MODEL_BUTTON_H) + ((#MODEL_COUNT_OPTIONS - 1) * MODEL_BUTTON_GAP)

    modelCountWindow = api.Interface:CreateEmptyWindow("defaultAppearancesModelCountWindow", "UIParent")
    modelCountWindow:SetExtent(MODEL_WINDOW_W, modelWindowH)
    modelCountWindow:AddAnchor(
        "BOTTOMLEFT",
        "UIParent",
        settings.x or DEFAULT_X,
        (settings.y or DEFAULT_Y) + BUTTON_H + MENU_GAP
    )

    if modelCountWindow.CreateNinePartDrawable ~= nil then
        modelCountWindow.background = modelCountWindow:CreateNinePartDrawable(TEXTURE_PATH.HUD, "background")
        modelCountWindow.background:SetTextureInfo("bg_quest")
        modelCountWindow.background:SetColor(0, 0, 0, 0.65)
        modelCountWindow.background:AddAnchor("TOPLEFT", modelCountWindow, 0, 0)
        modelCountWindow.background:AddAnchor("BOTTOMRIGHT", modelCountWindow, 0, 0)
    end

    local buttonW = MODEL_WINDOW_W - (MODEL_PADDING * 2)

    for i, option in ipairs(MODEL_COUNT_OPTIONS) do
        local selectedOption = option

        local btn = modelCountWindow:CreateChildWidget("button", "defaultAppearancesModelCount" .. selectedOption.label, 0, true)
        ApplyButtonSkin(btn, BUTTON_BASIC.DEFAULT)
        btn:SetExtent(buttonW, MODEL_BUTTON_H)
        btn:AddAnchor(
            "TOPLEFT",
            modelCountWindow,
            MODEL_PADDING,
            MODEL_PADDING + ((i - 1) * (MODEL_BUTTON_H + MODEL_BUTTON_GAP))
        )
        btn:SetText(selectedOption.label)

        function btn:OnClick()
            setModelCount(selectedOption)
        end
        btn:SetHandler("OnClick", btn.OnClick)

        table.insert(modelCountButtons, btn)
    end
end

local function toggleModelCountWindow()
    if not isDefaultAppearanceOn() then
        destroyModelCountWindow()
        return
    end

    if modelCountWindow ~= nil then
        modelCountWindow:Show(not modelCountWindow:IsVisible())
        return
    end

    createModelCountWindow()

    if modelCountWindow ~= nil then
        modelCountWindow:Show(true)
    end
end

local function savePosition()
    if defaultAppearancesWindow == nil then
        return
    end

    settings.x, settings.y = defaultAppearancesWindow:GetOffset()
    saveSettings()

    destroyModelCountWindow()
end

local function startMovingButton()
    if defaultAppearancesWindow == nil or not api.Input:IsShiftKeyDown() then
        return
    end

    defaultAppearancesWindow:StartMoving()
    api.Cursor:ClearCursor()
    api.Cursor:SetCursorImage(CURSOR_PATH.MOVE, 0, 0)
end

local function stopMovingButton()
    if defaultAppearancesWindow == nil then
        return
    end

    defaultAppearancesWindow:StopMovingOrSizing()
    api.Cursor:ClearCursor()
    savePosition()
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
    defaultAppearancesBtn:RegisterForClicks("RightButton")

    function defaultAppearancesBtn:OnClick(arg)
        if arg == "RightButton" then
            toggleModelCountWindow()
            return
        end

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
        local tooltipText = "Left-click: toggle\nShift + drag: move"

        if isDefaultAppearanceOn() then
            tooltipText = "Left-click: toggle\nRight-click: player count\nShift + drag: move"
        end

        api.Interface:SetTooltipOnPos(
            tooltipText,
            defaultAppearancesWindow,
            posX + 16,
            posY - 44
        )
    end
    defaultAppearancesBtn:SetHandler("OnEnter", defaultAppearancesBtn.OnEnter)

    function defaultAppearancesBtn:OnLeave()
        local posX, posY = self:GetOffset()
        api.Interface:SetTooltipOnPos(nil, defaultAppearancesWindow, posX + 16, posY - 44)
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
            y = DEFAULT_Y,
            modelCountLabel = nil,
            modelCountValue = nil
        }
        saveSettings()
    end

    createButton()
end

local function OnUnload()
    destroyModelCountWindow()

    if defaultAppearancesWindow ~= nil then
        defaultAppearancesWindow:Show(false)
        defaultAppearancesWindow = nil
        defaultAppearancesBtn = nil
    end
end

default_appearances_addon.OnLoad = OnLoad
default_appearances_addon.OnUnload = OnUnload

return default_appearances_addon
