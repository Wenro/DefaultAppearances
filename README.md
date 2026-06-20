# DefaultAppearances

Easy toggle on and off for default appearances.

Button looks and placement comes from Unsafe Portals by Notuli.

## What it does

DefaultAppearances adds a small movable button that toggles the default player appearance setting on and off.

It only uses these default appearance API calls:

- `api.Option:GetCustomCloneModeSetting()`
- `api.Option:SetCustomCloneModeSetting(value)`

It does not change displayed-player count or model-count settings.

## Usage

Click the button to toggle default appearances.

Shift + drag the button to move it. The position is saved.

The button text updates based on the current setting:

- `Default Appearances ON`
- `Default Appearances OFF`

## Version

1.0.8

## Author

Dope
