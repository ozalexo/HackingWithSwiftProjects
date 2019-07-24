//
//  ViewController.swift
//  P001_StormViewer
//
//  Created by Alexey Ozerov on 22/07/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIActivityItemSource {

    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendTheApp))

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
    }

    // MARK: - TableView Behaviours

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.totalPictures = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - Activity View Controller

    /**
     * Made with https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example
     * Paragraph: "Adding a subject"
     */

    @objc func recommendTheApp() {
        let items = [self]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }

    // This text will be shared via Telegram or Messages
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Recommend StormViewer"
    }

    // This text will be a body of new email
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return "I would recommend StormViewer"
    }

    // This text will be a subject of new email
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "App recommendation: StormViewer"
    }
}
