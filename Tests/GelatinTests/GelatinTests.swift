//
//  GelatinTests.swift
//  GelatinTests
//
//  Tests for the Gelatin package.
//

#if os(iOS)
import XCTest
import SwiftUI
@testable import Gelatin

final class GelatinTests: XCTestCase {
    
    func testGelatinConfigurationDefaults() {
        // Test that default configuration values are as expected
        XCTAssertEqual(GelatinConfiguration.easingExponent, 1.0 / 3.0)
        XCTAssertEqual(GelatinConfiguration.maximumStretchFactor, 0.9)
        XCTAssertEqual(GelatinConfiguration.fullStretchDistance, 80)
        XCTAssertEqual(GelatinConfiguration.stretchAmplificationFactor, 3)
        XCTAssertEqual(GelatinConfiguration.dragAnimationDuration, 0.39)
        XCTAssertEqual(GelatinConfiguration.releaseAnimationDuration, 0.5)
        XCTAssertEqual(GelatinConfiguration.releaseBounceFactor, 0.5)
        XCTAssertEqual(GelatinConfiguration.pressedScaleFactor, 1.1)
        XCTAssertEqual(GelatinConfiguration.pressedBrightnessAdjustment, 0.3)
        XCTAssertEqual(GelatinConfiguration.pressedSaturationMultiplier, 1.3)
    }
    
    func testGelatinEffectInitialization() {
        // Test that GelatinEffect can be initialized with default values
        let effect = GelatinEffect()
        XCTAssertNotNil(effect)
    }
    
    func testGelatinEffectCustomInitialization() {
        // Test that GelatinEffect can be initialized with custom values
        let effect = GelatinEffect(
            easingExponent: 0.5,
            maximumStretchFactor: 1.2,
            fullStretchDistance: 100,
            stretchAmplificationFactor: 5,
            dragAnimationDuration: 0.5,
            releaseAnimationDuration: 0.7,
            releaseBounceFactor: 0.8,
            pressedScaleFactor: 1.2
        )
        XCTAssertNotNil(effect)
    }
}

#endif // os(iOS) 