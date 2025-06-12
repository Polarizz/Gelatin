# Gelatin Demo App

This is an interactive demo app that showcases the Gelatin package's elastic animation effects.

## Features

- Interactive sliders to adjust all animation parameters in real-time
- Visual demonstration of the gelatin effect
- Reset button to restore default values

## How to Run

### Quick Setup (Recommended)

1. Run the setup script:
   ```bash
   cd Examples/GelatinDemo
   ./create-demo-project.sh
   ```

2. Follow the interactive instructions

### Manual Setup

1. Create a new Xcode project:
   - Open Xcode
   - File → New → Project
   - Choose "iOS" → "App"
   - Product Name: "GelatinDemo"
   - Interface: SwiftUI
   - Language: Swift
   - Save it in this directory (Examples/GelatinDemo)

2. Add the demo files:
   - Delete the generated ContentView.swift
   - Right-click on the GelatinDemo folder in Xcode
   - Choose "Add Files to GelatinDemo..."
   - Select ContentView.swift and GelatinDemoApp.swift
   - Make sure "Copy items if needed" is UNCHECKED
   - Click "Add"

3. Add the Gelatin package:
   - File → Add Package Dependencies
   - Click "Add Local..."
   - Navigate to the root Gelatin folder (two levels up)
   - Click "Add Package"

4. Build and run (⌘R)

## Demo Usage

- **Drag the yellow button** to see the gelatin effect in action
- **Adjust the sliders** to see how each parameter affects the animation
- **Press Reset** to restore default values

## Parameters You Can Adjust

- **Easing Exponent**: Controls deformation rate
- **Max Stretch Factor**: Maximum stretch amount
- **Full Stretch Distance**: Distance for full effect
- **Stretch Amplification**: Effect intensity
- **Drag Duration**: Animation speed while dragging
- **Release Duration**: Bounce-back speed
- **Release Bounce**: Extra bounce factor
- **Pressed Scale**: Scale when touched 