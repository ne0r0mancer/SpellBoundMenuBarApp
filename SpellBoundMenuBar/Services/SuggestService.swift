//
// Created by ne0r0mancer on 1/9/23.
//

import Foundation

class SuggestionsService {

    // rephrase

    /**
                     // rewrite menu
                Menu {
                    Button("Formal") {
                        SuggestionsService.suggest(prefix: "Rephrase the following into a highly professional statement,\nInput:", temperature: 0.5)
                    }
                    Button("Friendly") {
                        SuggestionsService.suggest(prefix: "Rephrase the following into a friendly written statement,\nInput:", temperature: 0.5)
                    }
                    Button("Concise") {
                        SuggestionsService.suggest(prefix: "Based on the book \"On writing well\" by William Zinsser, rewrite the given text.\nImportant rules: Break long sentences into short sentences. Avoid passive voice. Use clear verbs and nouns. Avoid jargons.\nInput:", temperature: 0.5)
                    }
                    Button("Descriptive") {
                        SuggestionsService.suggest(prefix: "Rephrase the following into a very descriptive written statement,\nInput:", temperature: 0.5)
                    }
                    Button("Poetic") {
                        SuggestionsService.suggest(prefix: "Rephrase the following into a very poetic written statement,\nInput:", temperature: 0.5)
                    }
                } label: {
                    Image(systemName: "textformat.abc.dottedunderline")
                    Text("Rephrase ...")
                }


                Button {
                    print("Reply-to pressed")
                    SuggestionsService.suggest(prefix: "Reply to the following email:\nInput:", temperature: 0.3)
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Smart Reply")
                }

                Button {
                    print("Brainstorm")
                    SuggestionsService.suggest(prefix: "", temperature: 0.3, suffix: "")
                } label: {
                    Image(systemName: "lightbulb")
                    Text("Brainstorm")
                }

     */

    // formal
    static func rephraseFormal() {
        suggest(prefix: "Rephrase the following into a highly professional statement,\nInput:", temperature: 0.5)
    }
    // friendly
    static func rephraseFriendly() {
        suggest(prefix: "Rephrase the following into a friendly written statement,\nInput:", temperature: 0.5)
    }

    // poetic
    static func rephrasePoetic() {
        suggest(prefix: "Rephrase the following into a very poetic written statement,\nInput:", temperature: 0.5)
    }


    // concise
    static func rephraseConcise() {
        suggest(prefix: "Based on the book \"On writing well\" by William Zinsser, rewrite the given text.\nImportant rules: Break long sentences into short sentences. Avoid passive voice. Use clear verbs and nouns. Avoid jargons.\nInput:", temperature: 0.5)
    }

    // descriptive
    static func rephraseDescriptive() {
        suggest(prefix: "Rephrase the following into a very poetic written statement,\nInput:", temperature: 0.5)
    }


    static func correctEnglish() {
        suggest(prefix: "Correct this to standard English:\nInput:", temperature: 0.2)
    }

    static func correctFrench() {
        suggest(prefix: "Corriger ça en français:\nInput:", temperature: 0.2)
    }

    static func smartReply() {
        suggest(prefix: "Reply to the following email:\nInput:", temperature: 0.3)
    }

    static func continueWriting() {
        suggest(prefix: "", temperature: 0.3, suffix: "")
    }

    static func suggest(prefix: String, temperature: Float = 0.0, suffix: String = "\nOutput:") {

        // check licence key
        let licenceKey = Keychain.shared.retrieve(key: "gumroadKey") ?? ""
//        let licenceIsValid = GumroadConnector.shared.verify(gumroadKey: licenceKey)
//        if licenceIsValid == false {
//            print("Licence is invalid")
//            let alert = NSAlert()
//            alert.messageText = "Licence is invalid"
//            alert.informativeText = "Please enter a valid licence key"
//            alert.alertStyle = .warning
//            alert.addButton(withTitle: "OK")
//            alert.runModal()
//            isLoading.toggle()
//            return
//        }

        // obtain selected text
        AccessibilityHelper.simulateCmdCKeystroke()

        // Wait for the copy action to complete
        usleep(100000)

        let selectedTextFromClipboard = AccessibilityHelper.copyFromClipboard()
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
            AccessibilityHelper.copyToClipboard(text: response)
            // simulate cmd+v keystroke
            AccessibilityHelper.simulateCmdVKeystroke()
        }
    }
}