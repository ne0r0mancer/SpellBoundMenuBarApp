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
        let selectedTextFromClipboard = AccessibilityHelper().copyFromClipboard()
        let prompt = selectedTextFromClipboard ?? ""
        print("Prompt detected:", prompt)
        let finalPrompt = prefix + prompt + "\nOutput:"
        print("Final prompt:", finalPrompt)
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
        MenuBarExtra("SpellBound App", systemImage: isLoading ? "timelapse" : "scribble.variable") {
            VStack(alignment: .leading) {
                Text("SpellBound makes your writing shine!")
                
                // Correct other languages
                Menu("Correct Grammar") {
                    Button ("English") {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Correct this to standard English:\nInput:", temperature: 0.2)

                    }
                    Button ("French") {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Corriger ça en français:\nInput:", temperature: 0.2)


                    }
                }
                // rewrite menu
                Menu("Rewrite ...") {
                    Button("Formal") {
                        print("Formal button pressed")
                        rewriteWithAI(prefix: "Rephrase the following into a highly professional statement,\nInput:", temperature: 0.5)
                    }
                    Button("Friendly") {
                        print("Formal button pressed")
                        rewriteWithAI(prefix: "Rephrase the following into a friendly written statement,\nInput:", temperature: 0.5)
                    }
                    Button("Zinsser") {
                        print("Zinsser button pressed")
                        rewriteWithAI(prefix: "Based on the book \"On writing well\" by William Zinsser, rewrite the given text.\nImportant rules: Break long sentences into short sentences. Avoid passive voice. Use clear verbs and nouns. Avoid jargons.\nInput:", temperature: 0.5)
                    }
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
