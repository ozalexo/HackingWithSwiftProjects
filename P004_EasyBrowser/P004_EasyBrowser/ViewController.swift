//
//  ViewController.swift
//  P004_EasyBrowser
//
//  Created by Alexey Ozerov on 29/07/2019.
//  Copyright © 2019 Alexey Ozerov. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!

    // loadView() gets called before viewDidLoad()
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }


}

