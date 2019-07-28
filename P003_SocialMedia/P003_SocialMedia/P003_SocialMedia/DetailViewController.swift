//
//  DetailViewController.swift
//  P003_SocialMedia
//
//  Created by Alexey Ozerov on 22/07/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageTitle = selectedImage {
            title = "\(imageTitle) (\(selectedPictureNumber) of \(totalPictures))"
        } else {
            title = "Image \(selectedPictureNumber) of \(totalPictures)"
        }
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(shareTapped)
        )

        if let imageToLoad = selectedImage {
            imageView.image  = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped () {
        guard let image = imageView.image, let title = selectedImage else {
            return
        }
        let items: [Any] = [ActivityItemSource(title: title, image: image)]
        let shareActivityController = UIActivityViewController(activityItems: items, applicationActivities: nil)

        shareActivityController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(shareActivityController, animated: true)
    }
}
