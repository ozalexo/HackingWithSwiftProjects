//
//  TableViewController.swift
//  P004_EasyBrowser
//
//  Created by Alexey Ozerov on 31/07/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var websites = ["apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Select web page to visit"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController {
            vc.websites = websites
            vc.selectedInitialPageIndex = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
