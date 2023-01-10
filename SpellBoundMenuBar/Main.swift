//
//  Main.swift
//  SpellBoundMenuBar
//
//  Created by ne0r0mancer on 1/9/23.
//

import SwiftUI

struct MainScene: Scene {
    var body: some Scene {
        WindowGroup(id: "mainscene") {
            WelcomeView()
                .fixedSize()
        }
        .windowResizability(.contentSize)
    }
}

//struct WelcomeView: View {
//    @State private var welcomeScreenShown: Bool = UserDefaults.standard.bool(forKey: "welcomeScreenShown")
//
//    var body: some View {
//        VStack {
//            Image(systemName: "sparkles")
//                    .imageScale(.large)
//                    .foregroundColor(.accentColor)
//            Text("Spellbound will give your writing a sparkle!")
//            // show image
//            Image("intro")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 350, height: 350)
//            Text("We hope you will enjoy using our app!")
//
//            if welcomeScreenShown {
//                // close WindowGroup
//                Button(action: {
//                    NSApplication.shared.keyWindow?.close()
//                    // show preferences window
//
//                }) {
//                    Text("Close")
//                }
//            } else {
//                Button(action: {
//                    // Navigate to the main app content here
//                    // Set the value in UserDefaults to indicate that the intro screen has been shown
//                    print("Welcome screen has been shown")
//                    UserDefaults.standard.set(true, forKey: "welcomeScreenShown")
//                    // close current window when button clicked
//                    NSApplication.shared.keyWindow?.close()
//                    // show preferences window
//                    showPreferences()
//
//                }) {
//                    Text("Setup")
//                }
//            }
//
//        }
//    }
//}


struct WelcomeView: View {
    @State private var welcomeScreenShown: Bool = UserDefaults.standard.bool(forKey: "introScreenShown")
    @State private var pageIndex = 0
    
    var body: some View {
        if !welcomeScreenShown {
            ZStack {
                GeometryReader {proxy in
                    HStack(spacing: 0) {
                        Page1()
                            .frame(width: proxy.size.width)
                        Page2()
                            .frame(width: proxy.size.width)
                        Page3()
                            .frame(width: proxy.size.width)
                        Page4()
                            .frame(width: proxy.size.width)
                    }
                    .offset(x: -(CGFloat(pageIndex)*proxy.size.width))
                }
                .frame(height: 200)
                HStack {
                    Button {
                        if pageIndex > 0 {
                            withAnimation {
                                pageIndex -= 1
                            }
                        }
                    } label: {
                        Image(systemName: "arrowshape.left")
                            .font(.title)
                            .foregroundColor(pageIndex == 0 ? .gray : .red)
                    }
                    .buttonStyle(.plain)
                    .padding(.leading, 20)
                    .disabled(pageIndex == 0)
                    Spacer()
                    Button {
                        if pageIndex < 3 {
                            withAnimation {
                                pageIndex += 1
                            }
                        }
                    } label: {
                        Image(systemName: "arrowshape.right")
                            .font(.title)
                            .foregroundColor(pageIndex == 3 ? .gray : .red)
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, 20)
                    .disabled(pageIndex == 3)
                }
            }
            .frame(width: 800, height: 700)
        }

    }
}


struct Page1: View {
    var body: some View {
        VStack {
            Text("Your new AI Writing Assistant")
                .font(.custom("DIN Condensed", size: 35))
                .foregroundColor(.pink)
            Image("intro1")
                .resizable()
                .frame(width: 500, height: 350)

        }
    }
}

struct Page2: View {
    var body: some View {
        VStack {
            Text("Always listening, easily accessible pop-up menu in all applications")
                .font(.custom("DIN Condensed", size: 35))
                .foregroundColor(.pink)
            Image("intro4")
                .resizable()
                .frame(width: 500, height: 350)
            
        }
    }
}

struct Page3: View {
    var body: some View {
        VStack {
            Text("Helps you create content that is BOTH Accurate and Engaging!")
                .font(.custom("DIN Condensed", size: 35))
                .foregroundColor(.pink)
            Image("intro5")
                .resizable()
                .frame(width: 500, height: 350)
        }
    }
}

struct Page4: View {
    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 128, height: 128)
            // let's go button
            Button(action: {
                print("Welcome screen has been shown")
                UserDefaults.standard.set(true, forKey: "introScreenShown")
                // close current window when button clicked
                NSApplication.shared.keyWindow?.close()
                // show preferences window
                showPreferences()
            }) {
                Text("Let's go!")
                    .foregroundColor(.pink)
            }

        }
    }
}


struct Page2_Preview: PreviewProvider {
    static var previews: some View {
        Page1()
        Page2()
        Page3()
        Page4()
    }
}
