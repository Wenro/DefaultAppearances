# Changelog

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
