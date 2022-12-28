//
//  ContentView.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import SwiftUI

struct ContentView: View {
    private let text: String    

    init(text: String) {
        print("Setting text to", text)
        self.text = text
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            Text(text)
        }
                .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(text: "Default text")
    }
}
