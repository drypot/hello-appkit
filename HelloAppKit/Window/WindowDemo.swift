//
//  WindowDemo.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 9/18/24.
//

import AppKit

class WindowDemo: NSViewController {

    let stackView = NSStackView()

    var blankWindow: NSWindow?
    var windowWithSomeControls: NSWindow?
    var windowAtAbsoluteCenter: NSWindow?

    override func loadView() {
        view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false

        setupStackView()
        setupStackItems()
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .vertical
        stackView.alignment = .leading
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func setupStackItems() {
        do {
            let button = NSButton(title: "Open window", target: self, action: #selector(openWindow))
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Open window with some controls", target: self, action: #selector(openWindowWithSomeControls))
            stackView.addArrangedSubview(button)
        }
        do {
            let button = NSButton(title: "Open window at absolute center", target: self, action: #selector(openWindowAtAbsoluteCenter))
            stackView.addArrangedSubview(button)
        }
    }

    @objc func openWindow() {
        if blankWindow == nil {
            blankWindow = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }

        let window = blankWindow!

        window.title = "Blank Window"
        window.isReleasedWhenClosed = false // 이거 안 하고 윈도우 닫았다가 다시 Open 버튼 누르면 크래쉬난다.
        window.contentViewController = NSViewController()

        window.center()
        window.makeKeyAndOrderFront(nil)
    }

    @objc func openWindowWithSomeControls() {
        if windowWithSomeControls == nil {
            windowWithSomeControls = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }

        let window = windowWithSomeControls!

        window.title = "Window with Controls"
        window.isReleasedWhenClosed = false

        let contentView = NSView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        window.contentView = contentView

        let label = NSTextField(labelWithString: "Hello!")
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = NSFont.systemFont(ofSize: 24.0)
        label.sizeToFit()
        contentView.addSubview(label)
        
        let closeButton = NSButton(title: "Close", target: self, action: #selector(closeWindowWithSomeControls))
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.keyEquivalent = "\r"
        contentView.addSubview(closeButton)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),

            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),

            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            closeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])

        window.center()
        window.makeKeyAndOrderFront(nil)
    }

    @objc func closeWindowWithSomeControls(_ sender: NSButton) {
        windowWithSomeControls!.close()
    }

    @objc func openWindowAtAbsoluteCenter() {
        if windowAtAbsoluteCenter == nil {
            windowAtAbsoluteCenter = NSWindow(
                contentRect: .zero,
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
        }

        let window = windowAtAbsoluteCenter!
        window.title = "Window at Absolute Center"
        window.isReleasedWhenClosed = false // 이거 안 하고 윈도우 닫았다가 다시 Open 버튼 누르면 크래쉬난다.
        window.contentViewController = NSViewController()
        moveWindowToAbsoluteCenter(window)
        window.makeKeyAndOrderFront(nil)
    }

    private func moveWindowToAbsoluteCenter(_ window: NSWindow) {
        guard let screen = window.screen ?? NSScreen.main else { return }

        let screenRect = screen.visibleFrame
        let windowSize = window.frame.size

        let x = (screenRect.width - windowSize.width) / 2 + screenRect.origin.x
        let y = (screenRect.height - windowSize.height) / 2 + screenRect.origin.y

        window.setFrameOrigin(NSPoint(x: x, y: y))
    }
}



