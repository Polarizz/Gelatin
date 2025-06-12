//
//  ContentView.swift
//  Gelatin
//
//  Created by Paul Wong on 6/11/25.
//

import SwiftUI

// MARK: - Constants

/// Configuration constants for the gelatin effect animation
private struct GelatinConfiguration {
    /// The easing exponent that controls the rate of deformation (lower = more gradual)
    static let easingExponent: Double = 1.0 / 3.0

    /// Maximum stretch factor applied to the view (0.9 = 90% maximum stretch)
    static let maximumStretchFactor: CGFloat = 0.9
    
    /// Distance threshold for full stretch effect in points
    static let fullStretchDistance: CGFloat = 80
    
    /// Multiplier that amplifies the stretch effect
    static let stretchAmplificationFactor: CGFloat = 5

    /// Duration for the drag animation in seconds
    static let dragAnimationDuration: Double = 0.39
    
    /// Duration for the release bounce-back animation in seconds
    static let releaseAnimationDuration: Double = 0.5
    
    /// Extra bounce factor for the release animation
    static let releaseBounceFactor: Double = 0.5
    
    /// Duration for touch feedback animations in seconds
    static let touchFeedbackDuration: Double = 0.3
    
    /// Scale factor applied when view is pressed
    static let pressedScaleFactor: CGFloat = 1.1
    
    /// Brightness adjustment when view is pressed
    static let pressedBrightnessAdjustment: Double = 0.3
    
    /// Saturation multiplier when view is pressed
    static let pressedSaturationMultiplier: Double = 1.3
}



// MARK: - Gelatin Effect Modifier

/// A view modifier that applies a gelatin-like stretchy effect when dragged.
/// 
/// The gelatin effect consists of:
/// - Elastic stretching based on drag distance and direction
/// - Smooth easing function for natural deformation
/// - Bounce-back animation when drag ends
/// - Visual feedback during interaction
private struct GelatinEffect: ViewModifier {
    // Configuration parameters
    let easingExponent: Double
    let maximumStretchFactor: CGFloat
    let fullStretchDistance: CGFloat
    let stretchAmplificationFactor: CGFloat
    let dragAnimationDuration: Double
    let releaseAnimationDuration: Double
    let releaseBounceFactor: Double
    let pressedScaleFactor: CGFloat
    /// Current offset from the original position
    @State private var currentOffset: CGSize = .zero
    
    /// Current scale values for width and height stretching
    @State private var currentStretchScale: CGSize = CGSize(width: 1, height: 1)
    
    /// Whether the view is currently being touched/pressed
    @State private var isPressed = false
    
    func body(content: Content) -> some View {
        content
            .offset(x: currentOffset.width, y: currentOffset.height)
            .scaleEffect(
                x: currentStretchScale.width,
                y: currentStretchScale.height,
                anchor: .center
            )
            .scaleEffect(isPressed ? pressedScaleFactor : 1)
            .brightness(isPressed ? GelatinConfiguration.pressedBrightnessAdjustment : 0)
            .saturation(isPressed ? GelatinConfiguration.pressedSaturationMultiplier : 1)
            .simultaneousGesture(createDragGesture())
            .simultaneousGesture(createPressGesture())
    }
    
    /// Creates the main drag gesture that handles the gelatin stretching effect
    private func createDragGesture() -> some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { dragValue in
                let easedTranslation = applyEasingToTranslation(dragValue.translation)
                
                withAnimation(.smooth(duration: dragAnimationDuration)) {
                    currentOffset = easedTranslation
                    currentStretchScale = calculateStretchScale(for: easedTranslation)
                }
            }
            .onEnded { _ in
                withAnimation(
                    .smooth(
                        duration: releaseAnimationDuration,
                        extraBounce: releaseBounceFactor
                    )
                ) {
                    currentOffset = .zero
                    currentStretchScale = CGSize(width: 1, height: 1)
                }
            }
    }
    
    /// Creates the press gesture that handles visual feedback
    private func createPressGesture() -> some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { _ in
                withAnimation(
                    .smooth(
                        duration: GelatinConfiguration.touchFeedbackDuration,
                        extraBounce: GelatinConfiguration.releaseBounceFactor
                    )
                ) {
                    isPressed = true
                }
            }
            .onEnded { _ in
                withAnimation(
                    .smooth(
                        duration: GelatinConfiguration.touchFeedbackDuration,
                        extraBounce: GelatinConfiguration.releaseBounceFactor
                    )
                ) {
                    isPressed = false
                }
            }
    }
    
    /// Applies an easing function to the drag translation for natural movement
    /// - Parameter translation: The raw drag translation
    /// - Returns: The eased translation with reduced sensitivity
    private func applyEasingToTranslation(_ translation: CGSize) -> CGSize {
        return CGSize(
            width: applyEasing(to: translation.width),
            height: applyEasing(to: translation.height)
        )
    }
    
    /// Applies an easing function to a single dimension
    /// - Parameter distance: The distance to ease
    /// - Returns: The eased distance using a power function
    private func applyEasing(to distance: CGFloat) -> CGFloat {
        guard distance != 0 else { return 0 }
        
        let easedMagnitude = pow(Double(abs(distance)), easingExponent)
        let direction: CGFloat = distance < 0 ? -1 : 1
        
        return CGFloat(easedMagnitude) * direction
    }
    
    /// Calculates the stretch scale based on the eased translation
    /// - Parameter easedTranslation: The translation after easing is applied
    /// - Returns: A CGSize representing the stretch scale for width and height
    private func calculateStretchScale(for easedTranslation: CGSize) -> CGSize {
        return CGSize(
            width: calculateStretchFactor(for: easedTranslation.width),
            height: calculateStretchFactor(for: easedTranslation.height)
        )
    }
    
    /// Calculates the stretch factor for a single dimension
    /// - Parameter distance: The eased distance in one dimension
    /// - Returns: The stretch factor (1.0 = no stretch, >1.0 = stretched)
    private func calculateStretchFactor(for distance: CGFloat) -> CGFloat {
        let normalizedDistance = min(abs(distance) / fullStretchDistance, 1)
        let stretchAmount = maximumStretchFactor * normalizedDistance * stretchAmplificationFactor
        
        return 1 + stretchAmount
    }
}

