import Cocoa
import WebKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    static weak var shared: AppDelegate? = {
        return NSApplication.shared.delegate as? AppDelegate
    }()

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    private weak var defaultWindowController: WindowController? {
        guard let window = NSApplication.shared.mainWindow else {
            return nil
        }

        guard let windowController = window.windowController as? WindowController else {
            return nil
        }

        return windowController
    }

    private weak var defaultViewController: ViewController? {
        guard let window = NSApplication.shared.mainWindow else {
            return nil
        }

        guard let viewController = window.contentViewController as? ViewController else {
            return nil
        }

        return viewController
    }

    //
    @IBAction func about(_ sender: Any?) {
        NSApplication.shared.orderFrontStandardAboutPanel(options: [
            NSApplication.AboutPanelOptionKey(rawValue: "ApplicationName"): "Amazon Prime wrapper for macOS",
            NSApplication.AboutPanelOptionKey(rawValue: "Copyright"): "",
        ])
    }

    @IBAction func help(_ sender: Any?) {
        guard let url = URL(string: "https://www.duckduckgo.com") else {
            fatalError("Could not prepare URL for Amazon Prime Help")
        }

        NSWorkspace.shared.open(url)
    }

}


