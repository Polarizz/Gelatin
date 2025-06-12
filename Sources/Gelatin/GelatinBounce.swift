import SwiftUI

/// A continuous bouncing jelly effect
public struct GelatinBounceModifier: ViewModifier {
    public enum BounceDirection {
        case horizontal
        case vertical
        case both
    }
    
    /// The amplitude of the bounce
    public var amplitude: Double
    
    /// The frequency of the bounce
    public var frequency: Double
    
    /// The direction of the bounce
    public var direction: BounceDirection
    
    /// Animation state
    @State private var phase: Double = 0
    
    public init(
        amplitude: Double = 10,
        frequency: Double = 1.0,
        direction: BounceDirection = .vertical
    ) {
        self.amplitude = amplitude
        self.frequency = frequency
        self.direction = direction
    }
    
    private var xOffset: Double {
        switch direction {
        case .horizontal, .both:
            return sin(phase) * amplitude
        case .vertical:
            return 0
        }
    }
    
    private var yOffset: Double {
        switch direction {
        case .vertical, .both:
            return sin(phase) * amplitude
        case .horizontal:
            return 0
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .offset(x: xOffset, y: yOffset)
            .onAppear {
                withAnimation(
                    .linear(duration: 1.0 / frequency)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = .pi * 2
                }
            }
    }
}

// MARK: - View Extension

public extension View {
    /// Applies a continuous bouncing effect to the view
    /// - Parameters:
    ///   - amplitude: The amplitude of the bounce
    ///   - frequency: The frequency of the bounce (bounces per second)
    ///   - direction: The direction of the bounce
    /// - Returns: A view with the bouncing effect applied
    func gelatinBounce(
        amplitude: Double = 10,
        frequency: Double = 1.0,
        direction: GelatinBounceModifier.BounceDirection = .vertical
    ) -> some View {
        self.modifier(
            GelatinBounceModifier(
                amplitude: amplitude,
                frequency: frequency,
                direction: direction
            )
        )
    }
} 