//
// Created by ne0r0mancer on 1/2/23.
//

import SwiftUI
import AppKit


func showPreferences() { // open new window
    let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 800, height: 800),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
    window.center()
    window.setFrameAutosaveName("Main Window")
    window.contentView = NSHostingView(rootView: SettingsView())
    // make window modal
    window.makeKeyAndOrderFront(nil)
    // resize window to fit the content
    window.setContentSize(window.contentView!.fittingSize)
    // on close do not quit the app
    window.isReleasedWhenClosed = false
    // make window on top of other windows
    window.level = .floating
    // disable so the window cannot be maximized
    window.styleMask.remove(.resizable)
}
