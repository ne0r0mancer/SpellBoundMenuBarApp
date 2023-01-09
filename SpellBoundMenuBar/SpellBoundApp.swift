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
    @State private var isLoading: Bool = false
    @State private var showFloaterMenu = false
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var dataController = DataController()


    var body: some Scene {
        
        MainScene()
        Settings {
            SettingsView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        MenuBarExtra("SpellBound App", systemImage: isLoading ? "zzz" : "sparkles") {
            VStack(alignment: .leading) {
                Text("Spellbound will give your writing a sparkle!")

                // Correct spelling menu
                Menu {
                    Button("English") {
                        SuggestionsService.correctEnglish()
                    }

                    Button("Français") {
                        SuggestionsService.correctFrench()
                    }
                } label: {
                    Image(systemName: "globe")
                    Text("Correct Grammar")
                }

                // rewrite menu
                Menu {
                    Button("Formal") {
                        SuggestionsService.rephraseFormal()
                    }
                    Button("Friendly") {
                        SuggestionsService.rephraseFriendly()
                    }
                    Button("Concise") {
                        SuggestionsService.rephraseConcise()
                    }
                    Button("Descriptive") {
                        SuggestionsService.rephraseDescriptive()
                    }
                    Button("Poetic") {
                        SuggestionsService.rephrasePoetic()
                    }
                } label: {
                    Image(systemName: "arrow.2.circlepath")
                    Text("Rephrase ...")
                }

                Button {
                    SuggestionsService.continueWriting()
                } label: {
                    Image(systemName: "dots.and.line.vertical.and.cursorarrow.rectangle")
                    Text("Continue ...")
                }


                Button {
                    SuggestionsService.smartReply()
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
                            MenuManager.popupHistoryMenu()
                        }
                    }
                }
                    
                

    }
}
