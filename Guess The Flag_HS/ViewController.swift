//
//  ViewController.swift
//  Guess The Flag_HS
//
//  Created by Shah Md Imran Hossain on 17/7/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var scoreButton: UIBarButtonItem!
    @IBOutlet weak var questionCountButton: UIBarButtonItem!
    
    var countries = [String]()
    var questionNum = 0
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy","monaco",
                      "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        // adding layer width
        buttonOne.layer.borderWidth = 1
        buttonTwo.layer.borderWidth = 1
        buttonThree.layer.borderWidth = 1
        
        // defining layer width color
        buttonOne.layer.borderColor = UIColor.lightGray.cgColor
        buttonTwo.layer.borderColor = UIColor.lightGray.cgColor
        buttonThree.layer.borderColor = UIColor.lightGray.cgColor
        
        // starting the game
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        // shuffle the array randomly
        countries.shuffle()
        
        // random select
        correctAnswer = Int.random(in: 0...2)
        
        // question
        title = countries[correctAnswer].uppercased()
        
        // question count
        questionNum += 1
        questionCountButton.title = "Q - \(questionNum)"
        
        // score
        scoreButton.title = "S - \(score)"
        
        // setting button image
        buttonOne.setImage(UIImage(named: countries[0]), for: .normal)
        buttonTwo.setImage(UIImage(named: countries[1]), for: .normal)
        buttonThree.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    private func restartTheGame(action: UIAlertAction! = nil) {
        // reseting the values
        questionNum = 0
        score = 0
        askQuestion()
    }
    
    // button action
    // here, 3 buttons have same button action
    // differentiate them from button tag
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var alert: UIAlertController
        
        if sender.tag == correctAnswer {
            title = "Correct!!!"
            score += 1
            
            alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        } else {
            title = "Wrong!"
            score -= 1
            alert = UIAlertController(title: title, message: "That's the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
        }
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        alert.addAction(UIAlertAction(title: "Stop", style: .cancel, handler: { [self] _ in
            // delcaring stop alert
            let stopAlert = UIAlertController(title: "Score - \(score)", message: "Questions attempted \(questionNum)", preferredStyle: .alert)
            
            // adding retry action
            stopAlert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: restartTheGame))
            
            // adding app quit action
            stopAlert.addAction(UIAlertAction(title: "Quit", style: .cancel, handler: { _ in
                // quiting the app
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                      exit(0)
                     }
                }
            }))
            
            // presenting alert
            present(stopAlert, animated: true)
        }))
        
        present(alert, animated: true)
    }
    
}

