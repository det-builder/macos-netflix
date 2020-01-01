import Cocoa

protocol WindowControllerFullscreenDelegate: class {

    func windowDidEnterFullScreen(_ window: NSWindow)

    func windowDidFailToEnterFullScreen(_ window: NSWindow)

    func windowDidExitFullScreen(_ window: NSWindow)

    func windowDidFailToExitFullScreen(_ window: NSWindow)

}

class WindowController: NSWindowController, NSWindowDelegate {

    weak var fullscreenDelegate: WindowControllerFullscreenDelegate?

    override func windowDidLoad() {
        super.windowDidLoad()

        guard let window = window else {
            return
        }

        window.delegate = self
        window.title = ""
        window.styleMask.insert(.fullSizeContentView)
        window.collectionBehavior.insert(.fullScreenPrimary)
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true

        window.setContentSize(NSSize(width: 1280, height: 904))
        window.contentMinSize = NSSize(width: 180, height: 102)

    }

    private var isMoving = false

    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)

        guard isMoving else {
            return
        }

        isMoving = false

        guard !event.modifierFlags.contains(.command) else {
            return
        }

    }

    func windowWillMove(_ notification: Notification) {
        isMoving = true
    }

    func windowDidMove(_ notification: Notification) {
        isMoving = true
    }

    func windowDidEnterFullScreen(_ notification: Notification) {
        guard let window = notification.object as? NSWindow else {
            return
        }

        fullscreenDelegate?.windowDidEnterFullScreen(window)
    }

    func windowDidFailToEnterFullScreen(_ window: NSWindow) {
        fullscreenDelegate?.windowDidFailToEnterFullScreen(window)
    }

    func windowDidExitFullScreen(_ notification: Notification) {

        guard let window = notification.object as? NSWindow else {
            return
        }

        fullscreenDelegate?.windowDidExitFullScreen(window)
    }

    func windowDidFailToExitFullScreen(_ window: NSWindow) {
        fullscreenDelegate?.windowDidFailToExitFullScreen(window)
    }

}


