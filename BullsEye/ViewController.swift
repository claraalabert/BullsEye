//
//  ViewController.swift
//  BullsEye
//
//  Created by Clara on 10/2/24.
//

import UIKit

class ViewController: UIViewController {
   
    var currentValue: Int = 0
    var targetValue: Int = 0
    var score = 0
    var roundCount: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var hitMeButton: UIButton!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //slider
        currentValue = Int(slider.value)
        slider.tintColor = .systemOrange
        
        //Hit Me! Button
        hitMeButton.backgroundColor = .gray
        hitMeButton.tintColor = .white
        hitMeButton.layer.cornerRadius = 5
        
        //Score label
        scoreLabel.text = String(score)
        
        //Round label
        roundLabel.text = String(roundCount)
        
        //Game
        startNewRound()
        
        //Custom Slider
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    }
    
    @IBAction func showAlert() {
        //If the substract of the values results negative, get a positive number to show the difference correctly.
        let difference = abs(targetValue-currentValue)
        
        //Calculate points
        var points = 100 - difference
        
        //Preparar el "title" que mostrarà l'alert
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        
        //Sumar la puntuació
        score += points
        
        //Mostrar alerta per pantalla
        //Pas 1:
        let message = "Sliders value is \(currentValue).\nYou scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        //Pas 2:
        alert.addAction(action)
        
        //Pas 3:
        present(alert, animated: true, completion: nil)
       
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        print("The raw value is \(slider.value)")
        let roundedValue = slider.value.rounded()
        print("The rounded value is \(roundedValue)")
        currentValue = Int(roundedValue)
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        roundCount += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(roundCount)
    }
    
    @IBAction func restartGame() {
        let alert = UIAlertController(title: "Reset", message: "Are you sure you want to reset the current game?", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
                    self.resetVariables()
                }
                
                alert.addAction(cancelAction)
                alert.addAction(confirmAction)
                
                present(alert, animated: true, completion: nil)
    }
    
    func resetVariables() {
        score = 0
        roundCount = 0
        startNewRound()
    }
}
