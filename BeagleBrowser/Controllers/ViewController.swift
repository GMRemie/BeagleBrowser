//
//  ViewController.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/13/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, VLCMediaPlayerDelegate {
    
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWeb()
    }

    
    // TextField required
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        search()
        return true
    }

}


extension ViewController: WKUIDelegate,WKNavigationDelegate{
    
    fileprivate func setupWeb(){
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    fileprivate func search(){
        // TODO:: Nil check
        print("Search called on term: ",searchField.text!)
        let urlString = searchField.text!
        let validString = urlString.hasPrefix("http") ? urlString : "https://\(urlString)"
        
        guard let url = URL(string: validString) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        
       
        
    }

    
    func demo (){
        performSegue(withIdentifier: "loadVideo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DisplayController = segue.destination as? DisplayViewController {
            DisplayController.url = URL(string: "https://is2.4chan.org/wsg/1576181504839.webm")!
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading page")

    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed nav")
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("JSC control")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction.request.url?.absoluteString!)
        // This is a HTTP link
        guard let url = navigationAction.request.url, let scheme = url.scheme, scheme.contains("http") else {
            print("Local or mailto file")
            // This is not HTTP link - can be a local file or a mailto
            decisionHandler(.cancel)
            return
        }
        // TODO:: Not working
        guard navigationAction.request.isHttpLink else {
            print("HttpLink")
               decisionHandler(.allow)
               return
           }
        
        decisionHandler(.allow)
    }
    
}
