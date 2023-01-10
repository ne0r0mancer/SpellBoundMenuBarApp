//
//  LicenceExpiredListener.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 1/10/23.
//

import Foundation

// listen to state changes, show notification if licence expired

class LicenseExpiredListener {
    static let shared = LicenseExpiredListener()
    private init() {}
    @objc func licenseExpired() {
        print("License expired")
        // show notification
        let notification = NSUserNotification()
        notification.title = "License expired"
        notification.informativeText = "Your license has expired or not valid. Please verify it Preferences menu"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
}
