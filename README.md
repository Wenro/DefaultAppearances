![DefaultAppearances Banner](banner.png)

# DefaultAppearances

Easy toggle on and off for default appearances.

## What it does

DefaultAppearances adds a small movable button that toggles the default player appearance setting on and off.

Left-click toggles default appearances and prints the new state in chat.

Right-click opens max displayed player options only when default appearances are ON.

It uses:

- `api.Option:GetCustomCloneModeSetting()`
- `api.Option:SetCustomCloneModeSetting(value)`
- `api.Option:SetCustomCloneModelCountSetting(value)`
- `X2Option:SetConsoleVariable("e_custom_max_model", value)`

## Max displayed player options

The right-click menu is only available when default appearances are ON.

Available options while ON:

- 50
- 80
- 100
- 150
- 200

When default appearances are OFF, right-click does not open a menu.

## Internal displayed-player mapping

The displayed-player setting uses one-based slider values:

- 50 = 1
- 80 = 2
- 100 = 3
- 150 = 4
- 200 = 5

## Usage

Click the button to toggle default appearances.

Right-click the button to choose max displayed players while default appearances are ON.

Shift + drag the button to move it. The position is saved.

## Version

1.1.8

## Author

Dope
