//
//  GeneralSettingsView.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 1/9/23.
//

import SwiftUI
import AVFoundation
import LaunchAtLogin
import KeyboardShortcuts
import Combine

struct ShortcutSettingsView: View {
    var body: some View {
        Form {
            Section {
                LaunchAtLogin.Toggle("Launch at login")
            }
                    .padding(.bottom)
            Section {
                KeyboardShortcuts.Recorder("Quick Menu Shortcut:", name: .historyShortcuts)
                KeyboardShortcuts.Recorder("Correct To English Shortcut:", name: .correctEnglishShortcuts)
                KeyboardShortcuts.Recorder("Correct To French Shortcut:", name: .correctFrenchShortcuts)
                KeyboardShortcuts.Recorder("Smart Reply Shortcut:", name: .smartReplyShortcuts)
                KeyboardShortcuts.Recorder("Continue Writing Shortcut:", name: .continueWritingShortcuts)

            }
                    .padding(.bottom)
        }
    }
}

extension KeyboardShortcuts.Name {
    static let historyShortcuts = Self("commandsShortcuts",
                                       default: .init(.i, modifiers: [.control, .shift]))
    static let correctEnglishShortcuts = Self("correctEnglishShortcuts",
                                     default: .init(.e, modifiers: [.control, .shift]))
    // french
    static let correctFrenchShortcuts = Self("correctFrenchShortcuts",
                                     default: .init(.f, modifiers: [.control, .shift]))

    // smart reply
    static let smartReplyShortcuts = Self("smartReplyShortcuts",
                                     default: .init(.r, modifiers: [.control, .shift]))

    // continue writing
    static let continueWritingShortcuts = Self("continueWritingShortcuts",
                                     default: .init(.c, modifiers: [.control, .shift]))
}

