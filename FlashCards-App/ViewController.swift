//
//  ViewController.swift
//  FlashCards-App
//
//  Created by Ruramaimunashe Mutefura on 2/26/21.
//  Copyright © 2021 Ruramaimunashe Mutefura. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    //Prev and Next Button
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    //@IBOutlet weak var btnOptionOne: UIButton!
    //@IBOutlet weak var btnOptionTwo: UIButton!
    //@IBOutlet weak var btnOptionThree: UIButton!
    //Array to hold flashcards
    var flashcards=[Flashcard]()
    
    //Current flashcard Index
    var currentIndex=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Card Configurations
        card.layer.cornerRadius=20.0
        card.layer.shadowRadius=15.0
        card.layer.shadowOpacity=0.2
        
        //Labels Configurations
        frontLabel.clipsToBounds=true
        frontLabel.layer.cornerRadius=20.0
        backLabel.clipsToBounds=true
        backLabel.layer.cornerRadius=20.0
        //Read saved flashcards
        readSavedFlashcards()
        //Adding our initial flashcard if needed
        if flashcards.count == 0{
         updateFlashcard(question: "Whats goes up when the rains come down?", answer: "An Umbrella")
        }else{
            updateLabels()
            updateNextPrevButtons()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let navigationController = segue.destination as! UINavigationController
           let creationController = navigationController.topViewController as! CreationViewController
           
           creationController.flashcardsController = self
       }
    
    @IBAction func didTapFlashcard(_ sender: Any) {
        
        if frontLabel.isHidden{
            frontLabel.isHidden=false
        }
        else{
            frontLabel.isHidden=true
        }
    }
    
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard=Flashcard(question: question, answer: answer)
        frontLabel.text=question
        backLabel.text=answer
        
        //Adding flashcards in the array
        flashcards.append(flashcard)
        
        //Logging to console
        print("😎 Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        //Update current Index
        currentIndex = flashcards.count - 1
        print(":) Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
   
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        currentIndex=currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //Increase current Index
        currentIndex=currentIndex + 1
        
        //Update labels
        updateLabels()
        //Update buttons
        updateNextPrevButtons()
    }
    
    func updateNextPrevButtons(){
        //Disable next  if at end
        if currentIndex==flashcards.count-1{
            nextButton.isEnabled=false
        }else{
            nextButton.isEnabled=true
        }
        
        //Disable previous button
        if currentIndex==0{
            prevButton.isEnabled=false
        }else{
            prevButton.isEnabled=true
        }
    }
    
    func updateLabels(){
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update Labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
    }
    
    func saveAllFlashcardsToDisk(){
        //From Flashcasrd array to dictionary
        let dictionaryArray = flashcards.map{(card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        //Save array using User defaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //Log it
        print("Yay!Flashcard saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        //Read dictionary array from disk if any
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            let savedCards = dictionaryArray.map{dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
             //Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
}

