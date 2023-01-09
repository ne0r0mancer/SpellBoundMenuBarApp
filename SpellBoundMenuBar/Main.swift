//
//  Main.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 1/9/23.
//

import SwiftUI

struct MainScene: Scene {
    var body: some Scene {
        WindowGroup(id: "mainscene") {
            WelcomeView()
                .fixedSize()
        }
        .windowResizability(.contentSize)
    }
}

struct WelcomeView: View {
    @State private var welcomeScreenShown: Bool = UserDefaults.standard.bool(forKey: "welcomeScreenShown")

    var body: some View {
        VStack {
            Image(systemName: "sparkles")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            Text("Spellbound will give your writing a sparkle!")
            // show image
            Image("intro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 350, height: 350)
            Text("We hope you will enjoy using our app!")

            if welcomeScreenShown {
                // close WindowGroup
                Button(action: {
                    NSApplication.shared.keyWindow?.close()
                    // show preferences window

                }) {
                    Text("Close")
                }
            } else {
                Button(action: {
                    // Navigate to the main app content here
                    // Set the value in UserDefaults to indicate that the intro screen has been shown
                    print("Welcome screen has been shown")
                    UserDefaults.standard.set(true, forKey: "welcomeScreenShown")
                    // close current window when button clicked
                    NSApplication.shared.keyWindow?.close()
                    // show preferences window
                    showPreferences()

                }) {
                    Text("Setup")
                }
            }

        }
    }
}
