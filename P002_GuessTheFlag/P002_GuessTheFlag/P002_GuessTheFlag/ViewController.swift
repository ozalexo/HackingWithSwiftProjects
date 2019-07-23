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

        prepareInformer()

        askQuestion()

    }

    private func prepareInformer () {
        informer.numberOfLines = 1
        // Disable displaying ellipsis during UILabel's text update
        informer.translatesAutoresizingMaskIntoConstraints = false
        informer.adjustsFontSizeToFitWidth = false
        informer.textAlignment = .left
        informer.font = UIFont(name: "Verdana", size: 14.0)
        informer.text = getInformerText(score: score)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: informer)
    }


    @IBAction func reset(action: UIAlertAction! = nil) {
        score = 0
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

    private func getInformerText(score: Int) -> String {
        return "Score\t\(score)"
    }

    private func showAlert(title: String, message: String, actionTitle: String, handler: ((UIAlertAction) -> Void)?, image: UIImage? = nil) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: handler))
        present(ac, animated: true)
    }


    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            correctAnswer += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        informer.text = getInformerText(score: score)
        showAlert(
            title: title,
            message: "Your score is \(score)",
            actionTitle: "Continue",
            handler: askQuestion
        )

    }
}

