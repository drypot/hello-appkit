//
//  GraphicButton.swift
//  HelloAppKit
//
//  Created by Kyuhyun Park on 1/10/24.
//

import AppKit

// Mastering macOS programming-Packt Publishing (2017), Chapter 10,

class GraphicButton: NSButton {

    var borderColor: NSColor = .orange
    var normalButtonColor: NSColor = .white
    var highlightedButtonColor: NSColor = .gray
    var roundIcon: Bool = true

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.isBordered = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var fillColor: NSColor {
        return isHighlighted ? highlightedButtonColor : normalButtonColor
    }

    var standardLineWidth: CGFloat {
        return min(bounds.width, bounds.height) * 0.05
    }

    var insetRect: CGRect {
        let delta = standardLineWidth * 0.5
        return bounds.insetBy(dx: delta, dy: delta)
    }

    var iconRect: CGRect {
        let delta = min(bounds.width, bounds.height) * 0.15
        return insetRect.insetBy(dx: delta, dy: delta)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        let circlePath = NSBezierPath(ovalIn: insetRect)
        fillColor.setFill()
        circlePath.fill()

        circlePath.lineWidth = standardLineWidth
        borderColor.setStroke()
        circlePath.stroke()

        let iconPath = NSBezierPath()

        if roundIcon == true {
            iconPath.appendOval(in: iconRect)
        } else {
            iconPath.appendArc(
                withCenter: CGPoint(x: iconRect.midX, y: iconRect.midY),
                radius: min(iconRect.width, iconRect.height) / 2.0,
                startAngle: 180.0,
                endAngle: 0
            )
            iconPath.close()
        }

        iconPath.lineWidth = standardLineWidth
        borderColor.setStroke()
        iconPath.stroke()
    }

}

class GraphicButtonDemo: NSViewController {

    override func loadView() {
        let view = NSView()
        self.view = view

        let stackView = NSStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.orientation = .horizontal
        view.addSubview(stackView)

        addStckItems(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(greaterThanOrEqualToConstant: 400),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400),
        ])
    }

    func addStckItems(_ stackView: NSStackView) {
        do {
            let button = GraphicButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 200),
            ])
        }

        do {
            let button = GraphicButton()
            button.roundIcon = false
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 200),
            ])
        }
    }
}
