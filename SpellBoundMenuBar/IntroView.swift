//
//  ContentView.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import SwiftUI


struct IntroView: View {
    var body: some View {
        VStack {
            Image(systemName: "spellbound")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            Text("Spellbound will give your writing a sparkle!")
            // show image
            Image("intro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
            Text("We hope you will enjoy using our app!")
            
            Button(action: {
                // Navigate to the main app content here
                // Set the value in UserDefaults to indicate that the intro screen has been shown
                print("Introductory screen has been shown")
                UserDefaults.standard.set(true, forKey: "IntroScreenShown")
                // close current window when button clicked
                NSApplication.shared.keyWindow?.close()

            }) {
                Text("Setup")

            }
        }
    }
}
