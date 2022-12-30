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

    func rewriteWithAI(prefix: String, temperature: Float = 0.0) {
        isLoading.toggle()

        // obtain selected text
        AccessibilityHelper().simulateCmdCKeystroke()

        // Wait for the copy action to complete
        usleep(100000)

        let selectedTextFromClipboard = AccessibilityHelper().copyFromClipboard()
        let prompt = selectedTextFromClipboard ?? ""

        print("Prompt detected:", prompt)

        let finalPrompt = prefix + prompt + "\nOutput:"

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
        MenuBarExtra("SpellBound App", systemImage: isLoading ? "zzz" : "sparkles") {
            VStack(alignment: .leading) {
                Text("Spellbound will give your writing a sparkle!")

                // Correct other languages
                Menu {
                    Button("English") {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Correct this to standard English:\nInput:", temperature: 0.2)

                    }
                    Button ("Français") {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Corriger ça en français:\nInput:", temperature: 0.2)
                    }
                } label: {
                    Image(systemName: "globe")
                    Text("Correct Grammar")
                }
                // rewrite menu
                Menu{
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
                // settings
                Button{
                    // open new window
                    let window = NSWindow(
                        contentRect: NSRect(x: 0, y: 0, width: 800, height: 800),
                        styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                        backing: .buffered, defer: false)
                    window.center()
                    window.setFrameAutosaveName("Main Window")
                    window.contentView = NSHostingView(rootView: ContentView())
                    // make window modal
                    window.makeKeyAndOrderFront(nil)
                    // resize window to fit the content
                    // https://stackoverflow.com/questions/56810044/how-to-resize-window-to-fit-content-in-swiftui
                    window.setContentSize(window.contentView!.fittingSize)
                    // on close do not quit the app
                    window.isReleasedWhenClosed = false
                    // make window on top of other windows
                    window.level = .floating
                    // disable so the window cannot be maximized
                    window.styleMask.remove(.resizable)


                } label: {
                    Image(systemName: "gearshape")
                    Text("Settings")
                            // color blue
                            .foregroundColor(.blue)
                }

                // link to web version
                Button{
                    NSWorkspace.shared.open(URL(string: "https://help.spellbound.cc")!)
                } label: {
                    Image(systemName: "link")
                    Text("Help")
                    // color blue
                    .foregroundColor(.blue)
                }
                // quit prefixed with icon
                Button("Quit") {
                    NSApp.terminate(nil)
                }


            }

        }
                .menuBarExtraStyle(.menu)

    }
}
