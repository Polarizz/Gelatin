//
//  GelatinApp.swift
//  Gelatin
//
//  Created by Paul Wong on 6/11/25.
//

import SwiftUI

/// The main entry point for the Gelatin app.
/// 
/// Gelatin demonstrates an elastic, stretchy animation effect that can be applied to SwiftUI views.
/// When a user drags the demo element, it stretches and deforms like gelatin, then bounces back
/// to its original position when released.
@main
struct GelatinApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
