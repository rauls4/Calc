//
//  CalcButton.swift
//  Calc
//
//  Created by Raul Silva on 12/19/17.
//  Copyright © 2017 Silva. All rights reserved.
//

import UIKit

@IBDesignable class CalcButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    private func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}
