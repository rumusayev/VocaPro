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
import Toaster
import UserNotifications


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
            self.words.remove(at: indexPath.row)
            self.wordsTableView.reloadData()
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
        
        var update = false
        
        for (index, wordItem) in words.enumerated() {
            if wordItem["word"] == word["word"] {
                
                update = true
                words[index]["word"] = word["word"]
                words[index]["translation"] = word["translation"]
                words[index]["transcription"] = word["transcription"]
                words[index]["example"] = word["example"]
                
            }
        }
        
        if !update {
            words.append(word)
        }
        
        runToastNotificationSaveWord("Word Saved")
        
        wordsTableView.reloadData()
    }
    
    func runToastNotificationSaveWord(_ text: String){
        let appearance = ToastView.appearance()
        appearance.backgroundColor = .lightGray
        appearance.textColor = .black
        appearance.font = .boldSystemFont(ofSize: 16)
        appearance.textInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        appearance.bottomOffsetPortrait = 100
        appearance.cornerRadius = 20
        
        let toast = Toast(text: text, delay: 0, duration: 1)
        toast.show()
    }
    
    @IBAction func saveSheetPressed(_ sender: UIBarButtonItem) {
        
        var errors = ""
        
        if (nameOfSheetTF.text?.isEmpty)! {
            errors += "Name of sheet\n"
        }
        
        if (timeFrameTF.text?.isEmpty)! {
            errors += "Time frame\n"
        }
        
        if (sequenceTF.text?.isEmpty)! {
            errors += "Sequence\n"
        }
        
        if words.isEmpty {
            errors += "at least 1 word"
        }
        
        if !errors.isEmpty{
            runToastNotificationSaveWord("Please specify: \(errors)")
        } else {
            
            saveSheet()
            
        }
        
    }
    
    func saveSheet(){
        
        let newSheet = Sheet()
        newSheet.id = newSheet.incrementID()
        newSheet.sheetName = nameOfSheetTF.text!
        newSheet.timeFrame = Double(timeFrameTF.text!)!
        newSheet.sequence = Double(sequenceTF.text!)!
        
        do {
            try realm.write {
                realm.add(newSheet)
            }
            
        } catch {
            print("Error while creating sheet \(error)")
            fatalError()
        }
        
        for word in words {
            saveWords(word, newSheet)
        }
        
    }
    
    func saveWords(_ word: Dictionary<String, String> = [:], _ sheet: Sheet){
        
        let newWord = Word()
        
        newWord.id = newWord.incrementID()
        newWord.word = word["word"]!
        newWord.translation = word["translation"]!
        newWord.transcription = word["transcription"]!
        newWord.example = word["example"]!
        newWord.dateCreated = Date()
        
        do {
            try realm.write {
                realm.add(newWord)
                sheet.words.append(newWord)
            }
        } catch {
            print("Error while creating words \(error)")
        }
        
    }
}
