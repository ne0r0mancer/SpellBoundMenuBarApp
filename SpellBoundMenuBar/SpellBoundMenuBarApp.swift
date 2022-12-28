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
    @State private var isIconVisible = true

    fileprivate func rewriteWithAI(prefix: String, temperature: Float = 0.0) {

        // obtain selected text
        AccessibilityHelper().simulateCmdCKeystroke()
        let selectedTextFromClipboard = AccessibilityHelper().copyFromClipboard()
        let prompt = selectedTextFromClipboard ?? ""
        print("Prompt detected:", prompt)
        let finalPrompt = prefix + prompt + "\nOutput:"
        print("Final prompt:", finalPrompt)
        let response: String = OpenAIConnector().processPrompt(prompt: finalPrompt, temparature: temperature) ?? "error"

        // insert corrected text
        print("Output detected:", response)
        AccessibilityHelper().copyToClipboard(text: response)
        AccessibilityHelper().simulateCmdVKeystroke()
    }

    var body: some Scene {
        MenuBarExtra("SpellBound App", systemImage: "scribble.variable") {
            VStack(alignment: .leading) {
                Text("SpellBound makes your writing shine!")
               
                // Correct other languages
                Menu("Correct Grammar") {
                    Button {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Correct this to standard English:\nInput:", temperature: 0.2)


                    } label: {
                        Image(systemName: "pencil.and.outline")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        Text("English")
                    }
                    Button {
                        print("Correct Grammar pressed")
                        rewriteWithAI(prefix: "Corriger ça en français:\nInput:", temperature: 0.2)


                    } label: {
                        Image(systemName: "pencil.and.outline")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        Text("French")
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
