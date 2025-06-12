import XCTest
import SwiftUI
@testable import Gelatin

final class GelatinTests: XCTestCase {
    
    // MARK: - GelatinModifier Tests
    
    func testGelatinModifierInitialization() {
        let modifier = GelatinModifier()
        XCTAssertEqual(modifier.intensity, 0.5)
        XCTAssertEqual(modifier.speed, 1.0)
        XCTAssertEqual(modifier.damping, 0.6)
        XCTAssertEqual(modifier.stiffness, 200)
    }
    
    func testGelatinModifierCustomInitialization() {
        let modifier = GelatinModifier(
            intensity: 0.8,
            speed: 2.0,
            damping: 0.4,
            stiffness: 300
        )
        XCTAssertEqual(modifier.intensity, 0.8)
        XCTAssertEqual(modifier.speed, 2.0)
        XCTAssertEqual(modifier.damping, 0.4)
        XCTAssertEqual(modifier.stiffness, 300)
    }
    
    // MARK: - GelatinBounceModifier Tests
    
    func testGelatinBounceModifierInitialization() {
        let modifier = GelatinBounceModifier()
        XCTAssertEqual(modifier.amplitude, 10)
        XCTAssertEqual(modifier.frequency, 1.0)
        XCTAssertEqual(modifier.direction, .vertical)
    }
    
    func testGelatinBounceModifierCustomInitialization() {
        let modifier = GelatinBounceModifier(
            amplitude: 20,
            frequency: 2.0,
            direction: .horizontal
        )
        XCTAssertEqual(modifier.amplitude, 20)
        XCTAssertEqual(modifier.frequency, 2.0)
        XCTAssertEqual(modifier.direction, .horizontal)
    }
    
    // MARK: - GelatinRippleModifier Tests
    
    func testGelatinRippleModifierInitialization() {
        let modifier = GelatinRippleModifier()
        XCTAssertEqual(modifier.maxScale, 1.5)
        XCTAssertEqual(modifier.duration, 2.0)
        XCTAssertEqual(modifier.rippleCount, 3)
    }
    
    func testGelatinRippleModifierCustomInitialization() {
        let modifier = GelatinRippleModifier(
            maxScale: 2.0,
            duration: 3.0,
            rippleCount: 5
        )
        XCTAssertEqual(modifier.maxScale, 2.0)
        XCTAssertEqual(modifier.duration, 3.0)
        XCTAssertEqual(modifier.rippleCount, 5)
    }
    
    // MARK: - GelatinSqueezeModifier Tests
    
    func testGelatinSqueezeModifierInitialization() {
        let modifier = GelatinSqueezeModifier()
        XCTAssertEqual(modifier.intensity, 0.3)
        XCTAssertEqual(modifier.duration, 1.0)
        XCTAssertEqual(modifier.axis, .vertical)
    }
    
    func testGelatinSqueezeModifierCustomInitialization() {
        let modifier = GelatinSqueezeModifier(
            intensity: 0.5,
            duration: 2.0,
            axis: .alternating
        )
        XCTAssertEqual(modifier.intensity, 0.5)
        XCTAssertEqual(modifier.duration, 2.0)
        XCTAssertEqual(modifier.axis, .alternating)
    }
    
    // MARK: - View Extension Tests
    
    func testViewExtensions() {
        let view = Text("Test")
        
        // Test gelatin modifier application
        let gelatinView = view.gelatin()
        XCTAssertNotNil(gelatinView)
        
        // Test bounce modifier application
        let bounceView = view.gelatinBounce()
        XCTAssertNotNil(bounceView)
        
        // Test ripple modifier application
        let rippleView = view.gelatinRipple()
        XCTAssertNotNil(rippleView)
        
        // Test squeeze modifier application
        let squeezeView = view.gelatinSqueeze()
        XCTAssertNotNil(squeezeView)
    }
} 