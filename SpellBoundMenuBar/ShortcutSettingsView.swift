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
                KeyboardShortcuts.Recorder("Global Shortcuts:", name: .historyShortcuts)
            }
                    .padding(.bottom)
        }
    }
}

extension KeyboardShortcuts.Name {
    static let historyShortcuts = Self("commandsShortcuts",
                                       default: .init(.l, modifiers: [.command, .option, .shift]))
}

