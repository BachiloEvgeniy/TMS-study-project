# Repository Guidelines

## Project Structure & Module Organization

`WeatherApp/` contains the iOS application source. App lifecycle code lives in `AppDelegate.swift` and `SceneDelegate.swift`; application-level navigation belongs in `Application/` (for example, `MainTabBarController.swift`). Feature code is grouped under `Modules/<Feature>/`. Each current feature follows a lightweight MVP split with `ViewController`, `Presenter`, and `Contracts` files, as shown by `Modules/WeatherToday/`. Images, colors, and app icons belong in `Assets.xcassets`. Build settings and file membership are maintained in `WeatherApp.xcodeproj`.

## Build, Test, and Development Commands

- `open WeatherApp.xcodeproj` opens the project for normal development and simulator runs.
- `xcodebuild -project WeatherApp.xcodeproj -scheme WeatherApp -configuration Debug -sdk iphonesimulator build CODE_SIGNING_ALLOWED=NO` performs a command-line simulator build without signing.
- `xcodebuild clean -project WeatherApp.xcodeproj -scheme WeatherApp` removes Xcode build products when diagnosing stale-build issues.
- `xcodebuild test -project WeatherApp.xcodeproj -scheme WeatherApp -destination 'platform=iOS Simulator,name=iPhone 16'` is the expected test command after a test target is added; adjust the device to an installed simulator.

The deployment target is iOS 16.0 and the project uses Swift 5.

## Coding Style & Naming Conventions

Use four-space indentation and standard Swift API naming: types and protocols in `UpperCamelCase`, methods and properties in `lowerCamelCase`. Mark non-inherited classes `final`, keep UI properties `private`, and organize setup into focused methods such as `configureView()` and `configureLayout()`. Build interfaces programmatically with UIKit and Auto Layout to match the existing code. Keep feature protocols and view models in the feature's `Contracts.swift`. No formatter or linter is configured; use Xcode's indentation and resolve compiler warnings before submitting.

## Testing Guidelines

There is no test target yet. Add an XCTest target named `WeatherAppTests` when introducing testable behavior. Mirror source modules in the test directory, name files `<TypeName>Tests.swift`, and use methods such as `testDidTapRefreshDisplaysUpdatedModel()`. Prioritize presenter tests with view spies, then navigation and view-controller integration tests. Run the full suite before opening a pull request.

## Commit & Pull Request Guidelines

History favors short, imperative, scoped commits, commonly using Conventional Commit prefixes such as `feat:`. Prefer messages like `feat: add city search` or `fix: retain selected tab`. Keep commits focused and avoid committing local Xcode user data. Pull requests should explain the behavior change, list validation performed, link the relevant issue or homework task, and include simulator screenshots for visible UI changes.
