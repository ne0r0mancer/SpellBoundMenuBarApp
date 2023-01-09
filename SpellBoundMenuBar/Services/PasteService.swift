//
// Created by ne0r0mancer on 1/9/23.
//

import Foundation
import CoreGraphics
import AppKit

class PasteService {
//    static func paste() {
//        // Accessibility permission is required for paste command from macOS 10.14 Mojave.
//        // For macOS 10.14 and later only, check accessibility permission at startup and paste
//        guard #available(macOS 10.14, *) else {
//            pasteText()
//            return
//        }
//
//        if AccessibilityService.isAccessibilityEnabled(isPrompt: false) {
//            pasteText()
//        } else {
//            AccessibilityService.showAccessibilityAuthenticationAlert()
//        }
//    }

//    private static func pasteText() {
//        let pasteboard = NSPasteboard.general
//        pasteboard.clearContents()
//        pasteboard.setString("Hello World", forType: .string)
//        NSApp.sendAction(#selector(NSResponder.paste(_:)), to: nil, from: nil)
//    }

    static func paste() {
        guard AccessibilityService.isAccessibilityEnabled(isPrompt: false) else {
            AccessibilityService.showAccessibilityAuthenticationAlert()
            return
        }
        let event1 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: true); // cmd-v down
        event1?.flags = CGEventFlags.maskCommand;
        event1?.post(tap: CGEventTapLocation.cghidEventTap);
        let event2 = CGEvent(keyboardEventSource: nil, virtualKey: 0x09, keyDown: false) // cmd-v up
        event2?.post(tap: CGEventTapLocation.cghidEventTap)
    }
    static func writeToPasteboard(with string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(string, forType: .string)
    }
    static func writeToPasteboard(with data: Data, forType type: NSPasteboard.PasteboardType) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([type], owner: nil)
        pasteboard.setData(data, forType: type)
    }
}