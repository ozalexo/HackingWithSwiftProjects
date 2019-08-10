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
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    @objc func showCredits() {
        let ac = UIAlertController(title: "Info", message: "Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        // For the iPads: centered alert popup
        ac.popoverPresentationController?.sourceView = self.view
        ac.popoverPresentationController?.sourceRect = self.view.frame

        present(ac, animated: true)
    }

    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        // For the iPads: centered alert popup
        ac.popoverPresentationController?.sourceView = self.view
        ac.popoverPresentationController?.sourceRect = self.view.frame

        present(ac, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
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

