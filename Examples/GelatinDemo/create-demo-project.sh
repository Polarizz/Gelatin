#!/bin/bash

echo "================================================"
echo "Gelatin Demo Project Setup"
echo "================================================"
echo ""
echo "This script will guide you through creating an Xcode project for the Gelatin demo."
echo ""

# Check if we're in the right directory
if [ ! -f "ContentView.swift" ] || [ ! -f "GelatinDemoApp.swift" ]; then
    echo "Error: Please run this script from the Examples/GelatinDemo directory."
    echo "Usage: cd Examples/GelatinDemo && ./create-demo-project.sh"
    exit 1
fi

echo "Instructions:"
echo "1. Open Xcode"
echo "2. Create a new project (File → New → Project)"
echo "3. Choose: iOS → App"
echo "4. Configure:"
echo "   - Product Name: GelatinDemo"
echo "   - Interface: SwiftUI"
echo "   - Language: Swift"
echo "   - Use Core Data: NO"
echo "   - Include Tests: NO (optional)"
echo "5. Save the project in THIS directory (Examples/GelatinDemo)"
echo ""
echo "Press Enter when you've created the project..."
read

echo ""
echo "Next steps:"
echo "1. In Xcode, delete the generated ContentView.swift file"
echo "2. Right-click on the GelatinDemo folder in Xcode"
echo "3. Choose 'Add Files to GelatinDemo...'"
echo "4. Select ContentView.swift and GelatinDemoApp.swift from this folder"
echo "5. Make sure 'Copy items if needed' is UNCHECKED"
echo "6. Click 'Add'"
echo ""
echo "Press Enter when you've added the files..."
read

echo ""
echo "Final step - Add the Gelatin package:"
echo "1. In Xcode, go to File → Add Package Dependencies"
echo "2. Click 'Add Local...'"
echo "3. Navigate to the root Gelatin folder (two levels up from here)"
echo "4. Click 'Add Package'"
echo "5. Make sure GelatinDemo target is selected"
echo "6. Click 'Add Package'"
echo ""
echo "You're all set! Build and run the project (⌘R) to see the demo."
echo ""
echo "================================================" 