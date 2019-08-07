//
//  ViewController.swift
//  P006B_AutoLayoutInCode
//
//  Created by Alexey Ozerov on 07/08/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label1 = UILabel()

        /**
        By default iOS generates Auto Layout constraints for you based on a view's size and position.
        We'll be doing it by hand, so we need to disable this feature.
        */
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        // Label will be sized to its content
        label1.sizeToFit()

        let label2 = UILabel()

        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        label2.sizeToFit()

        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        label3.sizeToFit()

        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        label4.sizeToFit()

        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        label5.sizeToFit()

        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)

        /*
        // MARK: - Auto Layout Visual Format Language (VFL)

        let viewsDictionary = [
            "label1": label1,
            "label2": label2,
            "label3": label3,
            "label4": label4,
            "label5": label5
        ]

        // Horizontal constraints
        for label in viewsDictionary.keys {
            // VFL generates multiple constraints at a time
            view.addConstraints( NSLayoutConstraint.constraints(
                // H:  horizontal constraints.
                // |   the edge of the view controller
                // [   left edge of the view
                // ]   right edge of the view
                withVisualFormat: "H:|[\(label)]|",
                options: [],
                metrics: nil,
                views: viewsDictionary)
            )
        }

        // Vertical constraints
        let metrics = ["labelHeight": 88, "bottomEdge": 10]
        view.addConstraints(NSLayoutConstraint.constraints(
            // V:         vertical constraints.
            // -          means "space". It's 10 points by default (customizable)
            // (==88)     label's height
            // -(>=10)-|  last label must be at least 10 points away from the bottom of the view controller's view
            // ==         exactly equal
            // >=         greater than or equal to
            // @999       constraint's priority. 1000 - this is absolutely required, 999 is very important, but not required
            withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]-(>=bottomEdge)-|",
            options: [],
            metrics: metrics,
            views: viewsDictionary)
        )
        */

        // MARK: - Auto Layout VFL and Anchors

        var previous: UILabel?

        for label in [label1, label2, label3, label4, label5] {
            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 88).isActive = true

            if let previous = previous {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                // this is the first label
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
    }


}

