# Gelatin

A SwiftUI package for creating elastic, stretchy animation effects that make views behave like gelatin when dragged.

## Overview

Gelatin provides a customizable view modifier that adds an elastic, bouncy animation effect to any SwiftUI view. When users drag a view, it stretches and deforms naturally like gelatin, then bounces back to its original position when released.

## Features

- 🎯 **Easy to use** - Just add `.gelatinEffect()` to any view
- 🎨 **Highly customizable** - Fine-tune animation parameters to your needs
- 📱 **Cross-platform** - Supports iOS, macOS, tvOS, and watchOS
- ⚡ **Performant** - Optimized animations using SwiftUI's animation system
- 🔧 **Well-documented** - Comprehensive documentation and examples

## Installation

### Swift Package Manager

Add Gelatin to your project through Xcode:

1. File → Add Package Dependencies
2. Enter: `https://github.com/yourusername/Gelatin`
3. Click "Add Package"

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/Gelatin", from: "1.0.0")
]
```

## Usage

### Basic Usage

```swift
import SwiftUI
import Gelatin

struct ContentView: View {
    var body: some View {
        Text("Drag Me!")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .gelatinEffect() // That's it!
    }
}
```

### Custom Parameters

```swift
Text("Custom Gelatin")
    .gelatinEffect(
        easingExponent: 0.5,
        maximumStretchFactor: 1.2,
        fullStretchDistance: 100,
        stretchAmplificationFactor: 5,
        dragAnimationDuration: 0.5,
        releaseAnimationDuration: 0.7,
        releaseBounceFactor: 0.8,
        pressedScaleFactor: 1.2
    )
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `easingExponent` | `Double` | `0.333` | Controls the rate of deformation (lower = more gradual) |
| `maximumStretchFactor` | `CGFloat` | `0.9` | Maximum stretch amount (0.9 = 90% stretch) |
| `fullStretchDistance` | `CGFloat` | `80` | Distance for full stretch effect in points |
| `stretchAmplificationFactor` | `CGFloat` | `3` | Amplifies the stretch effect |
| `dragAnimationDuration` | `Double` | `0.39` | Duration of drag animation in seconds |
| `releaseAnimationDuration` | `Double` | `0.5` | Duration of release animation in seconds |
| `releaseBounceFactor` | `Double` | `0.5` | Extra bounce on release |
| `pressedScaleFactor` | `CGFloat` | `1.1` | Scale when pressed |

## Demo App

Check out the `Examples/GelatinDemo` folder for a complete demo app with:
- Interactive parameter adjustment
- Real-time preview
- Reset functionality

To run the demo:
1. Open `Examples/GelatinDemo` in Xcode
2. Build and run

## Requirements

- iOS 16.0+ / macOS 13.0+ / tvOS 16.0+ / watchOS 9.0+
- Xcode 15.0+
- Swift 5.9+

## License

MIT License - See LICENSE file for details

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 