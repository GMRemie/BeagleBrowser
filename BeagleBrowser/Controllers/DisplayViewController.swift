//
//  DisplayViewController.swift
//  BeagleBrowser
//
//  Created by Joseph Storer on 12/14/19.
//  Copyright © 2019 Joseph Storer. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController, VLCMediaPlayerDelegate{
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var playToggle: UIButton!
    @IBOutlet weak var titleLbl: UINavigationItem!
    
    // Actual views for hiding later
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIView!
    
    
    // Slider details
    fileprivate var videoTime: Int32?
    
    // Media player functionality
    
    @IBOutlet weak var movieView: UIView!
    var mediaPlayer: VLCMediaPlayer = VLCMediaPlayer()
    
    // Data passed in
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Passed in URL",url?.absoluteString)
        prepareVideoPlayer()
       
        
        // Smooth corners of view controller
        toolBar.layer.cornerRadius = 10
    }
    
    fileprivate func prepareVideoPlayer (){

        //Add tap gesture to movieView for displaying navigation controls
        // Add a delay to hide it
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleViews))
        movieView.addGestureRecognizer(gesture)

        loadVideo()
    }
    
    @objc fileprivate func toggleViews(){
        if toolBar.alpha == 0.0 {
            let anim = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
                self.navBar.alpha = 1.0
                self.toolBar.alpha = 1.0
            }
            anim.startAnimation()
        }else{
            let anim = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn) {
                self.navBar.alpha = 0.0
                self.toolBar.alpha = 0.0
            }
            anim.startAnimation()
        }
        
    }
    
    fileprivate func loadVideo(){
        
        // Handle our URL potential errors
        
        
        //TODO:: Check if url is properly formatted
        
        // Prepare our VLC Media Object
        let media = VLCMedia(url: url!)
        
        // Assign our VLC Media player delegates
        mediaPlayer.delegate = self
        mediaPlayer.drawable = self.movieView

        
        // Current option // check later
       // media.addOptions([
        //    "network-caching": 300
       // ])
        mediaPlayer.media = media

        
        mediaPlayer.play()
        print("Will play ", mediaPlayer.willPlay)
        
        // Load title
        let titleText = mediaPlayer.media.metaDictionary["title"]
        titleLbl.title = titleText as! String
        //print(mediaPlayer.media.metaDictionary)
    }
    
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
       // print("State has chenged ")
       // print(aNotification)
    }
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        print("TIME CHANGE:",aNotification)
        let obj = aNotification.object as! VLCMediaPlayer
        
        print(obj.media.length.intValue)
        
        if videoTime == nil{
            videoTime = obj.media.length.intValue
            timeSlider.maximumValue = Float(videoTime!)
            timeSlider.minimumValue = 0.0
            
        }
        
        timeSlider.value = Float(obj.time.intValue)
    }
    fileprivate func toggleVideo(){
        if mediaPlayer.isPlaying{
            mediaPlayer.pause()
        }else{
            mediaPlayer.play()
        }
    }
    
    // Video controls
    
    @IBAction func togglePlay(_ sender: UIButton) {
        toggleVideo()
    }
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        
    }
    
    
    
    
    
    
    // Exit
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        mediaPlayer.pause()
        self.dismiss(animated: true, completion: nil)
    }
    
}