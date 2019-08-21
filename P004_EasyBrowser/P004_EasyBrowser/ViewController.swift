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
    var progressView: UIProgressView!
    var websites = [String]()
    var selectedInitialPageIndex = 0

    // loadView() gets called before viewDidLoad()
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: .plain,
            target: self,
            action: #selector(openTapped)
        )

        // Progress bar
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        // ToolBar Items
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let back = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))

        toolbarItems = [progressButton, spacer, back, forward, refresh]
        navigationController?.isToolbarHidden = false

        // Load first web page
        let url = URL(string: "https://" + websites[selectedInitialPageIndex])!
        webView.load(URLRequest(url: url))
    }

    override func viewWillDisappear(_ animated: Bool) {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)

        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        // "Cancel"button doesn’t provide a handler parameter,
        // which means iOS will just dismiss the alert controller if it’s tapped.
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem

        present(ac, animated: true)
    }

    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }


    // Method to set up title in the Navigation bar
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    func displayNotAllowedAlert (host: String) {
        let ac = UIAlertController(title: "Host does not allowed", message: "\(host) is out of allowed hosts list", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac, animated: true)
    }

    // Only allowed web pages may be visited
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
            displayNotAllowedAlert(host: host)
        }

        decisionHandler(.cancel)
    }

}

