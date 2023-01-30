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

        
        MenuBarExtra("SpellBound App", systemImage: suggestionService.isLoading ? "waveform.path" : "sparkle") {
            VStack(alignment: .leading) {
                Text("SpellBound: Your writing rescue")

                Button {
                    suggestionService.correctGrammar()
                } label: {
                    Image(systemName: "paintbrush.pointed.fill")
                    Text("Grammar Genius")
                }
                        .keyboardShortcut("g")

                // tone menu
                Menu {
                    // formal
                    Button("Formal") {
                        suggestionService.rephraseFormal()

                    }
                            .keyboardShortcut("0")

                    // casual
                    Button("Casual") {
                        suggestionService.rephraseFriendly()

                    }
                            .keyboardShortcut("1")

                    Button("Concise") {
                        suggestionService.rephraseConcise()

                    }
                            .keyboardShortcut("2")
                    Button("Descriptive") {
                        suggestionService.rephraseDescriptive()

                    }
                            .keyboardShortcut("3")

                    // viral
                    Button("Viral") {
                        suggestionService.rephraseViral()

                    }
                            .keyboardShortcut("4")
                    
                    // punchy
                    Button("Punchy") {
                        suggestionService.rephrasePunchy()

                    }
                            .keyboardShortcut("4")

                    // emotional
                    Button("Emotional") {
                        suggestionService.rephraseEmotional()

                    }
                            .keyboardShortcut("5")

                    // inspirational
                    Button("Inspiring") {
                        suggestionService.rephraseInspirational()

                    }
                            .keyboardShortcut("6")

                    // Humorous
                    Button("Humorous") {
                        suggestionService.rephraseHumorous()

                    }
                            .keyboardShortcut("7")

                    // sarcastic
                    Button("Sarcastic") {
                        suggestionService.rephraseSarcastic()

                    }
                            .keyboardShortcut("8")

                } label: {
                    Image(systemName: "bolt.fill")
                    Text("Tone Wizzard")
                }


                Button {
                    suggestionService.continueWriting()
                } label: {
                    Image(systemName: "sparkles")
                    Text("Write On")
                }
                        .keyboardShortcut("w")


                Button {
                    suggestionService.smartReply()
                } label: {
                    Image(systemName: "flame")
                    Text("Quickfire Replies")
                }
                        .keyboardShortcut("r")
                
                Button {
                    suggestionService.rephraseTextToCode()
                } label: {
                    Image(systemName: "number.square.fill")
                    Text("Text to Code")
                }
                        .keyboardShortcut("t")

                // translate menu
                Menu {
                    Button("to English") {
                        suggestionService.translateToEnglish()
                    }

                    Button("to French") {
                        suggestionService.translateToFrench()
                    }

                    // german
                    Button("to German") {
                        suggestionService.translateToGerman()
                    }

                    // spanish
                    Button("to Spanish") {
                        suggestionService.translateToSpanish()
                    }

                    // italian
                    Button("to Italian") {
                        suggestionService.translateToItalian()
                    }

                    // portuguese

                    Button("to Portuguese") {
                        suggestionService.translateToPortuguese()
                    }

                    // chinese

                    Button("to Chinese") {
                        suggestionService.translateToChinese()
                    }

                    // japanese

                    Button("to Japanese") {
                        suggestionService.translateToJapanese()
                    }

                    // korean

                    Button("to Korean") {
                        suggestionService.translateToKorean()
                    }

                    // hindi
                    Button("to Hindi") {
                        suggestionService.translateToHindi()
                    }


                } label: {
                    Image(systemName: "globe")
                    Text("Translate")
                }

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
                    Text("Help")
                }

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
