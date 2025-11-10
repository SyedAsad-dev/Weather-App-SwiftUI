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
- Git Flow Branch Strategy.

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
<img src="https://github.com/user-attachments/assets/8e3b0bc3-2dc7-4c9b-b9a8-2399fb589db8" width="512" height="664">
</p>

## Test Cases

<p align="center"> 
<img src="https://github.com/user-attachments/assets/3b605a16-51f6-47ea-bcee-a8a74be6d7ef" width="900" height="1434">
</p>

## Performance Chat

<p align="center"> 
<img src="https://github.com/user-attachments/assets/4c47a4c1-7c74-48b7-aef4-f553954f8e4c" width="2550" height="460">
</p>

## Devices supports:

### iPhone 16 Pro Max
<p align="center"> 
<img src="https://github.com/user-attachments/assets/53e14375-9511-46e3-9b51-7eb815f23032" width="250" height="500">

<img src="https://github.com/user-attachments/assets/4ab377b2-536c-4552-9d6b-29c17b829900" width="250" height="500">

<img src="https://github.com/user-attachments/assets/8d38d1b6-1dfb-4319-9d02-6af79ad0b4a3" width="250" height="500">
</p>

### iPad Pro 13-inch (M4)
<p align="center"> 
<img src="https://github.com/user-attachments/assets/2b3f78d2-ee69-4486-80a6-6ea95ce2755e" width="350" height="560">
</p>

