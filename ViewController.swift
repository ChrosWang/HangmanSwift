//
//  ViewController.swift
//  Hangman
//
//  Created by 王哲 on 3/3/19.
//  Copyright © 2019 Chros Wang. All rights reserved.
//
import UIKit
//extension UIStackView {
//    func addBackground(color:UIColor) {
//        let subview = UIView(frame: bounds)
//        subview.backgroundColor = color
 //       subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
 //       insertSubview(subview, at: 0)
//    }
//}
class ViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet var PlaceHolderUnderbar: UIStackView!
    
    @IBOutlet weak var FirstRowLetters: UIStackView!
    @IBOutlet weak var SecondRowLetters: UIStackView!
    @IBOutlet weak var ThirdRowLetters: UIStackView!
    
    @IBOutlet var PlaceHolderLetters: UIStackView!
    
    @IBOutlet weak var HangmanPicture: UIImageView!
    
    @IBAction func TryAgainButton(_ sender: UIButton) {
        initialization()
    }
    var ButtonPressed: UIButton?
    
    var loseCounter = 0
    
    override func viewWillAppear(_ animated: Bool) {
        initialization()
    }
    
    @IBAction func LetterButtonPressed(_ button: UIButton) {
        ButtonPressed = button
        var checked = false
        if let UsersTry = ButtonPressed?.titleLabel?.text {
            for label in PlaceHolderLetters.arrangedSubviews {
                if let temp = label as? placeHolderLabel {
                    if temp.subtext.caseInsensitiveCompare(UsersTry) == .orderedSame {
                        
                       (label as? placeHolderLabel)!.text = (label as? placeHolderLabel)!.subtext
                        checked = true
                    }
                }
            }
            if checked {
                ButtonPressed?.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                var winCheck = true
                for label in PlaceHolderLetters.arrangedSubviews {
                    if let temp = label as? placeHolderLabel {
                        if temp.text == "_" {
                            winCheck = false
                        }
                    }
                }
                if winCheck {
                    Win()
                }
            } else {
                wrongGuess()
                ButtonPressed?.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }
            ButtonPressed?.isEnabled = false
            ButtonPressed = nil
        }
    }
    
    
    
    @IBOutlet weak var TryAgainButtonSee: UIButton!
    
    func wrongGuess() {
        loseCounter += 1
        HangmanPicture.image = UIImage(named:"hangman_" + String(loseCounter))
        if loseCounter == 6 {
            Lose()
            
        }
    }
    
    @IBOutlet weak var GameEndTag: UILabel!
    
    func Lose() {
        GameEndTag.text = "YOU LOSE"
        GameEndTag.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        GameEndTag.alpha = 1
        for label in PlaceHolderLetters.arrangedSubviews {
                    label.alpha = 1
            }
        TryAgainButtonSee.alpha = 1
        TryAgainButtonSee.isEnabled = true
        for letterbuttons in FirstRowLetters.arrangedSubviews{
            if let btn = letterbuttons as? UIButton {
                btn.isEnabled = false
            }
        }
        for letterbuttons in SecondRowLetters.arrangedSubviews{
            if let btn = letterbuttons as? UIButton {
                btn.isEnabled = false
            }
        }
        
        for letterbuttons in ThirdRowLetters.arrangedSubviews{
            if let btn = letterbuttons as? UIButton {
                btn.isEnabled = false
            }
        }
        }
    
    func Win() {
        GameEndTag.text = "YOU WIN"
        GameEndTag.textColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        GameEndTag.alpha = 1
        TryAgainButtonSee.alpha = 1
        TryAgainButtonSee.isEnabled = true
    }
    func initialization() {
        
        //PlaceHolderUnderbar.addBackground(color: UIColor.clear)
        
       // FirstRowLetters.addBackground(color: UIColor.clear)
      //  SecondRowLetters.addBackground(color: UIColor.clear)
      //  ThirdRowLetters.addBackground(color: UIColor.clear)
      //
//PlaceHolderLetters.addBackground(color: UIColor.clear)
        HangmanPicture.image = UIImage(named:"title")
        HangmanPicture.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        loseCounter = 0
        GameEndTag.alpha = 0
        TryAgainButtonSee.alpha = 0
        TryAgainButtonSee.isEnabled = false
        for letterbuttons in FirstRowLetters.arrangedSubviews{
            if let btn = letterbuttons as? UIButton {
                btn.isEnabled = true
                btn.backgroundColor = nil
            }
        }
        for letterbuttons in SecondRowLetters.arrangedSubviews{
            if let btn = letterbuttons as? UIButton {
                btn.isEnabled = true
                btn.backgroundColor = nil
            }
        }
        
        for letterbuttons in ThirdRowLetters.arrangedSubviews{
            if let btn = letterbuttons as? UIButton {
                btn.isEnabled = true
                btn.backgroundColor = nil
            }
        }
        
        let path = Bundle.main.url(forResource:"dictionary", withExtension:"txt")
        let allwordslist = try! String(contentsOf:path!)
        let allwords = allwordslist.components(separatedBy:"\r\n")
        let randomIndex = Int(arc4random_uniform(UInt32(allwords.count)))
        let wordOfChoice = allwords[randomIndex]
        print(wordOfChoice)
        for label in PlaceHolderUnderbar.arrangedSubviews {
            label.removeFromSuperview()
        }
        
        for label in PlaceHolderLetters.arrangedSubviews {
            label.removeFromSuperview()
        }
        
        
        
        let letter = Array(wordOfChoice)
        print(letter)
        var sOn = false
        for eachLetter in letter {
            let LabelL = placeHolderLabel()
            LabelL.font = UIFont.systemFont(ofSize:22)
            LabelL.alpha = 1
            LabelL.subtext = String(eachLetter)
            LabelL.text = "_"
            
            
            if (sOn == true) {
                LabelL.text = "s"
                sOn = false
            }
            
            if (LabelL.subtext == "'") {
                LabelL.text = LabelL.subtext
                sOn = true
            }
            
            
            PlaceHolderLetters.addArrangedSubview(LabelL)
            
            LabelL.layoutIfNeeded()
            
        }
        
        
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
}

