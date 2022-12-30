//
//  ContentView.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import SwiftUI
import Security


struct ContentView: View {
    private let text: String = "Spellbound will give your writing a sparkle!"
    @State private var openaiKey = Keychain.shared.retrieve(key: "openaiKey") ?? ""
    @State private var gumroadKey = Keychain.shared.retrieve(key: "gumroadKey") ?? ""
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            Text(text)

            Spacer()
            VStack {
                HStack {
                    Label("Open AI Key", systemImage: "key.icloud.fill")
                            // fix size
                            .frame(width: 150, alignment: .leading)
                    // link to openai.com
                    // insert input text
                    let color1 = openaiKey != "" ? Color.green : Color.red
                    TextField("Enter OPENAI KEY", text: self.$openaiKey)
                            // add style
                            .frame(width: 300, height: 35)
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding([.horizontal], 4)
                            .cornerRadius(4)
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(color1))
                    .padding([.horizontal], 24)
                }
                Link("How to get Opel AI Key?", destination: URL(string: "https://openai.com")!)
                        .font(.system(size: 10))
                        .frame(alignment: .leading)

            }

            HStack {
                Label("Gumroad licence", systemImage: "key.icloud.fill")
                        .frame(width: 150, alignment: .leading)
                // insert input text
                let color2 = gumroadKey != "" ? Color.green : Color.red
                TextField("Enter Gumroad licence", text: self.$gumroadKey)
                        // add style
                        .frame(width: 300, height: 35)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(4)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(color2))
                        .padding([.horizontal], 24)
            }
            Label("Remember to check your mailbox for your Gumroad licence key!", systemImage: "envelope.fill")
                    // font size small
                    .font(.system(size: 10))

            // add save button
            Button("Save") {
                print("Save button pressed")
                print("Current values are: OpenAI key:", openaiKey, "Gumroad key:", gumroadKey)

                // storing data in keychain
                print("Storing data in keychain")
                let status1 = Keychain.shared.store(key: "openaiKey", value: openaiKey)
                print("OpenAI key stored:", status1)
                let status2 = Keychain.shared.store(key: "gumroadKey", value: gumroadKey)
                print("Gumroad key stored:", status2)

                // check if data is stored
                let openaiKey = Keychain.shared.retrieve(key: "openaiKey")
                let gumroadKey = Keychain.shared.retrieve(key: "gumroadKey")
                print("OpenAI Key retrieved:", openaiKey)
                print("Gumroad Key retrieved:", gumroadKey)


            }
        }
                .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
