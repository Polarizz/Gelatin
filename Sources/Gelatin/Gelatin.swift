import SwiftUI

/// A view modifier that applies a jelly-like wobble effect to any SwiftUI view
public struct GelatinModifier: ViewModifier {
    /// The intensity of the wobble effect (0.0 to 1.0)
    public var intensity: Double
    
    /// The speed of the wobble animation
    public var speed: Double
    
    /// The damping factor for the spring animation
    public var damping: Double
    
    /// The stiffness of the spring animation
    public var stiffness: Double
    
    /// Whether the effect is active
    @State private var isAnimating: Bool = false
    
    public init(
        intensity: Double = 0.5,
        speed: Double = 1.0,
        damping: Double = 0.6,
        stiffness: Double = 200
    ) {
        self.intensity = intensity
        self.speed = speed
        self.damping = damping
        self.stiffness = stiffness
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimating ? 1.0 + (0.1 * intensity) : 1.0)
            .rotationEffect(.degrees(isAnimating ? 3 * intensity : -3 * intensity))
            .animation(
                .spring(
                    response: 0.5 / speed,
                    dampingFraction: damping,
                    blendDuration: 0
                ),
                value: isAnimating
            )
            .onAppear {
                withAnimation(.spring(response: 0.5 / speed, dampingFraction: damping)) {
                    isAnimating = true
                }
            }
    }
}

// MARK: - View Extension

public extension View {
    /// Applies a jelly-like wobble effect to the view
    /// - Parameters:
    ///   - intensity: The intensity of the wobble (0.0 to 1.0)
    ///   - speed: The speed of the animation
    ///   - damping: The damping factor for the spring
    ///   - stiffness: The stiffness of the spring
    /// - Returns: A view with the gelatin effect applied
    func gelatin(
        intensity: Double = 0.5,
        speed: Double = 1.0,
        damping: Double = 0.6,
        stiffness: Double = 200
    ) -> some View {
        self.modifier(
            GelatinModifier(
                intensity: intensity,
                speed: speed,
                damping: damping,
                stiffness: stiffness
            )
        )
    }
} 