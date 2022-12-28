import AppKit

class DebugWindowController: NSWindowController {
    
    private let inputLabel: NSTextField
    private let outputLabel: NSTextField

    init(text: String) {
        let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 200, height: 100),
                styleMask: [.titled, .closable, .miniaturizable, .resizable],
                backing: .buffered, defer: false)
        window.center()
        window.title = "Popup Window"

        inputLabel = NSTextField(labelWithString: "Input:" + text)
        outputLabel = NSTextField(labelWithString: "Output:########")
        
        window.contentView?.addSubview(inputLabel)
        window.contentView?.addSubview(outputLabel)

        super.init(window: window)
    }
    
    func setInputText(_ text: String) {
        inputLabel.stringValue = text
        }
    
    func setOutputText(_ text: String) {
        outputLabel.stringValue = "Output:" + text
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showModal() {
           window?.makeKeyAndOrderFront(nil)
           NSApp.runModal(for: window!)
       }
}
