//
//  GelatinEffect.swift
//  Gelatin
//
//  A SwiftUI package for creating elastic, stretchy animation effects.
//

#if os(iOS)
import SwiftUI

// MARK: - Configuration

/// Configuration constants for the gelatin effect animation
public struct GelatinConfiguration {
    /// The easing exponent that controls the rate of deformation (lower = more gradual)
    public static let easingExponent: Double = 1.0 / 3.0
    
    /// Maximum stretch factor applied to the view (0.9 = 90% maximum stretch)
    public static let maximumStretchFactor: CGFloat = 0.9
    
    /// Distance threshold for full stretch effect in points
    public static let fullStretchDistance: CGFloat = 80
    
    /// Multiplier that amplifies the stretch effect
    public static let stretchAmplificationFactor: CGFloat = 3
    
    /// Duration for the drag animation in seconds
    public static let dragAnimationDuration: Double = 0.39
    
    /// Duration for the release bounce-back animation in seconds
    public static let releaseAnimationDuration: Double = 0.5
    
    /// Extra bounce factor for the release animation
    public static let releaseBounceFactor: Double = 0.5
    
    /// Duration for touch feedback animations in seconds
    public static let touchFeedbackDuration: Double = 0.3
    
    /// Scale factor applied when view is pressed
    public static let pressedScaleFactor: CGFloat = 1.1
    
    /// Brightness adjustment when view is pressed
    public static let pressedBrightnessAdjustment: Double = 0.3
    
    /// Saturation multiplier when view is pressed
    public static let pressedSaturationMultiplier: Double = 1.3
}

// MARK: - Gelatin Effect Modifier

/// A view modifier that applies a gelatin-like stretchy effect when dragged.
/// 
/// The gelatin effect consists of:
/// - Elastic stretching based on drag distance and direction
/// - Smooth easing function for natural deformation
/// - Bounce-back animation when drag ends
/// - Visual feedback during interaction
@available(iOS 16.0, *)
public struct GelatinEffect: ViewModifier {
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
    
    public init(
        easingExponent: Double = GelatinConfiguration.easingExponent,
        maximumStretchFactor: CGFloat = GelatinConfiguration.maximumStretchFactor,
        fullStretchDistance: CGFloat = GelatinConfiguration.fullStretchDistance,
        stretchAmplificationFactor: CGFloat = GelatinConfiguration.stretchAmplificationFactor,
        dragAnimationDuration: Double = GelatinConfiguration.dragAnimationDuration,
        releaseAnimationDuration: Double = GelatinConfiguration.releaseAnimationDuration,
        releaseBounceFactor: Double = GelatinConfiguration.releaseBounceFactor,
        pressedScaleFactor: CGFloat = GelatinConfiguration.pressedScaleFactor
    ) {
        self.easingExponent = easingExponent
        self.maximumStretchFactor = maximumStretchFactor
        self.fullStretchDistance = fullStretchDistance
        self.stretchAmplificationFactor = stretchAmplificationFactor
        self.dragAnimationDuration = dragAnimationDuration
        self.releaseAnimationDuration = releaseAnimationDuration
        self.releaseBounceFactor = releaseBounceFactor
        self.pressedScaleFactor = pressedScaleFactor
    }
    
    public func body(content: Content) -> some View {
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

@available(iOS 16.0, *)
public extension View {
    /// Applies a gelatin effect to any SwiftUI view with default parameters
    /// - Returns: A view with the gelatin effect applied
    func gelatinEffect() -> some View {
        modifier(GelatinEffect())
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

#endif // os(iOS) 