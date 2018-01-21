//
//  DesignableHomeBtn.swift
//  VocaPro
//
//  Created by Ruslan on 1/21/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableHomeBtn: UIButton {

    override func draw(_ rect: CGRect) {
        
        addBottomBorderWithColor(color: UIColor(red:0.91, green:0.53, blue:0.53, alpha:1.0), width: 1)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 42, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    @IBInspectable var leftHandImage: UIImage? {
        didSet {
            leftHandImage = leftHandImage?.withRenderingMode(.alwaysOriginal)
            setupImages()
        }
    }
    @IBInspectable var rightHandImage: UIImage? {
        didSet {
            rightHandImage = rightHandImage?.withRenderingMode(.alwaysTemplate)
            setupImages()
        }
    }
    
    func setupImages() {
        if let leftImage = leftHandImage {
            self.setImage(leftImage, for: .normal)
            self.imageView?.contentMode = .scaleAspectFill
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: self.frame.width - (self.imageView?.frame.width)!)
        }
        
        if let rightImage = rightHandImage {
            let rightImageView = UIImageView(image: rightImage)
            rightImageView.tintColor = UIColor(red:0.91, green:0.53, blue:0.53, alpha:1.0)
            
            let height = self.frame.height * 0.35
            let width = height * 0.8
            let xPos = self.frame.width - width - 10
            let yPos = (self.frame.height - height) / 2
            
            
            rightImageView.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
            
            self.addSubview(rightImageView)
        }
        
    }
    
}
