//
//  ToasterEstension.swift
//  VocaPro
//
//  Created by Ruslan on 1/30/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import Foundation
import Toaster

extension Toast {
    
    func prepareToast(){
        let appearance = ToastView.appearance()
        appearance.backgroundColor = .lightGray
        appearance.textColor = .black
        appearance.font = .boldSystemFont(ofSize: 16)
        appearance.textInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        appearance.bottomOffsetPortrait = 100
        appearance.cornerRadius = 20
    }
    
    func runToast(){
        
        let toast = Toast(text: "Please fill up all fields", delay: 0, duration: 1)
        toast.show()
    }
}
