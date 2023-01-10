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
    @ObservedObject var menuManager = MenuManager()
    @ObservedObject var suggestionService = SuggestionsService()

    var body: some Scene {
        
        MainScene()
        Settings {
            SettingsView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        MenuBarExtra("SpellBound App", systemImage: suggestionService.isLoading ? "zzz" : "sparkles") {
            VStack(alignment: .leading) {
                Text("Spellbound will give your writing a sparkle!")

                // Correct spelling menu
                Menu {
                    Button("English") {
                        print("English")
                        suggestionService.correctEnglish()
                    }
                            // add keyboard shortcut
                            .keyboardShortcut("e", modifiers: [.control, .option, .command])
                    Button("Français") {

                        suggestionService.correctFrench()
                    }
                } label: {
                    Image(systemName: "globe")
                    Text("Correct Grammar")
                }

                // rewrite menu
                Menu {
                    Button("Formal") {
                        suggestionService.rephraseFormal()
                    }
                    Button("Friendly") {
                        suggestionService.rephraseFriendly()
                    }
                    Button("Concise") {
                        suggestionService.rephraseConcise()
                    }
                    Button("Descriptive") {
                        suggestionService.rephraseDescriptive()
                    }
                    Button("Poetic") {
                        suggestionService.rephrasePoetic()
                    }
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


                Button {
                    suggestionService.smartReply()
                } label: {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Smart Reply")
                }

                // preferences menu
                Button {
                    showPreferences()

                } label: {
                    Image(systemName: "gearshape")
                    Text("Preferences")
                }


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
                        KeyboardShortcuts.onKeyDown(for: .historyShortcuts) {
                            print("historyShortcuts pressed")
                            menuManager.popupHistoryMenu()
                        }

                        KeyboardShortcuts.onKeyDown(for: .correctEnglishShortcuts) {
                            print("correctEnglishShortcuts pressed")
                            suggestionService.correctEnglish()
                        }

                        // french
                        KeyboardShortcuts.onKeyDown(for: .correctFrenchShortcuts) {
                            suggestionService.correctFrench()
                        }

                        // smart reply
                        KeyboardShortcuts.onKeyDown(for: .smartReplyShortcuts) {
                            suggestionService.smartReply()
                        }

                        // continue writing
                        KeyboardShortcuts.onKeyDown(for: .continueWritingShortcuts) {
                            suggestionService.continueWriting()
                        }
                    }
                }

                    
                

    }
}
