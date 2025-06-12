# Gelatin API Reference

## View Modifiers

### gelatin(intensity:speed:damping:stiffness:)

Applies a jelly-like wobble effect to any SwiftUI view.

```swift
func gelatin(
    intensity: Double = 0.5,
    speed: Double = 1.0,
    damping: Double = 0.6,
    stiffness: Double = 200
) -> some View
```

**Parameters:**
- `intensity`: The intensity of the wobble effect (0.0 to 1.0). Default: 0.5
- `speed`: The speed multiplier for the animation. Default: 1.0
- `damping`: The damping factor for the spring animation. Default: 0.6
- `stiffness`: The stiffness of the spring animation. Default: 200

**Example:**
```swift
Text("Wobble!")
    .gelatin(intensity: 0.8, speed: 1.5)
```

---

### gelatinBounce(amplitude:frequency:direction:)

Creates a continuous bouncing animation on the view.

```swift
func gelatinBounce(
    amplitude: Double = 10,
    frequency: Double = 1.0,
    direction: GelatinBounceModifier.BounceDirection = .vertical
) -> some View
```

**Parameters:**
- `amplitude`: The distance of the bounce in points. Default: 10
- `frequency`: The number of bounces per second. Default: 1.0
- `direction`: The direction of the bounce. Default: `.vertical`

**BounceDirection enum:**
- `.horizontal`: Bounces left and right
- `.vertical`: Bounces up and down
- `.both`: Bounces in both directions simultaneously

**Example:**
```swift
Image(systemName: "star")
    .gelatinBounce(amplitude: 20, frequency: 2, direction: .both)
```

---

### gelatinRipple(maxScale:duration:rippleCount:)

Adds a ripple effect emanating from the center of the view.

```swift
func gelatinRipple(
    maxScale: Double = 1.5,
    duration: Double = 2.0,
    rippleCount: Int = 3
) -> some View
```

**Parameters:**
- `maxScale`: The maximum scale factor for the ripple. Default: 1.5
- `duration`: The duration of one complete ripple cycle in seconds. Default: 2.0
- `rippleCount`: The number of concurrent ripples. Default: 3

**Example:**
```swift
Circle()
    .gelatinRipple(maxScale: 2.0, duration: 3.0, rippleCount: 5)
```

---

### gelatinSqueeze(intensity:duration:axis:)

Applies a squeeze and stretch animation to the view.

```swift
func gelatinSqueeze(
    intensity: Double = 0.3,
    duration: Double = 1.0,
    axis: GelatinSqueezeModifier.SqueezeAxis = .vertical
) -> some View
```

**Parameters:**
- `intensity`: The amount of squeeze (0.0 to 1.0). Default: 0.3
- `duration`: The duration of one complete squeeze cycle in seconds. Default: 1.0
- `axis`: The axis along which to apply the squeeze. Default: `.vertical`

**SqueezeAxis enum:**
- `.horizontal`: Squeezes horizontally
- `.vertical`: Squeezes vertically
- `.alternating`: Alternates between horizontal and vertical squeezing

**Example:**
```swift
RoundedRectangle(cornerRadius: 10)
    .gelatinSqueeze(intensity: 0.4, axis: .alternating)
```

## ViewModifier Types

### GelatinModifier

The main wobble effect modifier.

```swift
public struct GelatinModifier: ViewModifier {
    public var intensity: Double
    public var speed: Double
    public var damping: Double
    public var stiffness: Double
    
    public init(
        intensity: Double = 0.5,
        speed: Double = 1.0,
        damping: Double = 0.6,
        stiffness: Double = 200
    )
}
```

### GelatinBounceModifier

The bounce effect modifier.

```swift
public struct GelatinBounceModifier: ViewModifier {
    public enum BounceDirection {
        case horizontal
        case vertical
        case both
    }
    
    public var amplitude: Double
    public var frequency: Double
    public var direction: BounceDirection
    
    public init(
        amplitude: Double = 10,
        frequency: Double = 1.0,
        direction: BounceDirection = .vertical
    )
}
```

### GelatinRippleModifier

The ripple effect modifier.

```swift
public struct GelatinRippleModifier: ViewModifier {
    public var maxScale: Double
    public var duration: Double
    public var rippleCount: Int
    
    public init(
        maxScale: Double = 1.5,
        duration: Double = 2.0,
        rippleCount: Int = 3
    )
}
```

### GelatinSqueezeModifier

The squeeze effect modifier.

```swift
public struct GelatinSqueezeModifier: ViewModifier {
    public enum SqueezeAxis {
        case horizontal
        case vertical
        case alternating
    }
    
    public var intensity: Double
    public var duration: Double
    public var axis: SqueezeAxis
    
    public init(
        intensity: Double = 0.3,
        duration: Double = 1.0,
        axis: SqueezeAxis = .vertical
    )
}
```

## Best Practices

1. **Performance**: While effects can be combined, be mindful of performance on older devices when using multiple effects simultaneously.

2. **Subtlety**: Often, subtle effects (lower intensity values) create more professional results than extreme values.

3. **User Preferences**: Consider respecting the user's "Reduce Motion" accessibility setting:
   ```swift
   @Environment(\.accessibilityReduceMotion) var reduceMotion
   
   Text("Hello")
       .gelatin(intensity: reduceMotion ? 0 : 0.5)
   ```

4. **Animation Timing**: Match your animation frequencies and durations to the context of your UI for the best user experience.

5. **Combining Effects**: When combining multiple effects, test on real devices to ensure smooth performance. 