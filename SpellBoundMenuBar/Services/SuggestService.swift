//
// Created by ne0r0mancer on 1/9/23.
//

import Foundation
import SwiftUI

class SuggestionsService: ObservableObject {
    static let shared = SuggestionsService()

    private init() {
    }

    @Published var isLoading = false

    // formal
    func rephraseFormal() {
        suggest(prefix: "Rephrase the following into a highly professional statement,\nInput:", temperature: 0.5)
    }

    // friendly
    func rephraseFriendly() {
        suggest(prefix: "Rephrase the following into a friendly written statement,\nInput:", temperature: 0.5)
    }

    // poetic
    func rephrasePoetic() {
        suggest(prefix: "Rephrase the following into a very poetic written statement,\nInput:", temperature: 0.5)
    }


    // concise
    func rephraseConcise() {
        suggest(prefix: "Based on the book \"On writing well\" by William Zinsser, rewrite the given text.\nImportant rules: Break long sentences into short sentences. Avoid passive voice. Use clear verbs and nouns. Avoid jargons.\nInput:", temperature: 0.5)
    }

    // descriptive
    func rephraseDescriptive() {
        suggest(prefix: "Rephrase the following into a very poetic written statement,\nInput:", temperature: 0.5)
    }


    func correctEnglish() {
        suggest(prefix: "Correct this to standard English:\nInput:", temperature: 0.2)
    }

    func correctFrench() {
        suggest(prefix: "Corriger ça en français:\nInput:", temperature: 0.2)
    }

    func smartReply() {
        suggest(prefix: "Reply to the following email:\nInput:", temperature: 0.3)
    }

    func continueWriting() {
        suggest(prefix: "", temperature: 0.3, suffix: "")
    }

    func suggest(prefix: String, temperature: Float = 0.0, suffix: String = "\nOutput:") {

        // Start loading
        self.isLoading.toggle()
        print("Loading started")

        
        let licenceKey = Keychain.shared.retrieve(key: "gumroadKey") ?? ""

        // obtain selected text
        AccessibilityHelper.simulateCmdCKeystroke()

        // Wait for the copy action to complete
        usleep(100000)

        let selectedTextFromClipboard = AccessibilityHelper.copyFromClipboard()
        let prompt = selectedTextFromClipboard ?? ""

        print("Prompt detected:", prompt)

        let finalPrompt = prefix + prompt + suffix

        // make call async
        DispatchQueue.global(qos: .background).async {

            //1. check licence key is valid
            let licenseIsValid = GumroadConnector.shared.verify(gumroadKey: licenceKey)
            if licenseIsValid {
                print("Licence is VALID")
            } else {
                print("Licence is INVALID")
                LicenseExpiredListener.shared.licenseExpired()
                // toggle isLoading
                self.isLoading.toggle()
                return
            }

            // 2. make call to API
            let response: String = OpenAIConnector().processPrompt(prompt: finalPrompt, temperature: temperature) ?? "error"
            print("Output detected:", response)
            // copy to clipboard
            AccessibilityHelper.copyToClipboard(text: response)
            // simulate cmd+v keystroke
            AccessibilityHelper.simulateCmdVKeystroke()
            // update UI
            DispatchQueue.main.async {
                self.isLoading.toggle()
                print("Loading finished")
            }
        }

    }
}
