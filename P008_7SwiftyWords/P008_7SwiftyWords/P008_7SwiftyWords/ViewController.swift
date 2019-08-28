//
//  ViewController.swift
//  P008_7SwiftyWords
//
//  Created by Alexey Ozerov on 21.08.2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var attemptsLabel: UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()

    var solutions = [String]()
    let allowMistakesAmount = 3
    var level = 1

    // MARK: - Observed properties
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }

    var attemptsRemaining = 0 {
        didSet {
            attemptsLabel.text = "Attempts remaining: \(attemptsRemaining)"
        }
    }

    override func loadView() {

        // MARK: - Components
        view = UIView()
        view.backgroundColor = .white

        attemptsLabel = UILabel()
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsLabel.textAlignment = .left
        attemptsLabel.text = "Attempts remaining: \(self.attemptsRemaining)"
        view.addSubview(attemptsLabel)

        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)

        cluesLabel = UILabel()
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)

        answersLabel = UILabel()
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.numberOfLines = 0
        answersLabel.textAlignment = .right
        view.addSubview(answersLabel)

        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)

        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(tappedSubmit), for: .touchUpInside)
        view.addSubview(submit)

        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(tappedClear), for: .touchUpInside)
        view.addSubview(clear)

        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        // set gray border around buttons
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        buttonsView.layer.borderWidth = 1
        view.addSubview(buttonsView)

        // MARK: - Attempts Label's Constrains
        let attemptsLabelConstrains = [
            attemptsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            attemptsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
        ]

        // MARK: - Score Label's Constrains
        let scoreLabelConstrains = [
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ]

        // MARK: - Clues Label's Constrains
        let cluesLabelConstrains = [
            // pin the top of the clues label to the bottom of the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

            // pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),

            // make the clues label 60% of the width of our layout margins, minus 100
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
        ]

        // MARK: - Answers Label's Constrains
        let answersLabelConstrains = [
            // also pin the top of the answers label to the bottom of the score label
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

            // make the answers label stick to the trailing edge of our layout margins, minus 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),

            // make the answers label take up 40% of the available space, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),

            // make the answers label match the height of the clues label
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
        ]

        // MARK: - Current Answer Label's Constrains
        let currentAnswerLabelConstrains = [
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
        ]

        // MARK: - Submit Button's Constrains
        let submitButtonConstraints = [
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
        ]

        // MARK: - Clear Button's Constrains
        let clearButtonConstraints = [
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
        ]

        // MARK: - Buttons View's Constrains
        let buttonsViewConstraints = [
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
        ]

        let allConstrains = [
            attemptsLabelConstrains,
            scoreLabelConstrains,
            cluesLabelConstrains,
            answersLabelConstrains,
            currentAnswerLabelConstrains,
            submitButtonConstraints,
            clearButtonConstraints,
            buttonsViewConstraints,
        ].flatMap({ $0 })

        NSLayoutConstraint.activate(allConstrains)

        // set some values for the width and height of each button
        let width = 150
        let height = 80

        // create 20 buttons as a 4x5 grid
        for row in 0..<4 {
            for col in 0..<5 {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .custom)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitleColor(UIColor.systemBlue, for: UIControl.State())

                // calculate the frame of this button using its column and row
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame

                // pressing button reaction
                letterButton.addTarget(self, action: #selector(tappedLetterBit), for: .touchUpInside)

                // add it to the buttons view
                buttonsView.addSubview(letterButton)

                // and also to our letterButtons array
                letterButtons.append(letterButton)
            }
        }
    }

    // MARK: - Handlers
    @objc func tappedLetterBit(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }

    @objc func tappedSubmit(_ sender: UIButton) {
        guard let answerText = currentAnswer.text else { return }

        attemptsRemaining -= 1

        if let solutionPosition = solutions.firstIndex(of: answerText) {
            answerUpdate(at: solutionPosition, with: answerText)
            score += 1
            gameCheckWinCondition(correct: true)
        } else {
            score -= 1
            gameCheckWinCondition(correct: false)
        }
    }

    @objc func tappedClear(_ sender: UIButton) {
        answerReset()
    }

    // MARK: - Alerts
    func alertWin() {
        let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
        present(ac, animated: true)
    }

    func alertReplay() {
        let ac = UIAlertController(title: "Saddened by your failure", message: "Are you ready to try again?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelReset))
        present(ac, animated: true)
    }

    func alertMistake() {
        let ac = UIAlertController(title: "Incorrect answer", message: "You loose a score", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: answerReset))
        present(ac, animated: true)
    }

    func alertNewGame() {
        let ac = UIAlertController(title: "It was last level", message: "Start game again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: gameRestart))
        present(ac, animated: true)
    }

    // MARK: - Business logic methods
    func gameCheckWinCondition(correct: Bool) {

        // check absolute win condition (max scores or max scores - 1 with 0 or 2 remaining attempts)
        let isAbsoluteWin: Bool = score == solutions.count || ((attemptsRemaining == 0 || attemptsRemaining == 2) && score == solutions.count - 1)
        if isAbsoluteWin {
            alertWin()
            return
        }

        if attemptsRemaining != 0 {
            if correct {
                return
            } else {
                alertMistake()
            }
        } else {
            // In all other conditions game failed
            alertReplay()
        }
    }

    func answerUpdate(at solutionPosition: Int, with answerText: String) {
        activatedButtons.removeAll()

        var splitAnswers = answersLabel.text?.components(separatedBy: .newlines)
        splitAnswers?[solutionPosition] = answerText
        answersLabel.text = splitAnswers?.joined(separator: "\n")

        currentAnswer.text = ""
    }

    func answerReset (action: UIAlertAction! = nil) {
        currentAnswer.text = ""

        for btn in activatedButtons {
            btn.isHidden = false
        }

        activatedButtons.removeAll()
    }

    func levelReset(action: UIAlertAction! = nil) {
        score = 0
        solutions.removeAll(keepingCapacity: true)
        currentAnswer.text = ""
        levelLoad()
    }

    func levelUp(action: UIAlertAction! = nil) {
        level += 1
        levelReset()
        for btn in letterButtons {
            btn.isHidden = false
        }
    }

    func gameRestart(action: UIAlertAction) {
        level = 1
        levelReset(action: action)
    }

    func levelLoad() {
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {

            var clueString = ""
            var solutionString = ""
            var letterBits = [String]()

            if let levelContents = try? String(contentsOf: levelFileURL) {
                var lines = levelContents.components(separatedBy: .newlines)
                lines.shuffle()

                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]

                    clueString += "\(index + 1). \(clue)\n"

                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)

                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
                // Let's allow to an user to make allowMistakesAmount (3) mistakes
                attemptsRemaining = solutions.count + allowMistakesAmount
            }

            // Now configure the buttons and labels
            cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

            letterBits.shuffle()

            if letterBits.count == letterButtons.count {
                for i in 0 ..< letterButtons.count {
                    letterButtons[i].setTitle(letterBits[i], for: UIControl.State())
                }
            }
        } else {
            alertNewGame()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        levelLoad()
    }


}

