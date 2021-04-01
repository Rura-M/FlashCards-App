//
//  CreationViewController.swift
//  FlashCards-App
//
//  Created by Ruramaimunashe Mutefura on 3/13/21.
//  Copyright © 2021 Ruramaimunashe Mutefura. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    //IBoutlets for text fields
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    
    var initialQuestion: String?
    var initialAnswer: String?
    //Outlets for Extra TextFields
    @IBOutlet weak var extraAnswer1: UITextField!
    @IBOutlet weak var extraAnswer3: UITextField!
    //var initialExtraAnswer1: String?
    //var initialExtraAnswer3: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text=initialQuestion
        answerTextField.text=initialAnswer
        //extraAnswer1.text=initialExtraAnswer1
        //extraAnswer3.text=initialExtraAnswer3
    }
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnDone(_ sender: Any) {
        //Initializations of question and answers
        let questionText = questionTextField.text
        let answerText=answerTextField.text
        
        
        //Check if empty
        if questionText==nil || answerText==nil || questionText!.isEmpty || answerText!.isEmpty{
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and answer", preferredStyle: .alert)
            present(alert, animated: true)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
        }else{
            }
            
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
    }
    

}
