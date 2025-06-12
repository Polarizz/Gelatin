import SwiftUI
import Gelatin

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            WobbleDemo()
                .tabItem {
                    Label("Wobble", systemImage: "wind")
                }
                .tag(0)
            
            BounceDemo()
                .tabItem {
                    Label("Bounce", systemImage: "arrow.up.and.down")
                }
                .tag(1)
            
            RippleDemo()
                .tabItem {
                    Label("Ripple", systemImage: "dot.radiowaves.left.and.right")
                }
                .tag(2)
            
            SqueezeDemo()
                .tabItem {
                    Label("Squeeze", systemImage: "rectangle.compress.vertical")
                }
                .tag(3)
            
            CombinedDemo()
                .tabItem {
                    Label("Combined", systemImage: "sparkles")
                }
                .tag(4)
        }
    }
}

// MARK: - Wobble Demo

struct WobbleDemo: View {
    @State private var intensity: Double = 0.5
    @State private var speed: Double = 1.0
    @State private var damping: Double = 0.6
    @State private var triggerWobble = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Demo view
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 150, height: 150)
                    .gelatin(
                        intensity: intensity,
                        speed: speed,
                        damping: damping
                    )
                    .id(triggerWobble)
                
                // Controls
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Intensity: \(intensity, specifier: "%.2f")")
                        Slider(value: $intensity, in: 0...1)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Speed: \(speed, specifier: "%.2f")")
                        Slider(value: $speed, in: 0.1...3)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Damping: \(damping, specifier: "%.2f")")
                        Slider(value: $damping, in: 0.1...1)
                    }
                    
                    Button("Trigger Wobble") {
                        triggerWobble.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Wobble Effect")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Bounce Demo

struct BounceDemo: View {
    @State private var amplitude: Double = 10
    @State private var frequency: Double = 1.0
    @State private var direction: GelatinBounceModifier.BounceDirection = .vertical
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Demo view
                Circle()
                    .fill(LinearGradient(
                        colors: [.orange, .red],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(width: 100, height: 100)
                    .gelatinBounce(
                        amplitude: amplitude,
                        frequency: frequency,
                        direction: direction
                    )
                
                // Controls
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Amplitude: \(amplitude, specifier: "%.0f")")
                        Slider(value: $amplitude, in: 0...50)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Frequency: \(frequency, specifier: "%.2f")")
                        Slider(value: $frequency, in: 0.1...3)
                    }
                    
                    Picker("Direction", selection: $direction) {
                        Text("Horizontal").tag(GelatinBounceModifier.BounceDirection.horizontal)
                        Text("Vertical").tag(GelatinBounceModifier.BounceDirection.vertical)
                        Text("Both").tag(GelatinBounceModifier.BounceDirection.both)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Bounce Effect")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Ripple Demo

struct RippleDemo: View {
    @State private var maxScale: Double = 1.5
    @State private var duration: Double = 2.0
    @State private var rippleCount: Int = 3
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Demo view
                Image(systemName: "drop.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(LinearGradient(
                        colors: [.blue, .cyan],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .gelatinRipple(
                        maxScale: maxScale,
                        duration: duration,
                        rippleCount: rippleCount
                    )
                
                // Controls
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Max Scale: \(maxScale, specifier: "%.2f")")
                        Slider(value: $maxScale, in: 1...3)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Duration: \(duration, specifier: "%.1f")s")
                        Slider(value: $duration, in: 0.5...5)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Ripple Count: \(rippleCount)")
                        Slider(value: .init(
                            get: { Double(rippleCount) },
                            set: { rippleCount = Int($0) }
                        ), in: 1...5, step: 1)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Ripple Effect")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Squeeze Demo

struct SqueezeDemo: View {
    @State private var intensity: Double = 0.3
    @State private var duration: Double = 1.0
    @State private var axis: GelatinSqueezeModifier.SqueezeAxis = .vertical
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Demo view
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(
                        colors: [.green, .mint],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .frame(width: 120, height: 120)
                    .gelatinSqueeze(
                        intensity: intensity,
                        duration: duration,
                        axis: axis
                    )
                
                // Controls
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Intensity: \(intensity, specifier: "%.2f")")
                        Slider(value: $intensity, in: 0...0.5)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Duration: \(duration, specifier: "%.1f")s")
                        Slider(value: $duration, in: 0.5...3)
                    }
                    
                    Picker("Axis", selection: $axis) {
                        Text("Horizontal").tag(GelatinSqueezeModifier.SqueezeAxis.horizontal)
                        Text("Vertical").tag(GelatinSqueezeModifier.SqueezeAxis.vertical)
                        Text("Alternating").tag(GelatinSqueezeModifier.SqueezeAxis.alternating)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Squeeze Effect")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Combined Demo

struct CombinedDemo: View {
    @State private var showWobble = false
    @State private var showBounce = false
    @State private var showRipple = false
    @State private var showSqueeze = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Gelatin")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundStyle(LinearGradient(
                        colors: [.purple, .pink, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .gelatin(intensity: showWobble ? 0.8 : 0)
                    .gelatinBounce(
                        amplitude: showBounce ? 20 : 0,
                        frequency: 1.5,
                        direction: .vertical
                    )
                    .gelatinRipple(
                        maxScale: showRipple ? 1.3 : 1.0,
                        duration: 2.0,
                        rippleCount: 2
                    )
                    .gelatinSqueeze(
                        intensity: showSqueeze ? 0.2 : 0,
                        duration: 0.8,
                        axis: .alternating
                    )
                
                VStack(spacing: 15) {
                    Toggle("Wobble", isOn: $showWobble)
                    Toggle("Bounce", isOn: $showBounce)
                    Toggle("Ripple", isOn: $showRipple)
                    Toggle("Squeeze", isOn: $showSqueeze)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Combined Effects")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
} 