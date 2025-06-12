//
//  ContentView.swift
//  GelatinDemo
//
//  A demo app showcasing the Gelatin package's elastic animation effects.
//

import SwiftUI
import Gelatin

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