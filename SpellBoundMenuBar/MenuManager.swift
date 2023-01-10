//
// Created by ne0r0mancer on 1/9/23.
//

import Foundation
import Cocoa
import SwiftUI
import AppKit


class MenuManager{
    var historyMenu: NSMenu?
    var suggestionService = SuggestionsService.shared

    init() {
        historyMenu = NSMenu(title: "SpellBound Pop-Up Menu")
        let labelItem = NSMenuItem(title: "SpellBound", action: nil, keyEquivalent: "")
        labelItem.isEnabled = false
        historyMenu!.addItem(labelItem)
        historyMenu!.addItem(NSMenuItem.separator())

        // add correct grammar submenu
        let correctGrammarMenuItem = NSMenuItem(title: "Correct Grammar", action: nil, keyEquivalent: "g")
        correctGrammarMenuItem.image = NSImage(systemSymbolName: "globe", accessibilityDescription: nil)
        let correctGrammarMenu = NSMenu(title: "Correct Grammar")
        let item1 = NSMenuItem(title: "English", action: #selector(correctEnglish), keyEquivalent: "e")
        item1.target = self
        correctGrammarMenu.addItem(item1)
        let item2 = NSMenuItem(title: "French", action: #selector(correctFrench), keyEquivalent: "f")
        item2.target = self
        correctGrammarMenu.addItem(item2)
        correctGrammarMenuItem.submenu = correctGrammarMenu

        // add rephrase submenu
        let rephraseMenuItem = NSMenuItem(title: "Rephrase", action: nil, keyEquivalent: "r")
        rephraseMenuItem.image = NSImage(systemSymbolName: "arrow.2.circlepath", accessibilityDescription: nil)
        let rephraseMenu = NSMenu(title: "Rephrase ...")
        // formal
        let item3 = NSMenuItem(title: "Formal", action: #selector(rephraseFormal), keyEquivalent: "1")
        item3.target = self
        rephraseMenu.addItem(item3)
        // friendly
        let item4 = NSMenuItem(title: "Friendly", action: #selector(rephraseFriendly), keyEquivalent: "2")
        item4.target = self
        rephraseMenu.addItem(item4)
        // concise
        let item5 = NSMenuItem(title: "Concise", action: #selector(rephraseConcise), keyEquivalent: "3")
        item5.target = self
        rephraseMenu.addItem(item5)
        // descriptive
        let item6 = NSMenuItem(title: "Descriptive", action: #selector(rephraseDescriptive), keyEquivalent: "4")
        item6.target = self
        rephraseMenu.addItem(item6)
        // poetic
        let item7 = NSMenuItem(title: "Poetic", action: #selector(rephrasePoetic), keyEquivalent: "5")
        item7.target = self
        rephraseMenu.addItem(item7)
        rephraseMenuItem.submenu = rephraseMenu


        historyMenu!.addItem(correctGrammarMenuItem)
        historyMenu!.addItem(rephraseMenuItem)

        // continue writing
        let continueWritingMenuItem = NSMenuItem(title: "Continue ...", action: #selector(continueWriting), keyEquivalent: "c")
        continueWritingMenuItem.image = NSImage(systemSymbolName: "dots.and.line.vertical.and.cursorarrow.rectangle", accessibilityDescription: nil)
        continueWritingMenuItem.target = self
        historyMenu!.addItem(continueWritingMenuItem)

        // smart reply
        let smartReplyMenuItem = NSMenuItem(title: "Smart Reply", action: #selector(smartReply), keyEquivalent: "r")
        smartReplyMenuItem.image = NSImage(systemSymbolName: "arrowshape.turn.up.right", accessibilityDescription: nil)
        smartReplyMenuItem.target = self
        historyMenu!.addItem(smartReplyMenuItem)

        historyMenu!.addItem(NSMenuItem.separator())

        historyMenu!.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    }

    func popupHistoryMenu() {
        historyMenu!.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
    }

    @objc
    func correctEnglish(_ sender: NSMenuItem) {
        suggestionService.correctEnglish()
    }

    @objc
    func correctFrench(_ sender: NSMenuItem) {
        suggestionService.correctFrench()
    }

    @objc
    func rephraseFormal(_ sender: NSMenuItem) {
        suggestionService.rephraseFormal()
    }

    @objc
    func rephraseFriendly(_ sender: NSMenuItem) {
        suggestionService.rephraseFriendly()
    }

    @objc
    func rephraseConcise(_ sender: NSMenuItem) {
        suggestionService.rephraseConcise()
    }

    @objc
    func rephraseDescriptive(_ sender: NSMenuItem) {
        suggestionService.rephraseDescriptive()
    }

    @objc
    func rephrasePoetic(_ sender: NSMenuItem) {
        suggestionService.rephrasePoetic()
    }

    @objc
    func smartReply(_ sender: NSMenuItem) {
        suggestionService.smartReply()
    }

    @objc
    func continueWriting(_ sender: NSMenuItem) {
        suggestionService.continueWriting()
    }


}
