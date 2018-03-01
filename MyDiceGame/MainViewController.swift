//
//  ViewController.swift
//  MyDiceGame
//
//  Created by Namrata A on 2/19/18.
//  Copyright © 2018 Namrata A. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var gameScore: UILabel!
    @IBOutlet weak var gameRound: UILabel!
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var playerDiceRoll: UIImageView!
    @IBOutlet weak var computerDiceRoll: UIImageView!
    
    @IBOutlet weak var sumNumber: UITextField!
    
    var computerValue: Int = 0
    var playerValue: Int = 0
    var roundNumber: Int = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateLabels()
        playerDiceRoll.image = UIImage(named: "0")
        computerDiceRoll.image = UIImage(named: "0")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetGame(_ sender: UIButton) {
        score = 0
        roundNumber = 0
        updateLabels()
    }
    
    func updateLabels(){
        gameScore.text = String(score)
        gameRound.text = String(roundNumber)
    }
    
    @IBAction func playerRoll(_ sender: UIButton) {
        let sumValue = sumNumber.text
        
        if(sumValue == "" ){
            let alert  = UIAlertController(title: "You have to set Number between 2 and 12 first!",
                                           message: "Set a number in the \"Enter Your Number\" field",
                                           preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            playerValue = 1 + Int(arc4random_uniform(6))
            updateImage(value: playerValue, role: "Player")
            computerRoll(sumValue: sumValue!)
        }
    }
    
    func computerRoll(sumValue: String) {
        computerValue = 1 + Int(arc4random_uniform(6))
        updateImage(value: computerValue, role: "Computer")
        gameLogic(sumValue: sumValue)
    }
    
    func updateImage(value: Int, role: String){
        switch value{
        case 1: if role == "Player" {
            playerDiceRoll.image = UIImage(named: "1")
        } else {
            computerDiceRoll.image = UIImage(named: "1")
            }
            
        case 2: if role == "Player" {
            playerDiceRoll.image = UIImage(named: "2")
        } else {
            computerDiceRoll.image = UIImage(named: "2")
            }
            
        case 3: if role == "Player" {
            playerDiceRoll.image = UIImage(named: "3")
        } else {
            computerDiceRoll.image = UIImage(named: "3")
            }
            
        case 4: if role == "Player" {
            playerDiceRoll.image = UIImage(named: "4")
        } else {
            computerDiceRoll.image = UIImage(named: "4")
            }
            
        case 5: if role == "Player" {
            playerDiceRoll.image = UIImage(named: "5")
        } else {
            computerDiceRoll.image = UIImage(named: "5")
            }
            
        case 6: if role == "Player" {
            playerDiceRoll.image = UIImage(named: "6")
        } else {
            computerDiceRoll.image = UIImage(named: "6")
            }
            
        default:
            playerDiceRoll.image = UIImage(named: "0")
            computerDiceRoll.image = UIImage(named: "0")
        }
    }
    
    func gameLogic(sumValue: String){
        if(roundNumber != 10){
            roundNumber += 1
            if (String(computerValue + playerValue) == sumValue){
                score += 2
                updateSuccResult()
            } else {
                updateFailResult()
            }
            updateLabels()
        } else {
            let alert  = UIAlertController(title: "You can play only 10 rounds per game!",
                                           message: "Reset game to play again.",
                                           preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK",
                                       style: .default,
                                       handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func updateSuccResult(){
        result.text = String("Congratulations! You win 2 points!")
    }
    
    func updateFailResult(){
        result.text = String("Sorry! Sum does not equal number entered.")
    }
    
}

