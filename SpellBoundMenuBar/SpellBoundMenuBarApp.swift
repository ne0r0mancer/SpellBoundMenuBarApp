//
//  SpellBoundMenuBarApp.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import SwiftUI
import AppKit
import ApplicationServices


@main
struct SpellBoundMenuBarApp: App {
    @State private var isLoading: Bool = false

    func rewriteWithAI(prefix: String, temperature: Float = 0.0, suffix: String = "\nOutput:") {
        isLoading.toggle()

        // check licence key
        let licenceKey = Keychain.shared.retrieve(key: "gumroadKey") ?? ""
        let licenceIsValid = GumroadConnector.shared.verify(gumroadKey: licenceKey)
        if licenceIsValid == false {
            print("Licence is invalid")
            let alert = NSAlert()
            alert.messageText = "Licence is invalid"
            alert.informativeText = "Please enter a valid licence key"
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
            isLoading.toggle()
            return
        }

        // obtain selected text
        AccessibilityHelper().simulateCmdCKeystroke()

        // Wait for the copy action to complete
        usleep(100000)

        let selectedTextFromClipboard = AccessibilityHelper().copyFromClipboard()
        let prompt = selectedTextFromClipboard ?? ""

        print("Prompt detected:", prompt)

        let finalPrompt = prefix + prompt + suffix

//        print("Final prompt:", finalPrompt)

        // make call async
        DispatchQueue.global(qos: .background).async {
            // make call
            let response: String = OpenAIConnector().processPrompt(prompt: finalPrompt, temperature: temperature) ?? "error"
            print("Output detected:", response)
            // copy to clipboard
            AccessibilityHelper().copyToClipboard(text: response)
            // simulate cmd+v keystroke
            AccessibilityHelper().simulateCmdVKeystroke()
            // update UI
            DispatchQueue.main.async {
                isLoading.toggle()
            }
        }
    }

    var body: some Scene {

        WindowGroup {
            WelcomeView()
        }
        MenuBarExtra("SpellBound App", systemImage: isLoading ? "zzz" : "sparkles") {
            VStack(alignment: .leading) {
                Text("Spellbound will give your writing a sparkle!")

                // Correct spelling menu
                Menu {
                    Button("English") {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Correct this to standard English:\nInput:", temperature: 0.2)

                    }

                    Button("Français") {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Corriger ça en français:\nInput:", temperature: 0.2)
                    }
                } label: {
                    Image(systemName: "globe")
                    Text("Correct Grammar")
                }

                // rewrite menu
                Menu {
                    Button("Formal") {
                        print("Formal button pressed")
                        rewriteWithAI(prefix: "Rephrase the following into a highly professional statement,\nInput:", temperature: 0.5)
                    }
                    Button("Friendly") {
                        print("Formal button pressed")
                        rewriteWithAI(prefix: "Rephrase the following into a friendly written statement,\nInput:", temperature: 0.5)
                    }
                    Button("Concise") {
                        print("Concise button pressed")
                        rewriteWithAI(prefix: "Based on the book \"On writing well\" by William Zinsser, rewrite the given text.\nImportant rules: Break long sentences into short sentences. Avoid passive voice. Use clear verbs and nouns. Avoid jargons.\nInput:", temperature: 0.5)
                    }
                    Button("Descriptive") {
                        print("Descriptive button pressed")
                        rewriteWithAI(prefix: "Rephrase the following into a very descriptive written statement,\nInput:", temperature: 0.5)
                    }
                    Button("Poetic") {
                        print("Poetic button pressed")
                        rewriteWithAI(prefix: "Rephrase the following into a very poetic written statement,\nInput:", temperature: 0.5)
                    }
                } label: {
                    Image(systemName: "textformat.abc.dottedunderline")
                    Text("Rephrase ...")
                }


                Button {
                    print("Reply-to pressed")
                    rewriteWithAI(prefix: "Reply to the following email:\nInput:", temperature: 0.3)
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Smart Reply")
                }

                Button {
                    print("Brainstorm")
                    rewriteWithAI(prefix: "", temperature: 0.3, suffix: "")
                } label: {
                    Image(systemName: "lightbulb")
                    Text("Brainstorm")
                }

                // preferences menu
                Button {
                    showPreferences()

                } label: {
                    Image(systemName: "gearshape")
                    Text("Preferences")
                }

                // link to support
                Button {
                    NSWorkspace.shared.open(URL(string: "https://support.spellbound.cc")!)
                } label: {
                    Image(systemName: "link")
                    Text("Help & Support")
                            .foregroundColor(.blue)
                }

                // preferences menu
                Button {
                    // show version
                    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
                    let alert = NSAlert()
                    alert.messageText = "Spellbound \(version ?? "0.0.0") (\(build ?? "0"))"
                    alert.informativeText = "© 2023 Spellbound"
                    alert.alertStyle = .informational
                    alert.addButton(withTitle: "OK")
                    alert.runModal()

                } label: {
                    Image(systemName: "info.circle")
                    Text("About")
                }

                Button("Quit") {
                    NSApp.terminate(nil)
                }


            }

        }
                .menuBarExtraStyle(.menu)
        // on appear


    }
}
