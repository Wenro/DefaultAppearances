# DefaultAppearances 1.0.8 Release Notes

## Summary

Version 1.0.8 adds Shift + drag movement support while keeping the addon lightweight and focused only on default appearances.

## Changes

- Added Shift + drag to move the button.
- Button position is saved.
- Kept the addon limited to default appearance API calls only:
  - `api.Option:GetCustomCloneModeSetting()`
  - `api.Option:SetCustomCloneModeSetting(value)`
- No player-count or model-count settings are changed.
- No probe, fallback, or model-count logic is included.

## Notes

This version only toggles default appearances and saves the button position.
