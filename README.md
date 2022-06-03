# JLNavigation

<img alt="JLNavigation Logo" src="" width="500"/> 


JLNavigation is an elegant iOS library which provides routing features to your applications based on the Coordinator pattern. JLNavigation helps make your navigation syntactically compact and clear. 
This library aims:
- Remove the navigation concerns from the UIViewControllers/Storyvoards into the library
- Increase your modularization by cuttin this logic from the aplication
- Make the navigation pattern similar in all the app
- Reuse UIViewControllers in different navigation contexts.

## Installation

In your Package.swift:

```swift
let package = Package(
  name: "Example",
  dependencies: [
    .package(url: "https://github.com/JLNavigation.git")
  ],
  targets: [
    .target(name: "JLNavigation", dependencies: [])
  ]
)
```

## How to use JLNavigation

The coordination process is pretty straightforward, and its a great way to organize your application navigation. Depending in your app architecture you will have multiple coordinators. 

In a simple way, declare them as a subclass from the protocol JLCoordinator

```swift
// MARK: Coordinator
extension AppCoordinator: Coordinator 
```

Then declare the mandatory variable and method:

```swift

    // This array its used to keep a reference to the subchild coordinators
    var childCoordinators: [Coordinator] = []

    func start() {
        
        // Here you will put the code to start the initialization for this coordinator
    }
```


There's available tree type of routers.
- JLNavigationRouter
- JLRouter
- JLWindowRouter

Basicly each of them help you with the navigation you have. 
For example if you an UINavigationController you just need to call the method push from the JLNavigationRouter.
