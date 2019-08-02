//
//  ViewController.swift
//  P005_WordScramble
//
//  Created by Alexey Ozerov on 31/07/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }

        startGame()
    }

    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        // Here we have handler as closure
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ /*action: UIAlertAction*/ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)

        // For the iPads: centered alert popup
        ac.popoverPresentationController?.sourceView = self.view
        ac.popoverPresentationController?.sourceRect = self.view.frame

        present(ac, animated: true)
    }

    func submit(_ answer: String) {

    }

    // MARK: - Table data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

}

