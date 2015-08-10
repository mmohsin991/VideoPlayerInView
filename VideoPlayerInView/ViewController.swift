//
//  ViewController.swift
//  VideoPlayerInView
//
//  Created by Mohsin on 19/07/2015.
//  Copyright (c) 2015 Mohsin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer


private var myContext = 0


class ViewController: UIViewController {


    var player : AVPlayer?
    var av : AVPlayerViewController?
    var isPlaying = false

    
    
    var MPPlayer:MPMoviePlayerController!

    
    
    
    
    let sample = NSBundle.mainBundle().URLForResource("sample", withExtension: "mp4")
    let myVideo = NSBundle.mainBundle().URLForResource("myVideo", withExtension: "MOV")
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    
    func avPlay(url: NSURL){
        
        let av = AVPlayerViewController()
        let player = AVPlayer(URL: url)
        av.player = player
        self.presentViewController(av, animated: true, completion: nil)
    }

    
    
    func playInView(url: NSURL){
        
        
        // for MPMoviewPlayer
//        
//        self.MPPlayer = MPMoviePlayerController(contentURL: url)
//        self.MPPlayer.view.frame = self.view.frame
//        
//        self.view.addSubview(self.MPPlayer.view)
//        
//        self.MPPlayer.prepareToPlay()
//        self.MPPlayer.play()
//        
//        
//        
        
        
        
        
        
        self.player = AVPlayer(URL: url)
        
        self.av = AVPlayerViewController()
        
        
        self.av?.player = player
        
        av?.view.frame = self.view.frame
        av?.showsPlaybackControls = false
        av?.view.backgroundColor = UIColor.clearColor()
        
        
        av?.addObserver(self, forKeyPath: "readyForDisplay", options: NSKeyValueObservingOptions.New, context:  &myContext)
        
        if self.av != nil && self.player != nil {
            
            println(self.av?.readyForDisplay)

            
            self.addChildViewController(av!)
            self.view.addSubview(av!.view)
            self.view.bringSubviewToFront(self.contentView)
            self.player!.play()
        
        }

        

    }
    

    
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        
        
        println(self.av?.readyForDisplay)
        
        
    }
    
    
    @IBAction func play(sender: UIButton) {
        
      //  self.avPlay(self.myVideo!)
        
        
        
        
        
        if player == nil {
            self.playInView(self.sample!)
            sender.setTitle("Pause", forState: .Normal)
            self.isPlaying = true
        }
            
            // given below is play/pause logic (which is optional)
        else{
            if self.isPlaying{
                self.player?.pause()
                self.isPlaying = false
                sender.setTitle("Play", forState: .Normal)
            }
            else{
                self.player?.play()
                self.isPlaying = true
                sender.setTitle("Pause", forState: .Normal)
            }
        }
        
        
    }
    
    
}

