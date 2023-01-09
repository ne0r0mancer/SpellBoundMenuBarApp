//
//  AboutSettingsView.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 1/9/23.
//

import SwiftUI


struct AboutSettingsView: View {
    var body: some View {
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let linkUrlString = "https://spellbound.cc"
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 128, height: 128)
            Text("SpellBound AI")
                .font(.custom("HeadLineA", size: 25))
            Text("Version: \(appVersion ?? "0.0.1")")
                .padding(.top, 10.0)
            HStack {
                Text("Web site:")
                Link(linkUrlString, destination: URL(string: linkUrlString)!)
            }
        }
    }
}

struct AdvancedSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutSettingsView()
    }
}
