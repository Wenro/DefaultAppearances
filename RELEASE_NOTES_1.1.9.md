![DefaultAppearances Banner](banner.png)

# DefaultAppearances 1.1.9 Release Notes

## Summary

Version 1.1.9 adds a current-value marker to the right-click max displayed player menu.

## Changes

- Current max displayed player option is marked with angle brackets:
  - `> 100 <`
- Uses `api.Option:GetCustomCloneModelCountSetting()` to read the current ON-mode value.
- Falls back to the last saved addon value if the getter does not return a value.
- Right-click player-count menu still only opens when default appearances are ON.
- No behavior change to the left-click default appearance toggle.

## Notes

This avoids special symbols/checkmarks and should be safer for the game UI text renderer.
