//
//  WordSaveViewController.swift
//  VocaPro
//
//  Created by Ruslan on 1/26/18.
//  Copyright © 2018 Ruslan Musayev. All rights reserved.
//

import UIKit

class WordSaveViewController: UIViewController {
    
    var newWord = [String]()

    @IBOutlet weak var wordTField: UITextField!
    
    @IBOutlet weak var translationTField: UITextField!
    
    @IBOutlet weak var trranscriptionTField: UITextField!
    
    @IBOutlet weak var exampleTView: UITextView!
    
    @IBOutlet var modalPage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiUpdatesForPage()
    }
    
    func uiUpdatesForPage(){
        
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
        
        let createASheetC = storyboard?.instantiateViewController(withIdentifier: "CreateASheetViewController") as! CreateASheetViewController
        
        createASheetC.temp.append([
            "word": wordTField.text!,
            "translation": translationTField.text!,
            "transcription" : trranscriptionTField.text!,
            "example": exampleTView.text!
            ])
    
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func unwind(_ sender: UIStoryboardSegue){
        print("This is unwinding")
    }
    
}
