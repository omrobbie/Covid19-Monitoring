//
//  CustomUIButton.swift
//  Covid19 Monitoring
//
//  Created by omrobbie on 04/04/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    override func prepareForInterfaceBuilder() {
        setupUI()
    }

    override func awakeFromNib() {
        setupUI()
    }

    private func setupUI() {
        layer.cornerRadius = cornerRadius
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        UIView.animate(withDuration: 0.2, delay: 0, options: .autoreverse, animations: {
            self.imageView?.alpha = 0.5
            self.titleLabel?.alpha = 0.5
        }, completion: { _ in
            self.imageView?.alpha = 1
            self.titleLabel?.alpha = 1
        })
    }
}
