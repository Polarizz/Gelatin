import SwiftUI

/// A ripple effect that emanates from the center of the view
public struct GelatinRippleModifier: ViewModifier {
    /// The maximum scale of the ripple
    public var maxScale: Double
    
    /// The duration of one ripple
    public var duration: Double
    
    /// The number of ripples
    public var rippleCount: Int
    
    /// Animation states for multiple ripples
    @State private var rippleScales: [Double] = []
    @State private var rippleOpacities: [Double] = []
    
    public init(
        maxScale: Double = 1.5,
        duration: Double = 2.0,
        rippleCount: Int = 3
    ) {
        self.maxScale = maxScale
        self.duration = duration
        self.rippleCount = rippleCount
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<rippleCount, id: \.self) { index in
                content
                    .scaleEffect(rippleScales.indices.contains(index) ? rippleScales[index] : 1.0)
                    .opacity(rippleOpacities.indices.contains(index) ? rippleOpacities[index] : 0.0)
            }
            
            content
        }
        .onAppear {
            rippleScales = Array(repeating: 1.0, count: rippleCount)
            rippleOpacities = Array(repeating: 0.0, count: rippleCount)
            
            for index in 0..<rippleCount {
                let delay = Double(index) * (duration / Double(rippleCount))
                
                withAnimation(
                    .easeOut(duration: duration)
                    .repeatForever(autoreverses: false)
                    .delay(delay)
                ) {
                    rippleScales[index] = maxScale
                    rippleOpacities[index] = 0.0
                }
                
                withAnimation(
                    .easeIn(duration: duration * 0.3)
                    .repeatForever(autoreverses: false)
                    .delay(delay)
                ) {
                    rippleOpacities[index] = 0.5
                }
            }
        }
    }
}

// MARK: - View Extension

public extension View {
    /// Applies a ripple effect emanating from the center of the view
    /// - Parameters:
    ///   - maxScale: The maximum scale of the ripple
    ///   - duration: The duration of one complete ripple
    ///   - rippleCount: The number of concurrent ripples
    /// - Returns: A view with the ripple effect applied
    func gelatinRipple(
        maxScale: Double = 1.5,
        duration: Double = 2.0,
        rippleCount: Int = 3
    ) -> some View {
        self.modifier(
            GelatinRippleModifier(
                maxScale: maxScale,
                duration: duration,
                rippleCount: rippleCount
            )
        )
    }
} 