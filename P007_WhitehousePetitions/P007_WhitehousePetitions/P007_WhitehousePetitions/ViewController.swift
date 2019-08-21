//
//  ViewController.swift
//  P007_WhitehousePetitions
//
//  Created by Alexey Ozerov on 10/08/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        // Bad idea to download data in main thread in viewDidLoad. UI will be stalled during download
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                setupToolBar()
                return
            }
        }

        showError()
    }

    func setupToolBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Credits",
            style: .plain,
            target: self,
            action: #selector(showCredits)
        )
        let searchButton = UIBarButtonItem(
            title: "Search",
            style: .plain,
            target: self,
            action: #selector(promptSearch)
        )
        let resetSearchButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(resetSearch))
        resetSearchButton.isEnabled = false
        navigationItem.leftBarButtonItems = [searchButton, resetSearchButton]

    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }

    @objc func promptSearch() {
        let ac = UIAlertController(title: "Enter text", message: nil, preferredStyle: .alert)
        ac.addTextField()

        // Here we have handler as closure
        let searchAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ /*action: UIAlertAction*/ in
            guard let searchText = ac?.textFields?[0].text else { return }
            self?.search(for: searchText)
        }

        ac.addAction(searchAction)

        present(ac, animated: true)
    }

    func switchResetSearchButton () {
        let clearButton = navigationItem.leftBarButtonItems![1]
        clearButton.isEnabled = !clearButton.isEnabled
    }

    @objc func resetSearch() {
        switchResetSearchButton()
        filteredPetitions = petitions
        tableView.reloadData()
    }

    func search(for searchText: String) {
        filteredPetitions = [] // Clean up before use

        for petition in petitions {
            if petition.title.contains(searchText) || petition.body.contains(searchText) {
                filteredPetitions.append(petition)
            }
        }
        if filteredPetitions.count > 0 {
            switchResetSearchButton()
            tableView.reloadData()
        } else {
            let ac = UIAlertController(title: "Nothing found", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            present(ac, animated: true)
        }
    }

    @objc func showCredits() {
        let ac = UIAlertController(title: "Info", message: "Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(ac, animated: true)
    }

    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(ac, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

