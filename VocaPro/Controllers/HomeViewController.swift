//
//  HomeViewController.swift
//  VocaPro
//
//  Created by Ruslan on 1/20/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func onCreateSheetButtonAction(_ sender: Any)
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CreateASheetViewController") as? CreateASheetViewController
        {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
