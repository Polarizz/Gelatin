# Gelatin <img src="https://user-images.githubusercontent.com/YOUR_USERNAME/gelatin-logo.png" width="60" align="right">

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20iPadOS-lightgrey.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Twitter](https://img.shields.io/badge/twitter-@yourusername-1DA1F2.svg)](https://twitter.com/yourusername)

A SwiftUI library that brings your UI to life with jelly-like spring animations and wobbly effects. Create engaging, playful interfaces with just a single modifier.

<p align="center">
  <img src="https://user-images.githubusercontent.com/YOUR_USERNAME/gelatin-demo.gif" width="300">
</p>

## Installation

This repository is a Swift package, so just include it in your Xcode project and target under **File > Add package dependencies**. Then, `import Gelatin` to the Swift files where you'll be using it.

### Requirements

- iOS 15.0+ / iPadOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## Usage

Gelatin provides several delightful animation effects that can be applied to any SwiftUI view:

### Basic Wobble Effect

Add a jelly-like wobble effect with the following modifier:

```swift
Text("Hello, Jelly!")
    .gelatin()
```

Customize the wobble with optional parameters:

```swift
.gelatin(
    intensity: 0.8,    // The intensity of the wobble (0.0 to 1.0)
    speed: 1.5,        // The speed of the animation
    damping: 0.6,      // Spring damping factor
    stiffness: 200     // Spring stiffness
)
```

### Bounce Effect

Create a continuous bouncing animation:

```swift
Image(systemName: "star.fill")
    .gelatinBounce(
        amplitude: 20,     // The bounce distance in points
        frequency: 1.0,    // Bounces per second
        direction: .vertical // .horizontal, .vertical, or .both
    )
```

### Ripple Effect

Add a mesmerizing ripple effect emanating from the center:

```swift
Circle()
    .gelatinRipple(
        maxScale: 1.5,     // Maximum scale of the ripple
        duration: 2.0,     // Duration of one ripple cycle
        rippleCount: 3     // Number of concurrent ripples
    )
```

### Squeeze Effect

Apply an elastic squeeze and stretch animation:

```swift
RoundedRectangle(cornerRadius: 10)
    .gelatinSqueeze(
        intensity: 0.3,    // Squeeze intensity (0.0 to 1.0)
        duration: 1.0,     // Duration of one squeeze cycle
        axis: .vertical    // .horizontal, .vertical, or .alternating
    )
```

### Combining Effects

You can combine multiple Gelatin effects for even more dynamic animations:

```swift
Text("Gelatin")
    .font(.largeTitle)
    .gelatin(intensity: 0.5)
    .gelatinBounce(amplitude: 10, direction: .vertical)
    .gelatinRipple(maxScale: 1.2, rippleCount: 2)
```

## How it Works

Gelatin leverages SwiftUI's powerful animation system to create smooth, spring-based animations that feel natural and responsive. Each effect is implemented as a custom `ViewModifier` that can be easily applied to any view.

The library uses:
- **Spring animations** for natural, physics-based motion
- **State-driven animations** for smooth transitions
- **Compositional design** allowing multiple effects to be combined
- **Performance optimizations** to ensure smooth 60fps animations

### Performance Considerations

- Effects are rendered using SwiftUI's native animation system for optimal performance
- Animations are automatically paused when views are off-screen
- Multiple effects can be combined without significant performance impact

## Demo

You can run a comprehensive demo of all Gelatin effects through the **GelatinDemo** app included in the `Examples` folder of this repository. The demo includes:

- Interactive controls for all effect parameters
- Real-time preview of each effect
- Examples of combining multiple effects
- Sample use cases and best practices

To run the demo:
1. Open `Examples/GelatinDemo/GelatinDemo.xcodeproj` in Xcode
2. Select your target device or simulator
3. Build and run the project

## Examples

### Loading Indicator
```swift
ProgressView()
    .gelatinBounce(amplitude: 5, frequency: 2)
```

### Attention-Grabbing Button
```swift
Button("Tap Me!") { }
    .gelatin(intensity: 0.3)
    .onTapGesture {
        // Trigger additional wobble
    }
```

### Animated Logo
```swift
Image("AppLogo")
    .gelatinRipple(maxScale: 1.3, duration: 3)
    .gelatinSqueeze(intensity: 0.1, axis: .alternating)
```

### Floating Elements
```swift
ForEach(items) { item in
    ItemView(item)
        .gelatinBounce(
            amplitude: 15,
            frequency: 0.5 + Double(item.id) * 0.1,
            direction: .vertical
        )
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

Gelatin is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Acknowledgments

- Inspired by the delightful animations in modern iOS apps
- Built with love using SwiftUI
- Special thanks to the Swift community for continuous inspiration

---

<p align="center">
  Made with 🍮 by <a href="https://twitter.com/yourusername">Your Name</a>
</p>