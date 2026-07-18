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


    // text to code
    func rephraseTextToCode() {
        suggest(prefix: "Write a code snippet that does the following,\nInput:", temperature: 0.5)
    }

    // concise
    func rephraseConcise() {
        suggest(prefix: "Based on the book \"On writing well\" by William Zinsser, rewrite the given text.\nImportant rules: Break long sentences into short sentences. Avoid passive voice. Use clear verbs and nouns. Avoid jargons.\nInput:", temperature: 0.5)
    }
    
    // punchy
    func rephrasePunchy() {
        suggest(prefix: "Rewrite the given text emulating the style of author and copywriter Dave Trott.\nInput:", temperature: 0.5)
    }

    // descriptive
    func rephraseDescriptive() {
        suggest(prefix: "Rephrase the following into a very poetic written statement,\nInput:", temperature: 0.5)
    }

    // Persuasive
    func rephrasePersuasive() {
        suggest(prefix: "Rephrase the following into a very persuasive written statement,\nInput:", temperature: 0.5)
    }

    // casual
    func rephraseCasual() {
        suggest(prefix: "Rephrase the following into a very casual written statement,\nInput:", temperature: 0.5)
    }

    // humorous
    func rephraseHumorous() {
        suggest(prefix: "Rephrase the following into a very humorous written statement,\nInput:", temperature: 0.5)
    }

    // emotional
    func rephraseEmotional() {
        suggest(prefix: "Rephrase the following into a very emotional written statement,\nInput:", temperature: 0.5)
    }

    // Inspirational
    func rephraseInspirational() {
        suggest(prefix: "Rephrase the following into a very inspirational written statement,\nInput:", temperature: 0.5)
    }

    // Sarcastic
    func rephraseSarcastic() {
        suggest(prefix: "Rephrase the following into a very sarcastic written statement,\nInput:", temperature: 0.5)
    }

    // Thoughtful
    func rephraseThoughtful() {
        suggest(prefix: "Rephrase the following into a very thoughtful written statement,\nInput:", temperature: 0.5)
    }

    // viral
    func rephraseViral() {
        suggest(prefix: "Rephrase the following into a very viral written statement,\nInput:", temperature: 0.5)
    }


    func correctGrammar() {
        suggest(prefix: "Сorrect grammar and spelling mistakes:,\nInput:", temperature: 0.5)
    }

    func smartReply() {
        suggest(prefix: "Reply to the following email:\nInput:", temperature: 0.3)
    }

    func continueWriting() {
        suggest(prefix: "", temperature: 0.3, suffix: "")
    }

    // translate
    func translateToEnglish() {
        suggest(prefix: "Translate the following text into English:\nInput:", temperature: 0.5)
    }

    // French
    func translateToFrench() {
        suggest(prefix: "Translate the following text into French:\nInput:", temperature: 0.5)
    }

    // German
    func translateToGerman() {
        suggest(prefix: "Translate the following text into German:\nInput:", temperature: 0.5)
    }

    // Spanish
    func translateToSpanish() {
        suggest(prefix: "Translate the following text into Spanish:\nInput:", temperature: 0.5)
    }

    // Italian
    func translateToItalian() {
        suggest(prefix: "Translate the following text into Italian:\nInput:", temperature: 0.5)
    }

    // Chinese
    func translateToChinese() {
        suggest(prefix: "Translate the following text into Chinese:\nInput:", temperature: 0.5)
    }

    // Japanese
    func translateToJapanese() {
        suggest(prefix: "Translate the following text into Japanese:\nInput:", temperature: 0.5)
    }

    // Hindi
    func translateToHindi() {
        suggest(prefix: "Translate the following text into Hindi:\nInput:", temperature: 0.5)
    }

    // Korean

    func translateToKorean() {
        suggest(prefix: "Translate the following text into Korean:\nInput:", temperature: 0.5)
    }

    // Portuguese

    func translateToPortuguese() {
        suggest(prefix: "Translate the following text into Portuguese:\nInput:", temperature: 0.5)
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

        #if DEBUG
        print("Prompt detected:", prompt)
        #endif

        let finalPrompt = prefix + prompt + suffix

        // make call async
        DispatchQueue.global(qos: .background).async {

            //1. check licence key is valid
            let licenseIsValid = GumroadConnector.shared.verifyMembershipWithFallback(gumroadKey: licenceKey)
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
            #if DEBUG
            print("Output detected:", response)
            #endif
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
