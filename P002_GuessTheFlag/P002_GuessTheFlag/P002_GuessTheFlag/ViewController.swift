//
//  ViewController.swift
//  P002_GuessTheFlag
//
//  Created by Alexey Ozerov on 22/07/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var informer = UILabel()
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var answeredQuestions = 0
    var maxQuestions = 10 // Maximum amount of questions for one game

    override func viewDidLoad() {
        super.viewDidLoad()

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        countries += ["estonia", "france", "germany", "ireland",
                      "italy", "monaco", "nigeria", "poland", "russia", "spain",
                      "uk", "us"]

        navigationItem.rightBarButtonItem?.isEnabled = false
        prepareInformer()

        askQuestion()

    }

    private func prepareInformer () {
        informer.numberOfLines = 2
        // Disable displaying ellipsis during UILabel's text update
        informer.translatesAutoresizingMaskIntoConstraints = false
        informer.adjustsFontSizeToFitWidth = false
        informer.textAlignment = .left
        informer.font = UIFont(name: "Verdana", size: 12.0)
        informer.attributedText = getInformerText()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: informer)
    }


    @IBAction func reset(action: UIAlertAction! = nil) {
        score = 0
        correctAnswer = 0
        answeredQuestions = 0
        informer.attributedText = getInformerText()
        navigationItem.rightBarButtonItem?.isEnabled = false
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = countries[correctAnswer].uppercased()
    }

    private func getInformerText() -> NSAttributedString {
        let boldAttrs = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: score >= 0 ? UIColor.green : UIColor.red
        ]

        let prefixNormText = "Score\t"
        let scoreBoldText = NSMutableAttributedString(string: String(score), attributes: boldAttrs)
        let postfixNormText = "\nQuestion\t\(answeredQuestions) of \(maxQuestions)"

        let attributedString = NSMutableAttributedString(string: prefixNormText)
        attributedString.append(scoreBoldText)
        attributedString.append(NSMutableAttributedString(string: postfixNormText))
        return attributedString
    }

    private func showAlert(title: String, message: String, actionTitle: String, handler: ((UIAlertAction) -> Void)?, image: UIImage? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        present(ac, animated: true)
    }


    @IBAction func buttonTapped(_ sender: UIButton) {

        answeredQuestions += 1
        if (answeredQuestions == 1) {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        if sender.tag == correctAnswer {
            score += 1
            correctAnswer += 1
            askQuestion()
        } else {
            score -= 1
            showAlert(
                title: "Wrong",
                message: "That’s the flag of \(countries[sender.tag].uppercased())",
                actionTitle: "Continue",
                handler: askQuestion
            )
        }
        if answeredQuestions == maxQuestions {
            showAlert(
                title: "The end",
                message: "Your final score: \(score)",
                actionTitle: "Start again",
                handler: reset
            )
        }

        informer.attributedText = getInformerText()

    }
}

