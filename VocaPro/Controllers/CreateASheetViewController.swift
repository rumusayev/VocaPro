//
//  CreateASheetViewController.swift
//  VocaPro
//
//  Created by Ruslan on 1/22/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit



class CreateASheetViewController: UIViewController, UITableViewDataSource, SwipeTableViewCellDelegate, AlertCustomWordAddingDelegate {
    
    let realm = try! Realm()
    
    var words = [[String: String]]()
    
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
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = wordsTableView.dequeueReusableCell(withIdentifier: "cellWord")  as! SwipeTableViewCell
        
        print(words[indexPath.row])
        
        cell.textLabel?.text = words[indexPath.row]["word"]
        
        cell.delegate = self
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.textColor = UIColor(red:0.98, green:0.98, blue:0.96, alpha:1.0)
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Thin", size:18)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-white-icon")
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            self.showWordModal(self.words[indexPath.row])
        }
        
        // customize the action appearance
        editAction.image = UIImage(named: "edit-white-icon")
        editAction.backgroundColor = UIColor(red:1.00, green:0.64, blue:0.00, alpha:1.0)
        
        return [deleteAction, editAction]
    }
    
    func settingTextFieldsUI(textField: UITextField)
    {
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red:0.59, green:0.50, blue:0.57, alpha:1.0)])
        
        textField.backgroundColor = UIColor.clear
        textField.textColor = UIColor(red:0.98, green:0.98, blue:0.96, alpha:1.0)
    }
    
    func tableViewUI(){
        self.wordsTableView.backgroundColor = UIColor.clear
        self.wordsTableView.separatorInset = UIEdgeInsets.zero
        self.wordsTableView.rowHeight = 50.0
    }
    
    func updateWordsTableView(){
        
    }
    
    func saveSheet(){
        
        let newSheet = Sheet()
        newSheet.id = newSheet.incrementID()
        newSheet.sheetName = "Week 1"
        newSheet.timeFrame = 0.1
        newSheet.sequence = 24
        
        do {
            try realm.write {
                realm.add(newSheet)
            }
        } catch {
            print("Error while creating sheet \(error)")
        }
        
    }
    
    func saveWords(){
        
        let sheet = realm.object(ofType: Sheet.self, forPrimaryKey: 1)
        let newWord = Word()
        
        newWord.id = newWord.incrementID()
        newWord.word = "Hello"
        newWord.translation = "Привет"
        newWord.transcription = "[hello:]"
        newWord.example = "When she saying hello I loose my mind"
        newWord.dateCreated = Date()
        sheet?.words.append(newWord)
        
        do {
            try realm.write {
                realm.add(newWord)
            }
        } catch {
            print("Error while creating words \(error)")
        }
        
    }
    
    @IBAction func addWordPressed(_ sender: UIButton)
    {
        showWordModal()
    }
    
    func showWordModal(_ word: Dictionary<String, String> = [:]){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WordSaveViewController") as? WordSaveViewController?
        {
            if (!word.isEmpty) {
                vc?.selectedWord = word
            }
            vc?.delegate = self
            vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            present(vc!, animated: true, completion: nil)
        }
    }
    
    //MARK: AlertCustomWordAddingDelegate
    func onWordSaved(_ word: Dictionary<String, String>) {
        words.append(word)
        wordsTableView.reloadData()
        print(words)
    }
    
}
