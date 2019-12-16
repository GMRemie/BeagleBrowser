//
//  ViewController.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/13/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, VLCMediaPlayerDelegate, UITabBarDelegate {
    
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    // Back and fourth buttons
    @IBOutlet weak var backbutton: UITabBarItem!
    @IBOutlet weak var forwardButton: UITabBarItem!
    
    
    
    fileprivate var videoPath: URL? {
        didSet{
            performSegue(withIdentifier: "loadVideo", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWeb()
        tabBar.delegate = self
        
        refreshButtons()
    }

    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selected = tabBar.selectedItem
        switch selected?.tag{
        case 1:
            goBack()
            break
        case 2:
            goForward()
            break
        case 3:
            refresh()
            break
        default:
            // DO nothing
            break
        }
    }
    
    // TextField required
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        search()
        return true
    }

    @IBAction func favoriteClicked(_ sender: UIButton) {
    }
    
    
}

extension ViewController{
    // TAB BAR UI CONTROLS
    fileprivate func goBack(){
        if webView.canGoBack{
            webView.goBack()
        }
    }
    fileprivate func goForward(){
        if webView.canGoForward{
            webView.goForward()
        }
    }
    fileprivate func refresh(){
        webView.reload()
    }
}


// Web page controls
extension ViewController: WKUIDelegate,WKNavigationDelegate{
    
    fileprivate func setupWeb(){
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    fileprivate func search(){
        // TODO:: Nil check
        let urlString = searchField.text!
        let validString = urlString.hasPrefix("http") ? urlString : "https://\(urlString)"
        
        // QUERY Support
        
        var url = URL(string: validString)

        if (!validString.isValidURL()){
            url = GoogleAPI.generateURL(searchField.text!)
        }

        guard let readyUrl = url else {
            
            return
        }
        
        let urlRequest = URLRequest(url: readyUrl)
        webView.load(urlRequest)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let DisplayController = segue.destination as? DisplayViewController {
            DisplayController.url = videoPath!
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       refreshButtons()

    }
    
    fileprivate func refreshButtons(){
        // Back button first
        if (webView.canGoBack){
            backbutton.isEnabled = true
        }else{
            backbutton.isEnabled = false
        }
        
        if (webView.canGoForward){
            forwardButton.isEnabled = true
        }else{
            forwardButton.isEnabled = false
        }
    }
    

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // This is a HTTP link
        guard let url = navigationAction.request.url, let scheme = url.scheme, scheme.contains("http") else {
            // This is not HTTP link - can be a local file or a mailto
            decisionHandler(.cancel)
            return
        }
        // TODO:: Not working
        guard navigationAction.request.isWebmLink else {
               decisionHandler(.allow)
            return
           }
        
        decisionHandler(.allow)
        videoPath = navigationAction.request.url!
        
    }
    
    
    
}
