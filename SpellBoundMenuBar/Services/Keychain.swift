//
//  Keychain.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 12/30/22.
//

import Foundation

class Keychain {
    static let shared = Keychain()

    private let service = "com.splbnd.spellboundmenu"
    private let accessGroup: String? = nil

    private func makeQuery(key: String) -> [String: Any] {
        var query: [String: Any] = [:]
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service
        query[kSecAttrAccount as String] = key
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }
        return query
    }

    func store(key: String, value: String) -> Bool {
        var query = makeQuery(key: key)
        query[kSecValueData as String] = value.data(using: .utf8)!

        let status = SecItemUpdate(query as CFDictionary, query as CFDictionary)

        if status == errSecSuccess {
            return true
        } else if status == errSecItemNotFound {
            return SecItemAdd(query as CFDictionary, nil) == errSecSuccess
        } else {
            return false
        }
    }


    func retrieve(key: String) -> String? {
        var query = makeQuery(key: key)
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // convert status to string
//        let statusString = SecCopyErrorMessageString(status, nil) as String?
//        print ("retrieve Status: \(statusString ?? "Unknown")")
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
