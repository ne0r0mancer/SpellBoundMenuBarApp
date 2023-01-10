//
//  SettingsView.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 1/9/23.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case keys, shortcuts, about
    }
    var body: some View {
        TabView {
            KeysView()
                .tabItem {
                    Label("Keys", systemImage: "bubbles.and.sparkles")
                }
                .tag(Tabs.keys)

            ShortcutSettingsView()
                    .tabItem {
                        Label("ShortCuts", systemImage: "gear")
                    }
                    .tag(Tabs.shortcuts)
            
            AboutSettingsView()
                .tabItem {
                    Label("About", systemImage: "timelapse")
                }
                .tag(Tabs.about)
        }
        .padding(20)
        .frame(width: 800, height: 500)
    }
}

