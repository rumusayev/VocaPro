//
//  WordSaveViewController.swift
//  VocaPro
//
//  Created by Ruslan on 1/26/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit
import Toaster

protocol AlertCustomWordAddingDelegate {
    func onWordSaved(_ word: Dictionary<String, String>)
}

class WordSaveViewController: UIViewController {
    
    var newWord = [String]()
    var selectedWord = [String: String]()

    @IBOutlet weak var wordTField: UITextField!
    
    @IBOutlet weak var translationTField: UITextField!
    
    @IBOutlet weak var trranscriptionTField: UITextField!
    
    @IBOutlet weak var exampleTView: UITextView!
    
    @IBOutlet var modalPage: UIView!
    
    var delegate: AlertCustomWordAddingDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiUpdatesForPage()
    }
    
    func uiUpdatesForPage(){
        
        
        if (!selectedWord.isEmpty){
            wordTField.text =  selectedWord["word"]
            translationTField.text =  selectedWord["translation"]
            trranscriptionTField.text =  selectedWord["transcription"]
            exampleTView.text =  selectedWord["example"]
        }
        
        generateBorderForTextField(textfield: wordTField)
        generateBorderForTextField(textfield: translationTField)
        generateBorderForTextField(textfield: trranscriptionTField)
        generateBorderForTextField(textfield: exampleTView)
    }
    
    func generateBorderForTextField(textfield: Any){
        
        let bottomBorder = UIView(frame: CGRect(x: 0, y: (textfield as AnyObject).frame.height, width: (textfield as AnyObject).frame.width, height: 1))
        
        bottomBorder.layer.backgroundColor = UIColor(red:0.41, green:0.29, blue:0.39, alpha:1.0).cgColor
        
        
        (textfield as AnyObject).addSubview(bottomBorder)
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        
        if (wordTField.text?.isEmpty)! || (translationTField.text?.isEmpty)! || (trranscriptionTField.text?.isEmpty)! || (exampleTView.text?.isEmpty)!
        {
            let appearance = ToastView.appearance()
            appearance.backgroundColor = .lightGray
            appearance.textColor = .black
            appearance.font = .boldSystemFont(ofSize: 16)
            appearance.textInsets = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
            appearance.bottomOffsetPortrait = 100
            appearance.cornerRadius = 20
            
            let toast = Toast(text: "Please fill up all fields", delay: 0, duration: 1)
            toast.show()
            
        } else {
            
            let wordData = [
                "word": wordTField.text!,
                "translation": translationTField.text!,
                "transcription" : trranscriptionTField.text!,
                "example": exampleTView.text!
            ]
            
            if let del = delegate
            {
                del.onWordSaved(wordData)
            }
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
