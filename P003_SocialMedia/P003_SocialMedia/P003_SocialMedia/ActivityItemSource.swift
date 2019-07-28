//
//  ActivityItemSource.swift
//  P003_SocialMedia
//
//  Created by Alexey Ozerov on 26/07/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

final class ActivityItemSource: NSObject, UIActivityItemSource {


    private var title: String!
    private var image: UIImage!

    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
    }

    // Placeholder
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        if let pngData = image.pngData() {
            return UIImage(data: pngData)!
        } else {
            return "No image found"
        }
    }

    // Body
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        switch activityType {
        case UIActivity.ActivityType(rawValue: "ph.telegra.Telegraph.Share"):
            // In case of Telegram we should convert image into PNG.
            // I do not know why TG does not accept JPG.
            if let pngData = image.pngData() {
                return UIImage(data: pngData)
            } else {
                return "No image found"
            }
        default:
            if let image = image.jpegData(compressionQuality: 1.0) {
                return image
            } else {
                return "No image found"
            }
        }
    }

    // Subject
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }
}
