# Changelog

## 1.1.9

- Added current-value marker in the right-click max displayed player menu.
- Current option now displays as `> number <`.
- Reads current value with `api.Option:GetCustomCloneModelCountSetting()`.
- Falls back to saved addon value if needed.

## 1.1.8

- Added the banner image to the top of the release notes.
- Kept README banner at the top.
- No addon behavior changes.

## 1.1.7

- Right-click max displayed player menu now only opens when default appearances are ON.
- When default appearances are OFF, right-click does not show a menu.
- Tooltip only mentions right-click player count while default appearances are ON.
- Removed the failed OFF-mode player-count workaround.
- Kept 50, 80, 100, 150, and 200 options while default appearances are ON.

## 1.1.6

- Tried to fix displayed-player selection while default appearances are OFF.
- For OFF mode values 50/80/100, the addon briefly enabled default appearances internally, applied the value, then restored OFF.
- The selected value was applied immediately and again after short delays.
- 150 and 200 remained hidden unless default appearances were ON.

## 1.1.5

- Displayed-player selection writes both the option setting and `e_custom_max_model`.
- The selected displayed-player value is applied immediately and once again after a short delay.
- Added safer per-button binding for right-click options.
- Kept the one-based mapping:
  - 50 = 1
  - 80 = 2
  - 100 = 3
  - 150 = 4
  - 200 = 5

## 1.1.4

- Fixed displayed-player mapping after testing showed the previous values were one step too low.
- 50 now uses internal value 1.
- 80 now uses internal value 2.
- 100 now uses internal value 3.
- 150 now uses internal value 4.
- 200 now uses internal value 5.
- Right-click menu still only shows values allowed by the current default appearance state.

## 1.1.3

- Fixed displayed-player option mapping to zero-based slider values.
- 50 used internal value 0.
- 80 used internal value 1.
- 100 used internal value 2.
- 150 used internal value 3.
- 200 used internal value 4.
- Right-click menu only showed values allowed by the current default appearance state.

## 1.1.2

- Added chat feedback when toggling default appearances ON/OFF.
- Added chat feedback when selecting max displayed players.
- Chat message format:
  - `Default Appearances: ON`
  - `Default Appearances: OFF`
  - `Max Players Displayed: number`
- Kept the right-click displayed-player menu stacked above the button.

## 1.1.1

- Stacked displayed-player options vertically above the main button.
- Matched the options menu width to the main button width.
- Made the hover tooltip slimmer and closer to the button.
- Removed addon name from the tooltip.
- Removed individual option-button tooltips.
- Kept right-click displayed-player options.

## 1.1.0

- Added experimental right-click displayed-player options.
- Added options for 50, 80, 100, 150, and 200 displayed players.
- Kept left-click as default appearance toggle.
- Kept Shift + drag movement and saved position.

## 1.0.10

- Moved the button hover tooltip above the button so it remains visible near the bottom of the screen.
- Kept the addon limited to default appearance setting calls only.
- No player-count or model-count settings are changed.

## 1.0.9

- Shortened the addon description to avoid clipping in addon manager windows.
- Description is now: `Easy toggle on and off for default appearances.`
- Kept the addon limited to default appearance setting calls only.
- No player-count or model-count settings are changed.

## 1.0.8

- Added Shift + drag movement support for the button.
- Button position is saved.
- Kept the addon lightweight and limited to default appearance setting calls only.
- No player-count or model-count settings are changed.

## 1.0.7

- Cleaned up the toggle logic.
- Removed leftover probe and fallback calls from earlier testing.
- Uses the direct API calls:
  - `api.Option:GetCustomCloneModeSetting()`
  - `api.Option:SetCustomCloneModeSetting(value)`
- Button text now reads from the actual current default appearance setting.
- No intended visual or behavior change for normal users.

## 1.0.6

- Renamed the addon to `DefaultAppearances`.
- Updated addon metadata, README, release notes, banner, and icon naming.
- Kept the addon focused on toggling default player appearances.
- Button styling and placement kept from the Unsafe Portals-inspired layout.

## 1.0.5

- Initial public release.
- Added one-button toggle for default appearances.
- Added addon metadata and description.
- Confirmed the ON state uses the default appearance display setting.
- Removed player-count wording and old test values from addon files.
