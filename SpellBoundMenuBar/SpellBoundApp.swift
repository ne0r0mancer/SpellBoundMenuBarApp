//
//  SpellBoundMenuBarApp.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/26/22.
//

import SwiftUI
import AppKit
import ApplicationServices
import Combine
import AVFoundation
import KeyboardShortcuts


@main
struct SpellBoundMenuBarApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var dataController = DataController()
    @ObservedObject var suggestionService = SuggestionsService.shared
    var menuManager = MenuManager()

    var body: some Scene {

        MainScene()
        Settings {
            SettingsView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
        }

        
        MenuBarExtra("SpellBound App", systemImage: suggestionService.isLoading ? "bubbles.and.sparkles" : "sparkle") {
            VStack(alignment: .leading) {
                Text("Spellbound will give your writing a sparkle!")

                // Correct spelling menu
                Menu {
                    Button("English") {
                        print("English")
                        suggestionService.correctEnglish()
                    }
                            // add keyboard shortcut
                            .keyboardShortcut("e")
                    Button("Français") {

                        suggestionService.correctFrench()

                    }
                            .keyboardShortcut("f")
                } label: {
                    Image(systemName: "globe")
                    Text("Correct Grammar")
                }

                // rewrite menu
                Menu {
                    Button("Formal") {
                        suggestionService.rephraseFormal()

                    }
                            .keyboardShortcut("1")
                    Button("Friendly") {
                        suggestionService.rephraseFriendly()

                    }
                            .keyboardShortcut("2")
                    Button("Concise") {
                        suggestionService.rephraseConcise()

                    }
                            .keyboardShortcut("3")
                    Button("Descriptive") {
                        suggestionService.rephraseDescriptive()

                    }
                            .keyboardShortcut("4")
                    Button("Poetic") {
                        suggestionService.rephrasePoetic()

                    }
                            .keyboardShortcut("5")
                } label: {
                    Image(systemName: "arrow.2.circlepath")
                    Text("Rephrase ...")
                }

                Button {
                    suggestionService.continueWriting()
                } label: {
                    Image(systemName: "dots.and.line.vertical.and.cursorarrow.rectangle")
                    Text("Continue ...")
                }
                        .keyboardShortcut("c")


                Button {
                    suggestionService.smartReply()
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Smart Reply")
                }
                        .keyboardShortcut("r")

                // preferences menu
                Button {
                    showPreferences()

                } label: {
                    Image(systemName: "gearshape")
                    Text("Preferences")
                }
                        .keyboardShortcut(",")


                // link to support
                Button {
                    NSWorkspace.shared.open(URL(string: "https://support.spellbound.cc")!)
                } label: {
                    Image(systemName: "link")
                    Text("Help & Support")
                            .foregroundColor(.blue)
                }

                Divider()
                Button("Quit") {
                    NSApp.terminate(nil)
                }
                        .keyboardShortcut("q")


            }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
                    .edgesIgnoringSafeArea(.all)

        }
                .onChange(of: scenePhase) { phase in
                    print("phase: \(phase)")
                    if phase == .active {
                        AccessibilityService.isAccessibilityEnabled(isPrompt: true)
                        
                        KeyboardShortcuts.onKeyDown(for: .quickMenuShortcuts) {
                            print("historyShortcuts pressed")
                            menuManager.popupHistoryMenu()
                        }
                    }
                }


    }
}
