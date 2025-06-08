# README

This app uses The Composable Architecture (TCA) as the architectural foundation. It ensures predictable, testable, and scalable structure.

## Motivation

TCA’s unidirectional data flow and clear separation of concerns made it easier to manage complex state and logic across the app’s features. By adopting TCA, it is possible to break down the application into small, reusable components that communicate in a consistent and maintainable way. This architecture also allows us to write comprehensive unit tests for each feature, improving code reliability and simplifying future development and debugging. Overall, TCA provided a solid framework for building a modular and robust SwiftUI application.


## Specifications Met

- ✅ Each icon should play a sound and change its image when selected. When deselected, it should stop the sound and revert to its original image. 
- ✅ A global Play/Pause button should play or stop all selected sounds.
- ✅ A Clear button should reset the selection and stop all sounds.
- ✅ The app should save its state, preserving the current sound selection so the user can reopen the app with their last selection intact.
- ✅ The user should be able to play a maximum of three sounds simultaneously. If the user attempts to select more, a warning message should be displayed.
- ✅ Bonus: Animate the icons of playing sounds.


## WARNING

Macro target 'DependenciesMacrosPlugin' must be enabled before building the app.

