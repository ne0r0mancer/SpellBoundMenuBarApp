//
//  ContentView.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import SwiftUI
import Security


struct KeysView: View {
    private let text: String = "Spellbound will give your writing a sparkle!"
    @State private var openaiKey = Keychain.shared.retrieve(key: "openaiKey") ?? ""
    @State private var gumroadKey = Keychain.shared.retrieve(key: "gumroadKey") ?? ""
    @State private var gumroadKeyIsValid = true // by default it is valid, will be re-evaluated on change
    @State private var isLoading: Bool = false
    @State private var saveDisabled: Bool = false

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
                            // change saved state
                            .onChange(of: openaiKey, perform: { value in
                                print("openaiKey changed to \(value)")
                                // disable save button if key is empty
                                self.saveDisabled = false
                            })
                }
                Link("How to get Opel AI Key?", destination: URL(string: "https://support.spellbound.cc/docs/help/how-to-create-openai-token/")!)
                        .font(.system(size: 10))
                        .frame(alignment: .leading)

            }

            HStack {
                Label("Gumroad licence", systemImage: "key.icloud.fill")
                        .frame(width: 150, alignment: .leading)
                // insert input text
                let color2 = (gumroadKey != "" && gumroadKeyIsValid) ? Color.green : Color.red
                TextField("Enter Gumroad licence", text: self.$gumroadKey)
                        // add style
                        .frame(width: 300, height: 35)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.horizontal], 4)
                        .cornerRadius(4)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(color2))
                        .padding([.horizontal], 24)
                        .onChange(of: gumroadKey, perform: { value in
                            print("Gumroad key changed to \(value)")
                            self.saveDisabled = false
                        })
            }
            Label("Remember to check your mailbox for your Gumroad licence key!", systemImage: "envelope.fill")
                    // font size small
                    .font(.system(size: 10))

            // add save button
            Button("Save") {
                print("Save button pressed")
                print("Current values are: OpenAI key:", openaiKey, "Gumroad key:", gumroadKey)

                // check gumroad key
                if (gumroadKey != "") {
                    print("Checking Gumroad key")

                    // check gumroadKey key now
                    // change if we want to check it on save
                    let checkGumroadKey = true
                    gumroadKeyIsValid = GumroadConnector.shared.verify(gumroadKey: gumroadKey)


                    // save keys to keychain
                    do {
                        // storing data in keychain
                        try Keychain.shared.store(key: "openaiKey", value: openaiKey)
                        try Keychain.shared.store(key: "gumroadKey", value: gumroadKey)

                    } catch {
                        print("Error saving key to keychain")
                    }

                    if gumroadKeyIsValid {
                        print("Gumroad key is valid")
                    } else {
                        print("Gumroad key is invalid")
                        // show alert
//                        let alert = NSAlert()
//                        alert.messageText = "Gumroad key is invalid"
//                        alert.informativeText = "Please check your Gumroad key and try again."
//                        alert.alertStyle = .warning
//                        alert.addButton(withTitle: "OK")
//                        alert.runModal()
                    }
                } else {
                    print("Gumroad key is empty")
                    self.saveDisabled = false
                }

                // disable save button
                saveDisabled = true

            }
                    // disable save button if no keys are entered
                    .disabled(openaiKey == "" || gumroadKey == "" || saveDisabled)
                    .onAppear {
                        // check if keys are valid
                        if (gumroadKey != "") {
                            print("Checking Gumroad key")
                            gumroadKeyIsValid = GumroadConnector.shared.verify(gumroadKey: gumroadKey)

                        }

                    }
        }
                .padding()
    }
}

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                KeysView()
            }
        }
