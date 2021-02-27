//
//  ViewController.swift
//  FlashCards-App
//
//  Created by Ruramaimunashe Mutefura on 2/26/21.
//  Copyright © 2021 Ruramaimunashe Mutefura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
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
        
        //Buttons Configuration
        btnOptionOne.clipsToBounds=true
        btnOptionOne.layer.cornerRadius=20.0
        btnOptionOne.layer.borderWidth=3.0
        btnOptionOne.layer.borderColor=#colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        
        btnOptionTwo.clipsToBounds=true
        btnOptionTwo.layer.cornerRadius=20.0
        btnOptionTwo.layer.borderWidth=3.0
        btnOptionTwo.layer.borderColor=#colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        
        btnOptionThree.clipsToBounds=true
        btnOptionThree.layer.cornerRadius=20.0
        btnOptionThree.layer.borderWidth=3.0
        btnOptionThree.layer.borderColor=#colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
        
        
    }

    @IBAction func didTapFlashcard(_ sender: Any) {
        
        if frontLabel.isHidden{
            frontLabel.isHidden=false
        }
        else{
            frontLabel.isHidden=true
        }
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden=true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden=true
    }
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden=true
    }
    
}

