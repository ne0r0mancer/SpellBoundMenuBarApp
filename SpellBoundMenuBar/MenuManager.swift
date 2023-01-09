//
// Created by ne0r0mancer on 1/9/23.
//

import Foundation
import Cocoa
import SwiftUI
import AppKit



class MenuManager {

    static var historyMenu: NSMenu?
    static func popupHistoryMenu() {
        historyMenu = NSMenu(title: "SpellBound Pop-Up Menu")
        let labelItem = NSMenuItem(title: "SpellBound", action: nil, keyEquivalent: "")
        labelItem.isEnabled = false
        historyMenu!.addItem(labelItem)
        historyMenu!.addItem(NSMenuItem.separator())

        // add correct grammar submenu
        let correctGrammarMenuItem = NSMenuItem(title: "Correct Grammar", action: nil, keyEquivalent: "g")
        correctGrammarMenuItem.image = NSImage(systemSymbolName: "globe", accessibilityDescription: nil)
        let correctGrammarMenu = NSMenu(title: "Correct Grammar")
        let item1 = NSMenuItem(title: "English", action: #selector(correctEnglish), keyEquivalent: "0")
        item1.target = MenuManager.self
        correctGrammarMenu.addItem(item1)
        let item2 = NSMenuItem(title: "French", action: #selector(correctFrench), keyEquivalent: "1")
        item2.target = MenuManager.self
        correctGrammarMenu.addItem(item2)
        correctGrammarMenuItem.submenu = correctGrammarMenu

        // add rephrase submenu
        let rephraseMenuItem = NSMenuItem(title: "Rephrase", action: nil, keyEquivalent: "r")
        rephraseMenuItem.image = NSImage(systemSymbolName: "arrow.2.circlepath", accessibilityDescription: nil)
        let rephraseMenu = NSMenu(title: "Rephrase")
        // formal
        let item3 = NSMenuItem(title: "Formal", action: #selector(rephraseFormal), keyEquivalent: "2")
        item3.target = MenuManager.self
        rephraseMenu.addItem(item3)
        // friendly
        let item4 = NSMenuItem(title: "Friendly", action: #selector(rephraseFriendly), keyEquivalent: "3")
        item4.target = MenuManager.self
        rephraseMenu.addItem(item4)
        // concise
        let item5 = NSMenuItem(title: "Concise", action: #selector(rephraseConcise), keyEquivalent: "4")
        item5.target = MenuManager.self
        rephraseMenu.addItem(item5)
        // descriptive
        let item6 = NSMenuItem(title: "Descriptive", action: #selector(rephraseDescriptive), keyEquivalent: "5")
        item6.target = MenuManager.self
        rephraseMenu.addItem(item6)
        // poetic
        let item7 = NSMenuItem(title: "Poetic", action: #selector(rephrasePoetic), keyEquivalent: "6")
        item7.target = MenuManager.self
        rephraseMenu.addItem(item7)
        rephraseMenuItem.submenu = rephraseMenu


        historyMenu!.addItem(correctGrammarMenuItem)
        historyMenu!.addItem(rephraseMenuItem)

        // continue writing
        let continueWritingMenuItem = NSMenuItem(title: "Continue ...", action: #selector(continueWriting), keyEquivalent: "c")
        continueWritingMenuItem.image = NSImage(systemSymbolName: "dots.and.line.vertical.and.cursorarrow.rectangle", accessibilityDescription: nil)
        continueWritingMenuItem.target = MenuManager.self
        historyMenu!.addItem(continueWritingMenuItem)

        // smart reply
        let smartReplyMenuItem = NSMenuItem(title: "Smart Reply", action: #selector(smartReply), keyEquivalent: "s")
        smartReplyMenuItem.image = NSImage(systemSymbolName: "arrowshape.turn.up.right", accessibilityDescription: nil)
        smartReplyMenuItem.target = MenuManager.self
        historyMenu!.addItem(smartReplyMenuItem)

        historyMenu!.addItem(NSMenuItem.separator())
        
        historyMenu!.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        historyMenu!.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
    }

    @objc
    static func correctEnglish(_ sender: NSMenuItem) {
        SuggestionsService.correctEnglish()
    }
    
    @objc
    static func correctFrench(_ sender: NSMenuItem) {
        SuggestionsService.correctFrench()
    }

    @objc
    static func rephraseFormal(_ sender: NSMenuItem) {
        SuggestionsService.rephraseFormal()
    }

    @objc
    static func rephraseFriendly(_ sender: NSMenuItem) {
        SuggestionsService.rephraseFriendly()
    }

    @objc
    static func rephraseConcise(_ sender: NSMenuItem) {
        SuggestionsService.rephraseConcise()
    }

    @objc
    static func rephraseDescriptive(_ sender: NSMenuItem) {
        SuggestionsService.rephraseDescriptive()
    }

    @objc
    static func rephrasePoetic(_ sender: NSMenuItem) {
        SuggestionsService.rephrasePoetic()
    }

    @objc
    static func smartReply(_ sender: NSMenuItem) {
        SuggestionsService.smartReply()
    }

    @objc
    static func continueWriting(_ sender: NSMenuItem) {
        SuggestionsService.continueWriting()
    }


}
