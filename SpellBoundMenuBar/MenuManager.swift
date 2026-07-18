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


        // correct grammar
        let correctGrammarMenuItem = NSMenuItem(title: "Grammar Genius", action: #selector(correctGrammar), keyEquivalent: "g")
        correctGrammarMenuItem.image = NSImage(systemSymbolName: "paintbrush.pointed.fill", accessibilityDescription: nil)
        correctGrammarMenuItem.target = self
        historyMenu!.addItem(correctGrammarMenuItem)


        // add rephrase submenu
        let rephraseMenuItem = NSMenuItem(title: "Tone Wizzard", action: nil, keyEquivalent: "r")
        rephraseMenuItem.image = NSImage(systemSymbolName: "bolt.fill", accessibilityDescription: nil)
        let rephraseMenu = NSMenu(title: "Tone Wizzard")
        // formal
        let item3 = NSMenuItem(title: "Formal", action: #selector(rephraseFormal), keyEquivalent: "1")
        item3.target = self
        rephraseMenu.addItem(item3)
        // friendly
        let item4 = NSMenuItem(title: "Casual", action: #selector(rephraseFriendly), keyEquivalent: "2")
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

        // viral
        let item7 = NSMenuItem(title: "Viral", action: #selector(rephraseViral), keyEquivalent: "5")
        item7.target = self
        rephraseMenu.addItem(item7)

        // emotional
        let item8 = NSMenuItem(title: "Emotional", action: #selector(rephraseEmotional), keyEquivalent: "6")
        item8.target = self
        rephraseMenu.addItem(item8)

        // inspiring
        let item9 = NSMenuItem(title: "Inspiring", action: #selector(rephraseInspiring), keyEquivalent: "7")
        item9.target = self
        rephraseMenu.addItem(item9)

        // humorous
        let item10 = NSMenuItem(title: "Humorous", action: #selector(rephraseHumorous), keyEquivalent: "8")
        item10.target = self
        rephraseMenu.addItem(item10)

        // sarcastic
        let item11 = NSMenuItem(title: "Sarcastic", action: #selector(rephraseSarcastic), keyEquivalent: "9")
        item11.target = self
        rephraseMenu.addItem(item11)

        // poetic
        let item12 = NSMenuItem(title: "Poetic", action: #selector(rephrasePoetic), keyEquivalent: "0")
        item12.target = self
        rephraseMenu.addItem(item12)
        rephraseMenuItem.submenu = rephraseMenu

        historyMenu!.addItem(rephraseMenuItem)

        // continue writing
        let continueWritingMenuItem = NSMenuItem(title: "Write on", action: #selector(continueWriting), keyEquivalent: "w")
        continueWritingMenuItem.image = NSImage(systemSymbolName: "sparkles", accessibilityDescription: nil)
        continueWritingMenuItem.target = self
        historyMenu!.addItem(continueWritingMenuItem)

        // smart reply
        let smartReplyMenuItem = NSMenuItem(title: "Quickfire Replies", action: #selector(smartReply), keyEquivalent: "r")
        smartReplyMenuItem.image = NSImage(systemSymbolName: "flame", accessibilityDescription: nil)
        smartReplyMenuItem.target = self
        historyMenu!.addItem(smartReplyMenuItem)

        // text to code
        let textToCodeMenuItem = NSMenuItem(title: "Text to Code", action: #selector(textToCode), keyEquivalent: "t")
        textToCodeMenuItem.image = NSImage(systemSymbolName: "number.square.fill", accessibilityDescription: nil)
        textToCodeMenuItem.target = self
        historyMenu!.addItem(textToCodeMenuItem)

        // translate menu
        let translateMenuItem = NSMenuItem(title: "Translate", action: nil, keyEquivalent: "r")
        translateMenuItem.image = NSImage(systemSymbolName: "globe", accessibilityDescription: nil)
        let translateMenu = NSMenu(title: "Translate")

        // to English
        let translateMenuItemEnglish = NSMenuItem(title: "to English", action: #selector(toEnglish), keyEquivalent: "1")
        translateMenuItemEnglish.target = self
        translateMenu.addItem(translateMenuItemEnglish)

        // to French
        let translateMenuItemFrench = NSMenuItem(title: "to French", action: #selector(toFrench), keyEquivalent: "2")
        translateMenuItemFrench.target = self
        translateMenu.addItem(translateMenuItemFrench)

        // to German
        let translateMenuItemGerman = NSMenuItem(title: "to German", action: #selector(toGerman), keyEquivalent: "3")
        translateMenuItemGerman.target = self
        translateMenu.addItem(translateMenuItemGerman)

        // to Spanish
        let translateMenuItemSpanish = NSMenuItem(title: "to Spanish", action: #selector(toSpanish), keyEquivalent: "4")
        translateMenuItemSpanish.target = self
        translateMenu.addItem(translateMenuItemSpanish)

        // to Italian
        let translateMenuItemItalian = NSMenuItem(title: "to Italian", action: #selector(toItalian), keyEquivalent: "5")
        translateMenuItemItalian.target = self
        translateMenu.addItem(translateMenuItemItalian)

        // to Portuguese
        let translateMenuItemPortuguese = NSMenuItem(title: "to Portuguese", action: #selector(toPortuguese), keyEquivalent: "6")
        translateMenuItemPortuguese.target = self
        translateMenu.addItem(translateMenuItemPortuguese)

        // to Chinese
        let translateMenuItemChinese = NSMenuItem(title: "to Chinese", action: #selector(toChinese), keyEquivalent: "7")
        translateMenuItemChinese.target = self
        translateMenu.addItem(translateMenuItemChinese)

        // to Japanese
        let translateMenuItemJapanese = NSMenuItem(title: "to Japanese", action: #selector(toJapanese), keyEquivalent: "8")
        translateMenuItemJapanese.target = self
        translateMenu.addItem(translateMenuItemJapanese)

        // to Korean
        let translateMenuItemKorean = NSMenuItem(title: "to Korean", action: #selector(toKorean), keyEquivalent: "9")
        translateMenuItemKorean.target = self
        translateMenu.addItem(translateMenuItemKorean)

        // to Hindi
        let translateMenuItemHindi = NSMenuItem(title: "to Hindi", action: #selector(toHindi), keyEquivalent: "0")
        translateMenuItemHindi.target = self
        translateMenu.addItem(translateMenuItemHindi)


        translateMenuItem.submenu = translateMenu

        historyMenu!.addItem(translateMenuItem)


        historyMenu!.addItem(NSMenuItem.separator())

        historyMenu!.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    }

    func popupHistoryMenu() {
        historyMenu!.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)
    }

    @objc
    func correctGrammar(_ sender: NSMenuItem) {
        suggestionService.correctGrammar()
    }

    // tones
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

    // viral
    @objc
    func rephraseViral(_ sender: NSMenuItem) {
        suggestionService.rephraseViral()
    }

    // inspiring
    @objc
    func rephraseInspiring(_ sender: NSMenuItem) {
        suggestionService.rephraseInspirational()
    }

    // humorous
    @objc
    func rephraseHumorous(_ sender: NSMenuItem) {
        suggestionService.rephraseHumorous()
    }

    // sarcastic
    @objc
    func rephraseSarcastic(_ sender: NSMenuItem) {
        suggestionService.rephraseSarcastic()
    }

    @objc
    func rephrasePoetic(_ sender: NSMenuItem) {
        suggestionService.rephrasePoetic()
    }

    // emotional
    @objc
    func rephraseEmotional(_ sender: NSMenuItem) {
        suggestionService.rephraseEmotional()
    }

    // text to code
    @objc
    func textToCode(_ sender: NSMenuItem) {
        suggestionService.rephraseTextToCode()
    }


    @objc
    func smartReply(_ sender: NSMenuItem) {
        suggestionService.smartReply()
    }

    @objc
    func continueWriting(_ sender: NSMenuItem) {
        suggestionService.continueWriting()
    }

    @objc
    func toEnglish(_ sender: NSMenuItem) {
        suggestionService.translateToEnglish()
    }

    @objc
    func toFrench(_ sender: NSMenuItem) {
        suggestionService.translateToFrench()
    }

    // german
    @objc
    func toGerman(_ sender: NSMenuItem) {
        suggestionService.translateToGerman()
    }

    // spanish
    @objc
    func toSpanish(_ sender: NSMenuItem) {
        suggestionService.translateToSpanish()
    }

    // italian
    @objc
    func toItalian(_ sender: NSMenuItem) {
        suggestionService.translateToItalian()
    }

    // portuguese
    @objc
    func toPortuguese(_ sender: NSMenuItem) {
        suggestionService.translateToPortuguese()
    }

    // chinese
    @objc
    func toChinese(_ sender: NSMenuItem) {
        suggestionService.translateToChinese()
    }

    // japanese
    @objc
    func toJapanese(_ sender: NSMenuItem) {
        suggestionService.translateToJapanese()
    }

    // korean
    @objc
    func toKorean(_ sender: NSMenuItem) {
        suggestionService.translateToKorean()
    }

    // hindi
    @objc
    func toHindi(_ sender: NSMenuItem) {
        suggestionService.translateToHindi()
    }

}