// MARK: - View Extension

extension View {
    /// Applies a gelatin effect to any SwiftUI view with default parameters
    /// - Returns: A view with the gelatin effect applied
    func gelatinEffect() -> some View {
        modifier(GelatinEffect(
            easingExponent: GelatinConfiguration.easingExponent,
            maximumStretchFactor: GelatinConfiguration.maximumStretchFactor,
            fullStretchDistance: GelatinConfiguration.fullStretchDistance,
            stretchAmplificationFactor: GelatinConfiguration.stretchAmplificationFactor,
            dragAnimationDuration: GelatinConfiguration.dragAnimationDuration,
            releaseAnimationDuration: GelatinConfiguration.releaseAnimationDuration,
            releaseBounceFactor: GelatinConfiguration.releaseBounceFactor,
            pressedScaleFactor: GelatinConfiguration.pressedScaleFactor
        ))
    }
    
    /// Applies a gelatin effect to any SwiftUI view with custom parameters
    /// - Parameters:
    ///   - easingExponent: The easing exponent that controls the rate of deformation
    ///   - maximumStretchFactor: Maximum stretch factor applied to the view
    ///   - fullStretchDistance: Distance threshold for full stretch effect
    ///   - stretchAmplificationFactor: Multiplier that amplifies the stretch effect
    ///   - dragAnimationDuration: Duration for the drag animation
    ///   - releaseAnimationDuration: Duration for the release bounce-back animation
    ///   - releaseBounceFactor: Extra bounce factor for the release animation
    ///   - pressedScaleFactor: Scale factor applied when view is pressed
    /// - Returns: A view with the gelatin effect applied
    func gelatinEffect(
        easingExponent: Double,
        maximumStretchFactor: CGFloat,
        fullStretchDistance: CGFloat,
        stretchAmplificationFactor: CGFloat,
        dragAnimationDuration: Double,
        releaseAnimationDuration: Double,
        releaseBounceFactor: Double,
        pressedScaleFactor: CGFloat
    ) -> some View {
        modifier(GelatinEffect(
            easingExponent: easingExponent,
            maximumStretchFactor: maximumStretchFactor,
            fullStretchDistance: fullStretchDistance,
            stretchAmplificationFactor: stretchAmplificationFactor,
            dragAnimationDuration: dragAnimationDuration,
            releaseAnimationDuration: releaseAnimationDuration,
            releaseBounceFactor: releaseBounceFactor,
            pressedScaleFactor: pressedScaleFactor
        ))
    }
}

// MARK: - Demo Button

/// A demo button view that showcases the gelatin effect.
/// This is just a placeholder view for demonstration purposes.
private struct DemoButton: View {
    var body: some View {
            Text("DRAG ME")
                .font(.body.weight(.semibold))
                .padding(.vertical, 16)
                .padding(.horizontal, 24)
                .foregroundStyle(.black)
                .background(.yellow)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.39),
                                    Color.black.opacity(0.1),
                                    Color.white.opacity(0.13)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1.2
                        )
                )
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 9)
    }
}

// MARK: - Main Content View

