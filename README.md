# Weather ForeCast Application
Swift Assessment Test 

## Building And Running The Project (Requirements)
* Swift 5.9
* SwiftUI
* Xcode 16.3
* iOS 17.0
* MacOS Sequoia 15.6.1

# Getting Started
- If this is your first time encountering swift/ios development, please follow [the instructions](https://developer.apple.com/support/xcode/) to setup Xcode and Swift on your Mac.

## ⚙️ Setup Configs
- Checkout **main** branch to run latest version
- Open the project by double clicking the `ForecastDvt.xcodeproj` file
- Select the build scheme which can be found right after the stop button on the top left of the IDE
- [Command(cmd)] + R - Run app
```
// App Settings
APP_NAME = ForecastDvt
PRODUCT_BUNDLE_IDENTIFIER = Dvt.Task.ForecastDvt

#targets:
* ForecastDvt
 * Packages/ForeCast
 * Packages/Favorite
 * Packages/CityMap
```

# Build and or run application by doing:
* Select the build scheme which can be found right after the stop button on the top left of the IDE
* [Command(cmd)] + B - Build app
* [Command(cmd)] + R - Run app

## ✅ Accomplished:
- Mixed(Virtical & Horizontal) Interface Modularization.
- Composite Root technique.
- Reactive Programming technique (Macros).
- SOLID principle.
- Repository & Interface Design pattern.
- Async/Await.
- Sendable, Actor (Thread Safetly).
- MVVM Architecture.
- SwiftData.
- Cashing.
- Unit Tests.
- SwiftLint.

No third party library has benn used.

# 🌦 Weather Forecast App - SOLID MVVM Architecture  

This project follows **SOLID principles** with **MVVM architecture**, including **Use Case, Repository, and Services & Local Storage** for clean and scalable code.

---

## 🏛 Clean Architecture Overview

```plaintext
Presentation Layer
┌───────────────────────────────┐
│          SwiftUI View         │
│  - Displays weather & favorite│
│  - Calls ViewModel methods    │
└─────────────┬─────────────────┘
              │
              ▼
┌───────────────────────────────┐
│      ViewModel (Observable)   │
│  - Holds state & isLoading    │
│  - Calls Use Cases            │
└─────────────┬─────────────────┘

Domain Layer
┌───────────────────────────────┐
│          Use Cases            │
│  - Forecast: Today/Weekly     │
│  - Favorite: Load/Remove      │
│  - Contains business logic    │
└─────────────┬─────────────────┘
              │
              ▼
Data Layer
┌───────────────────────────────┐
│        Repositories           │
│  - ForecastRepository         │
│  - FavoriteRepository         │
│  - Decides HTTP vs LocalData  │
└─────────────┬─────────────────┘
              │
              ▼
┌───────────────────────────────┐
│  Services & Local Storage     │
│  - HTTPClient / API           │
│  - LocationService            │
│  - SwiftData local cache      │
└───────────────────────────────┘
```

## Mixed Modular Architecture
This application uses the Mixed Interface Modular approach.

<p align="center"> <img src="https://miro.medium.com/v2/resize:fit:1400/1*saKX3Dssawi-Z4zT0mNRmQ.png" width="600" height="300">

<img src="https://miro.medium.com/v2/resize:fit:1400/1*lR0AqgxKy5H7bFFQbYQeeA.png" width="600" height="300">
</p>

## 🗂 Structure Overview

### Presentation
- Include Views, ViewModels 

### Domain
- Include Entities, RepositoryProtocols, UseCases, UseCasesProtocols.

### Data
- Include Repositories, Networking(Remote,Local), LocationManager, Models, SwiftData etc.

### Router
- Include Routing and Setup.

### Graph View

<p align="center"> 
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmo0oI5yIKJkk4M8nlseHz1xltdcg7VS4Msg&s" width="250" height="250">
</p>

## 🗂 Structural View

<p align="center"> 
<img src="https://github.com/user-attachments/assets/8ff3e955-738d-440b-bc73-aa3ddb6d8590" width="512" height="664">
</p>

## Test Cases

<p align="center"> 
<img src="https://github.com/user-attachments/assets/5d261a40-9f0c-401c-8be5-dcb037dbae48" width="988" height="1524">
</p>

## Devices supports:

### iPhone 16 Pro Max
<p align="center"> 
<img src="https://github.com/user-attachments/assets/62b8f9c7-a142-492b-a5a8-6295ebec8f1b" width="250" height="500">

<img src="https://github.com/user-attachments/assets/37c9c021-4d8f-434b-b675-4063eb8faa00" width="250" height="500">

<img src="https://github.com/user-attachments/assets/9a4462f6-fff2-4259-a678-d95ebffdd149" width="250" height="500">
</p>

### iPad Pro 13-inch (M4)
<p align="center"> 
<img src="https://github.com/user-attachments/assets/7722b4c7-b853-4d7f-b747-6abd1b9734dd" width="350" height="560">
</p>

