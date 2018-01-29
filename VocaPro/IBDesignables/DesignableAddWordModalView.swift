//
//  DesignableAddWordModalView.swift
//  VocaPro
//
//  Created by Ruslan on 1/26/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit

@IBDesignable class DesignableAddWordModalView: UIView {
    
    @IBInspectable var corderRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = corderRadius
        }
    }
    
}
