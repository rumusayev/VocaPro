    //
//  CreateASheetViewController.swift
//  VocaPro
//
//  Created by Ruslan on 1/22/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit

class CreateASheetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var nameOfSheetTF: UITextField!
    @IBOutlet weak var timeFrameTF: UITextField!
    @IBOutlet weak var sequenceTF: UITextField!
    
    @IBOutlet weak var wordsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewUI()
        
        self.title = "Create a sheet"
        
        settingTextFieldsUI(textField: nameOfSheetTF)
        settingTextFieldsUI(textField: timeFrameTF)
        settingTextFieldsUI(textField: sequenceTF)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wordsTableView.dequeueReusableCell(withIdentifier: "cellWord", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func settingTextFieldsUI(textField: UITextField)
    {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red:0.59, green:0.50, blue:0.57, alpha:1.0)])
        
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor(red:0.98, green:0.98, blue:0.96, alpha:1.0)
    }
    
    func tableViewUI(){
        self.wordsTableView.backgroundColor = UIColor.clear
        self.wordsTableView.isScrollEnabled = false
        self.wordsTableView.separatorInset = UIEdgeInsets.zero
    }
    
    func updateWordsTableView(){
        
    }

}