/// The main content view demonstrating the gelatin effect.
/// 
/// This view presents a draggable button that showcases the elastic, stretchy animation
/// behavior. The button can be dragged around and will stretch like gelatin, then
/// bounce back to its original position when released.
struct ContentView: View {
    // Configurable parameters for real-time adjustment
    @State private var easingExponent: Double = GelatinConfiguration.easingExponent
    @State private var maximumStretchFactor: CGFloat = GelatinConfiguration.maximumStretchFactor
    @State private var fullStretchDistance: CGFloat = GelatinConfiguration.fullStretchDistance
    @State private var stretchAmplificationFactor: CGFloat = GelatinConfiguration.stretchAmplificationFactor
    @State private var dragAnimationDuration: Double = GelatinConfiguration.dragAnimationDuration
    @State private var releaseAnimationDuration: Double = GelatinConfiguration.releaseAnimationDuration
    @State private var releaseBounceFactor: Double = GelatinConfiguration.releaseBounceFactor
    @State private var pressedScaleFactor: CGFloat = GelatinConfiguration.pressedScaleFactor
    var body: some View {
        VStack(spacing: 40) {
            // Title section
            VStack(spacing: 16) {
                Text("Gelatin Effect Demo")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                Text("Drag the button below to see the elastic gelatin effect")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            // Demo button with gelatin effect
            DemoButton()
                .gelatinEffect(
                    easingExponent: easingExponent,
                    maximumStretchFactor: maximumStretchFactor,
                    fullStretchDistance: fullStretchDistance,
                    stretchAmplificationFactor: stretchAmplificationFactor,
                    dragAnimationDuration: dragAnimationDuration,
                    releaseAnimationDuration: releaseAnimationDuration,
                    releaseBounceFactor: releaseBounceFactor,
                    pressedScaleFactor: pressedScaleFactor
                )
            
            Spacer()
            
            // Configuration Controls
            createConfigurationControls()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
    
    /// Resets all configuration parameters to their default values
    private func resetToDefaults() {
        withAnimation(.smooth(duration: 0.3)) {
            easingExponent = GelatinConfiguration.easingExponent
            maximumStretchFactor = GelatinConfiguration.maximumStretchFactor
            fullStretchDistance = GelatinConfiguration.fullStretchDistance
            stretchAmplificationFactor = GelatinConfiguration.stretchAmplificationFactor
            dragAnimationDuration = GelatinConfiguration.dragAnimationDuration
            releaseAnimationDuration = GelatinConfiguration.releaseAnimationDuration
            releaseBounceFactor = GelatinConfiguration.releaseBounceFactor
            pressedScaleFactor = GelatinConfiguration.pressedScaleFactor
        }
    }
    
    /// Creates the configuration controls section with sliders for real-time parameter adjustment
    /// - Returns: A view containing all the configuration sliders
    @ViewBuilder
    private func createConfigurationControls() -> some View {
        VStack(spacing: 12) {
            HStack {
                Text("Configuration Controls")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Button(action: resetToDefaults) {
                    Text("Reset")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.gray)
                        .clipShape(Capsule())
                }
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    createDoubleSlider(
                        title: "Easing Exponent",
                        value: $easingExponent,
                        range: 0.1...1.0,
                        format: "%.2f"
                    )
                    
                    createCGFloatSlider(
                        title: "Max Stretch Factor",
                        value: $maximumStretchFactor,
                        range: 0.1...2.0,
                        format: "%.2f"
                    )
                    
                    createCGFloatSlider(
                        title: "Full Stretch Distance",
                        value: $fullStretchDistance,
                        range: 20...200,
                        format: "%.0f"
                    )
                    
                    createCGFloatSlider(
                        title: "Stretch Amplification",
                        value: $stretchAmplificationFactor,
                        range: 1...10,
                        format: "%.1f"
                    )
                    
                    createDoubleSlider(
                        title: "Drag Duration",
                        value: $dragAnimationDuration,
                        range: 0.1...1.0,
                        format: "%.2f"
                    )
                    
                    createDoubleSlider(
                        title: "Release Duration",
                        value: $releaseAnimationDuration,
                        range: 0.1...2.0,
                        format: "%.2f"
                    )
                    
                    createDoubleSlider(
                        title: "Release Bounce",
                        value: $releaseBounceFactor,
                        range: 0.0...1.0,
                        format: "%.2f"
                    )
                    
                    createCGFloatSlider(
                        title: "Pressed Scale",
                        value: $pressedScaleFactor,
                        range: 1.0...2.0,
                        format: "%.2f"
                    )
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 200)
        }
    }
    
    /// Creates a labeled slider for Double parameter adjustment
    /// - Parameters:
    ///   - title: The label for the slider
    ///   - value: The binding to the Double parameter value
    ///   - range: The allowed range for the parameter
    ///   - format: The format string for displaying the value
    /// - Returns: A view containing the labeled slider
    @ViewBuilder
    private func createDoubleSlider(
        title: String,
        value: Binding<Double>,
        range: ClosedRange<Double>,
        format: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(format: format, value.wrappedValue))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.primary)
            }
            
            Slider(value: value, in: range)
                .tint(.yellow)
        }
    }
    
    /// Creates a labeled slider for CGFloat parameter adjustment
    /// - Parameters:
    ///   - title: The label for the slider
    ///   - value: The binding to the CGFloat parameter value
    ///   - range: The allowed range for the parameter
    ///   - format: The format string for displaying the value
    /// - Returns: A view containing the labeled slider
    @ViewBuilder
    private func createCGFloatSlider(
        title: String,
        value: Binding<CGFloat>,
        range: ClosedRange<CGFloat>,
        format: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(format: format, Double(value.wrappedValue)))
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.primary)
            }
            
            Slider(value: value, in: range)
                .tint(.yellow)
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
