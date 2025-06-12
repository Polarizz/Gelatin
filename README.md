# Gelatin

<p>
    <img src="https://img.shields.io/badge/iOS-15.0+-FF4D00.svg" />
    <img src="https://img.shields.io/badge/iPadOS-15.0+-FF4D00.svg" />
    <img src="https://img.shields.io/badge/-SwiftUI-FF9F00.svg" />
</p>

A SwiftUI package for creating elastic, stretchy animation effects that make views behave like Liquid Glass when dragged.

## Overview

Inspired by iOS 26, Gelatin provides a customizable view modifier that adds an elastic, bouncy animation effect to any SwiftUI view. When users drag a view, it stretches and deforms naturally like Liquid Glass, then bounces back to its original position when released.

## Installation

### Swift Package Manager

Add Gelatin to your project through Xcode:

1. File → Add Package Dependencies
2. Enter: `https://github.com/Polarizz/Gelatin`
3. Click "Add Package"

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Polarizz/Gelatin", from: "1.0.0")
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

Check out the `Gelatin-Demo/Gelatin-Demo.xcodeproj` folder for a complete demo app with:
- Interactive parameter adjustment
- Real-time preview
- Reset functionality

## Requirements

- iOS 16.0+ / iPadOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 
