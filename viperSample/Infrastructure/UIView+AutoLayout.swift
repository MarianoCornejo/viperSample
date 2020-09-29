//
//  UIView+AutoLayout.swift
//  viperSample
//
//  Created by Oscar Mariano Cornejo Herrera on 9/29/20.
//  Copyright © 2020 Oscar Mariano Cornejo Herrera. All rights reserved.
//

import UIKit

enum LayoutCorner {
    case topLeft(leftMargin: CGFloat, topMargin: CGFloat)
    case topRight(leftMargin: CGFloat, topMargin: CGFloat)
    case bottomLeft(leftMargin: CGFloat, topMargin: CGFloat)
    case bottomRight(leftMargin: CGFloat, topMargin: CGFloat)
}

enum LayoutSides {
    case left(margin: CGFloat)
    case right(margin: CGFloat)
    case top(margin: CGFloat)
    case bottom(margin: CGFloat)
    case all(margin: CGFloat)
}

extension UIView {
    func expandTofitLayoutFromView(_ parentView: UIView) {
        let guide = parentView.layoutMarginsGuide
        leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
    
    func pinToCorner(_ layoutCorner: LayoutCorner, inParentView view: UIView) {
        let guide = view.layoutMarginsGuide
        switch layoutCorner {
        case .topLeft(let leftMargin, let topMargin):
            leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: leftMargin).isActive = true
            topAnchor.constraint(equalTo: guide.topAnchor, constant: topMargin).isActive = true
        case .topRight(let rightMargin, let topMargin):
            trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: rightMargin).isActive = true
            topAnchor.constraint(equalTo: guide.topAnchor, constant: topMargin).isActive = true
        case .bottomLeft(let leftMargin, let bottomMargin):
            leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: leftMargin).isActive = true
            bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: bottomMargin).isActive = true
        case .bottomRight(let rightMargin, let bottomMargin):
            trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: rightMargin).isActive = true
            bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: bottomMargin).isActive = true
        }
    }
    
    func constraintToSize(_ size: CGSize) {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    func expandToSides(_ sides: [LayoutSides], inParentView view: UIView) {
        let guide = view.layoutMarginsGuide
        for side in sides {
            switch side {
            case .left(let margin):
                leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: margin).isActive = true
            case .right(let margin):
                trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: margin).isActive = true
            case .top(let margin):
                topAnchor.constraint(equalTo: guide.topAnchor, constant: margin).isActive = true
            case .bottom(let margin):
                bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: margin).isActive = true
            case .all(let margin):
                leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: margin).isActive = true
                trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: margin).isActive = true
                topAnchor.constraint(equalTo: guide.topAnchor, constant: margin).isActive = true
                bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: margin).isActive = true
            }
        }
    }
    
    func centerInLayout(inParentView view: UIView) {
        let guide = view.layoutMarginsGuide
        centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    }
}
