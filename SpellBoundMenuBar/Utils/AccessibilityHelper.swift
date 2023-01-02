//
//  AccessibilityHelper.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/27/22.
//

import Foundation
import ApplicationServices
import Cocoa
import Accessibility
import CoreGraphics


// write new struct
struct AccessibilityHelper {
    // write new function
    func getSelectedText() -> String {
        // get selected text
        let selectedText = AXUIElement.focusedElement?.selectedText ?? "not found"
        // return selected text
        return selectedText
    }

    func copyFromClipboard() -> String? {
        let pasteboard = NSPasteboard.general
        if let pasteboardString = pasteboard.string(forType: .string) {
            return pasteboardString
        }
        return nil
    }

    func copyToClipboard(text: String) {
        // Get the general pasteboard
        let pasteboard = NSPasteboard.general

        // Clear the pasteboard
        pasteboard.clearContents()

        // Write the text to the pasteboard
        pasteboard.writeObjects([text as NSPasteboardWriting])
    }

    func simulateCmdVKeystroke() {
        // Create a "cmd" keydown event
        let cmdDown = CGEvent(keyboardEventSource: nil, virtualKey: 55, keyDown: true)!
        cmdDown.flags = .maskCommand
        cmdDown.post(tap: .cghidEventTap)

        // Create a "v" keydown event
        let vDown = CGEvent(keyboardEventSource: nil, virtualKey: 9, keyDown: true)!
        vDown.flags = .maskCommand
        vDown.post(tap: .cghidEventTap)

        // Create a "v" keyup event
        let vUp = CGEvent(keyboardEventSource: nil, virtualKey: 9, keyDown: false)!
        vUp.flags = .maskCommand
        vUp.post(tap: .cghidEventTap)

        // Create a "cmd" keyup event
        let cmdUp = CGEvent(keyboardEventSource: nil, virtualKey: 55, keyDown: false)!
        cmdUp.flags = .maskCommand
        cmdUp.post(tap: .cghidEventTap)
    }


    func simulateCmdCKeystroke() {
        // Create a "cmd" keydown event
        let cmdDown = CGEvent(keyboardEventSource: nil, virtualKey: 55, keyDown: true)!
        cmdDown.flags = .maskCommand
        cmdDown.post(tap: .cghidEventTap)

        // Create a "c" keydown event
        let cDown = CGEvent(keyboardEventSource: nil, virtualKey: 8, keyDown: true)!
        cDown.flags = .maskCommand
        cDown.post(tap: .cghidEventTap)

        // Create a "c" keyup event
        let cUp = CGEvent(keyboardEventSource: nil, virtualKey: 8, keyDown: false)!
        cUp.flags = .maskCommand
        cUp.post(tap: .cghidEventTap)

        // Create a "cmd" keyup event
        let cmdUp = CGEvent(keyboardEventSource: nil, virtualKey: 55, keyDown: false)!
        cmdUp.flags = .maskCommand
        cmdUp.post(tap: .cghidEventTap)
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
        guard let rawValue = rawValue(for: attribute), CFGetTypeID(rawValue) == AXUIElementGetTypeID() else {
            return nil
        }
        return (rawValue as! AXUIElement)
    }

    private func rawValue(for attribute: String) -> AnyObject? {
        var rawValue: AnyObject?
        let error = AXUIElementCopyAttributeValue(self, attribute as CFString, &rawValue)
        return error == .success ? rawValue : nil
    }


}
