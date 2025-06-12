import SwiftUI

/// A squeeze and stretch effect that simulates elastic deformation
public struct GelatinSqueezeModifier: ViewModifier {
    public enum SqueezeAxis {
        case horizontal
        case vertical
        case alternating
    }
    
    /// The amount of squeeze (0.0 to 1.0)
    public var intensity: Double
    
    /// The duration of one squeeze cycle
    public var duration: Double
    
    /// The axis along which to squeeze
    public var axis: SqueezeAxis
    
    /// Animation state
    @State private var isSqueezed: Bool = false
    @State private var currentAxis: Bool = false // false = horizontal, true = vertical
    
    public init(
        intensity: Double = 0.3,
        duration: Double = 1.0,
        axis: SqueezeAxis = .vertical
    ) {
        self.intensity = intensity
        self.duration = duration
        self.axis = axis
    }
    
    private var scaleX: Double {
        switch axis {
        case .horizontal:
            return isSqueezed ? 1.0 - intensity : 1.0 + (intensity * 0.5)
        case .vertical:
            return isSqueezed ? 1.0 + (intensity * 0.5) : 1.0 - intensity
        case .alternating:
            if currentAxis {
                return isSqueezed ? 1.0 + (intensity * 0.5) : 1.0 - intensity
            } else {
                return isSqueezed ? 1.0 - intensity : 1.0 + (intensity * 0.5)
            }
        }
    }
    
    private var scaleY: Double {
        switch axis {
        case .horizontal:
            return isSqueezed ? 1.0 + (intensity * 0.5) : 1.0 - intensity
        case .vertical:
            return isSqueezed ? 1.0 - intensity : 1.0 + (intensity * 0.5)
        case .alternating:
            if currentAxis {
                return isSqueezed ? 1.0 - intensity : 1.0 + (intensity * 0.5)
            } else {
                return isSqueezed ? 1.0 + (intensity * 0.5) : 1.0 - intensity
            }
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .scaleEffect(x: scaleX, y: scaleY)
            .animation(
                .easeInOut(duration: duration / 2),
                value: isSqueezed
            )
            .animation(
                .easeInOut(duration: duration),
                value: currentAxis
            )
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: duration / 2, repeats: true) { _ in
                    isSqueezed.toggle()
                    if axis == .alternating && !isSqueezed {
                        currentAxis.toggle()
                    }
                }
            }
    }
}

// MARK: - View Extension

public extension View {
    /// Applies a squeeze and stretch effect to the view
    /// - Parameters:
    ///   - intensity: The intensity of the squeeze (0.0 to 1.0)
    ///   - duration: The duration of one complete squeeze cycle
    ///   - axis: The axis along which to apply the squeeze
    /// - Returns: A view with the squeeze effect applied
    func gelatinSqueeze(
        intensity: Double = 0.3,
        duration: Double = 1.0,
        axis: GelatinSqueezeModifier.SqueezeAxis = .vertical
    ) -> some View {
        self.modifier(
            GelatinSqueezeModifier(
                intensity: intensity,
                duration: duration,
                axis: axis
            )
        )
    }
} 