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
    var body: some Scene {
        MenuBarExtra("SpellBound App", systemImage: "scribble.variable") {
            VStack(alignment: .leading) {
                Text("SpellBound makes your writing shine!")
                Button {
                    print("Button pressed")
                    // FIXME copy selected text
                    // copy select text to clipboard
//                    let value = NSAccessibilityProtocol.accessibilitySelectedText(T##self: NSAccessibilityProtocol##NSAccessibilityProtocol)
                    let selectedText = AccessibilityHelper().getSelectedText()
                    print("Value found:", selectedText)
                    print("Value found:", AXUIElement.focusedElement?.selectedText as Any)

//                    let response: String? = OpenAIConnector().processPrompt(prompt: "Please correct my text ...")
//                    
//                    // insert corrected text
//                    print(String(describing: response))
                    
                    

                } label: {
                    Image(systemName: "pencil.and.outline")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Correct Grammar")
                }
                // clickable menu
                Menu("Rewrite ...") {
                    Button ("Shorter") {
                        print("Rewrite button pressed")
                    }
                    Button ("Confident") {
                        print("Rewrite button pressed")
                    }
                    Button ("Friendly") {
                        print("Rewrite button pressed")
                    }
                    Button ("Formal") {
                        print("Rewrite button pressed")
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

extension AXUIElement {
    static var focusedElement: AXUIElement? {
        systemWide.element(for: kAXFocusedUIElementAttribute)
    }

    var selectedText: String? {
        rawValue(for: kAXSelectedTextAttribute) as? String
    }

    private static var systemWide = AXUIElementCreateSystemWide()

    private func element(for attribute: String) -> AXUIElement? {
        guard let rawValue = rawValue(for: attribute), CFGetTypeID(rawValue) == AXUIElementGetTypeID() else { return nil }
        return (rawValue as! AXUIElement)
    }

    private func rawValue(for attribute: String) -> AnyObject? {
        var rawValue: AnyObject?
        let error = AXUIElementCopyAttributeValue(self, attribute as CFString, &rawValue)
        return error == .success ? rawValue : nil
    }
}
