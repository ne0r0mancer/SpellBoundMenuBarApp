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
                        Page5()
                            .frame(width: proxy.size.width)
                        Page6()
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
                        if pageIndex < 5 {
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
                    .disabled(pageIndex == 5)
                }
            }
                    .frame(width: 500, height: 400)
        }

    }
}


struct Page1: View {
    var body: some View {
        VStack {
            Image("icon")
                    .resizable()
                    .frame(width: 128, height: 128)
            Text("Your new AI Writing Assistant")
                .font(.custom("DIN Condensed", size: 35))
                .foregroundColor(.pink)

        }
    }
}

struct Page2: View {
    var body: some View {
        VStack {
            Image(systemName: "paintbrush.pointed.fill")
                    .resizable()
                    .frame(width: 128, height: 128)
                    .foregroundColor(.pink)
            Text("Get the perfect grammar with Grammar Genius")
                .font(.custom("DIN Condensed", size: 30))
                .foregroundColor(.pink)
            
        }
    }
}

struct Page3: View {
    var body: some View {
        VStack {
            Image(systemName: "bolt.fill")
                    .resizable()
                    .frame(width: 128, height: 128)
                    .foregroundColor(.pink)
            Text("Write in any tone with Tone Wizard")
                .font(.custom("DIN Condensed", size: 35))
                .foregroundColor(.pink)
        }
    }
}

struct Page4: View {
    var body: some View {
        VStack {
            Image(systemName: "flame")
                    .resizable()
                    .frame(width: 128, height: 128)
                    .foregroundColor(.pink)
            Text("Get instant replies with Quickfire Replies")
                .font(.custom("DIN Condensed", size: 35))
                .foregroundColor(.pink)
        }
    }
}

struct Page5: View {
    var body: some View {
        VStack {
            Image(systemName: "sparkle")
                    .resizable()
                    .frame(width: 128, height: 128)
                    .foregroundColor(.pink)
            Text("Never run out of words with Write On")
                .font(.custom("DIN Condensed", size: 35))
                .foregroundColor(.pink)
        }
    }
}

struct Page6: View {
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
        Page5()
        Page6()
    }
}
