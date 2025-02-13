//
//  AppDelegate.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 8/27/24.
//

import Cocoa

@MainActor @main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationWillFinishLaunching(_ notification: Notification) {
        print("ApplicationWillFinishLaunching")
#if DEV
        print("Compiler flag DEV defined")
#else
        print("Compiler flag DEV not defined")
#endif
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        print("ApplicationDidFinishLaunching")
        setupWindow()
    }

    func setupWindow() {
        window = NSWindow(
            contentRect: .zero,
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )

        window.title = "AppKit Demo"
        window.contentViewController = NavigatorController()
        window.layoutIfNeeded()
        restoreWindowPosition()
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        print("ApplicationWillTerminate")
        saveWindowPosition()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    private func saveWindowPosition() {
        let frameString = NSStringFromRect(window.frame)
        UserDefaults.standard.set(frameString, forKey: "MainWindowFrame")
    }

    private func restoreWindowPosition() {
        if let frameString = UserDefaults.standard.string(forKey: "MainWindowFrame") {
            let frame = NSRectFromString(frameString)
            window.setFrame(frame, display: true)
        } else {
            window.center()
        }
    }

}
