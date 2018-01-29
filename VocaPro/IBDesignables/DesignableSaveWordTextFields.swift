//
//  DesignableSaveWordTextFields.swift
//  VocaPro
//
//  Created by Ruslan on 1/26/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit

@IBDesignable class DesignableSaveWordTextFields: UITextField {

    @IBInspectable var bgColor: UIColor = UIColor.clear {
        didSet {
            self.layer.backgroundColor = bgColor.cgColor
        }
    }
    
    
    
}
