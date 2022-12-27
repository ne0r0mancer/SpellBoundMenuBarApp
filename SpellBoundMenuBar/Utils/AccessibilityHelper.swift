//
//  AccessibilityHelper.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/27/22.
//

import Foundation
import ApplicationServices


// write new struct
struct AccessibilityHelper {
    // write new function
    func getSelectedText() -> String {
        // get selected text
        let selectedText = AXUIElement.focusedElement?.selectedText ?? "not found"
        // return selected text
        return selectedText
        // Get a reference to the UI element that currently has focus
//        let focusedElement = NSAccessibilityFocusedUIElement()
//
//// Check if the focused element is a text field or text view
//        if let textField = focusedElement as? NSTextField,
//           let selectedRange = textField.selectedTextRange {
//            // Get the selected text from the text field
//            let selectedText = textField.stringValue[selectedRange]
//        } else if let textView = focusedElement as? NSTextView,
//                  let selectedRange = textView.selectedTextRange {
//            // Get the selected text from the text view
//            let selectedText = textView.string[selectedRange]
//        }

    }
}

