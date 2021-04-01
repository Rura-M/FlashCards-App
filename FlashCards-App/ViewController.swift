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
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
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
        
        //Button Configurations
       /* btnOptionOne.clipsToBounds=true
        btnOptionOne.layer.cornerRadius=20.0
        btnOptionOne.layer.borderWidth=3.0
        btnOptionOne.layer.borderColor=#colorLiteral(red: 0.4247042371, green: 0.1129066691, blue: 1, alpha: 1)
        
        btnOptionTwo.clipsToBounds=true
        btnOptionTwo.layer.cornerRadius=20.0
        btnOptionTwo.layer.borderWidth=3.0
        btnOptionTwo.layer.borderColor=#colorLiteral(red: 0.4247042371, green: 0.1129066691, blue: 1, alpha: 1)
        
        btnOptionThree.clipsToBounds=true
        btnOptionThree.layer.cornerRadius=20.0
        btnOptionThree.layer.borderWidth=3.0
        btnOptionThree.layer.borderColor=#colorLiteral(red: 0.4247042371, green: 0.1129066691, blue: 1, alpha: 1)*/
        
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
        
        creationController.initialQuestion=frontLabel.text
        creationController.initialAnswer=backLabel.text
        if segue.identifier == "Edit Segue"{
            creationController.initialQuestion=frontLabel.text
                   creationController.initialAnswer=backLabel.text
        }
       }
    
    @IBAction func didTapOnBtnOne(_ sender: Any) {
        btnOptionOne.isHidden=true
    }
    
    @IBAction func didTapOnBtnTwo(_ sender: Any) {
        frontLabel.isHidden=true
    }
    @IBAction func didTapOnBtnThree(_ sender: Any) {
        btnOptionThree.isHidden=true
    }
    
    
    @IBAction func didTapFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = true
        })
        
        if frontLabel.isHidden{
                frontLabel.isHidden=false
               }
               else{
                   frontLabel.isHidden=true
               }
    }
    
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0.0)
        }, completion: { finished in
            //Upadet labels
            self.updateLabels()
            
            //Run other animation
            self.animateCardIn()
        })
        
    }
    
    func animateCardIn(){
        //Start on the right side
        card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0.0)
        //Animate going back to original position
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    ///CODE FOR FLASHCARD CONTENT UPDATES ///
    func updateFlashcard(question: String, answer: String) {
        
        let flashcard=Flashcard(question: question, answer: answer)
            //Replace exisitng flashcard
            flashcards[currentIndex] = flashcard
        
            //Adding flashcard in the flashcards array
            flashcards.append(flashcard)
        
        
        frontLabel.text=question
        backLabel.text=answer
        
        //btnOptionOne.setTitle(extraAnswerOne, for: .normal)
       // btnOptionTwo.setTitle(answer, for: .normal)
       // btnOptionThree.setTitle(extraAnswerThree, for: .normal)
        
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
        animateCardOut()
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
            //Lab one is done
        }
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        //Show  confirmation
        let alert = UIAlertController(title: "Delete flashcard?", message: "Are you sure you want to delete?", preferredStyle: .actionSheet)
        present(alert, animated: true)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
    }
    
    func deleteCurrentFlashcard(){
        //Delete current
        flashcards.remove(at: currentIndex)
        //Special case: Check if last card was deleted
        
        if currentIndex>flashcards.count - 1 {
            currentIndex=flashcards.count - 1
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        
    }
    
}

