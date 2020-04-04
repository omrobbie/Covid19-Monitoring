//
//  CustomUIView.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 04/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIView: UIView {

    @IBInspectable
    var radius: CGFloat = 5.0 {
        didSet {
            setupUI()
        }
    }

    @IBInspectable
    var topLeft: Bool = false {
        didSet {
            if topLeft {
                rectCorner.insert(.topLeft)
            } else {
                rectCorner.remove(.topLeft)
            }

            setupUI()
        }
    }

    @IBInspectable
    var topRight: Bool = false {
        didSet {
            if topRight {
                rectCorner.insert(.topRight)
            } else {
                rectCorner.remove(.topRight)
            }

            setupUI()
        }
    }

    @IBInspectable
    var bottomLeft: Bool = false {
        didSet {
            if bottomLeft {
                rectCorner.insert(.bottomLeft)
            } else {
                rectCorner.remove(.bottomLeft)
            }

            setupUI()
        }
    }

    @IBInspectable
    var bottomRight: Bool = false {
        didSet {
            if bottomRight {
                rectCorner.insert(.bottomRight)
            } else {
                rectCorner.remove(.bottomRight)
            }

            setupUI()
        }
    }

    private var rectCorner: UIRectCorner = []

    override func prepareForInterfaceBuilder() {
        setupUI()
    }

    override func awakeFromNib() {
        setupUI()
    }

    override func layoutSubviews() {
        setupUI()
    }

    private func setupUI() {
        roundCorners(rectCorner, radius: radius)
    }
}

extension CustomUIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()

        mask.path = path.cgPath
        layer.mask = mask
    }
}
