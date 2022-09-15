//
//  Watchview.swift
//  Tcpclient
//
//  Created by user on 2022/9/4.
//

import Foundation
import UIKit

class Watchview: UIViewController {
    var serverurl:String?
    
    
   
    let thePlayer : VLCMediaPlayer =
    {
        let player = VLCMediaPlayer()
        return player
    }()
    
    
    
    @IBOutlet weak var thePlayerView: UIView!
    @IBOutlet weak var thePlayBtn: UIButton!
    @IBOutlet weak var theurltext: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(serverurl!)
        
    }
    @IBAction func PlayBtn(_ sender:Any)
    {
        setupthePlayer()
    }
    @IBAction func returnBtn(_ sender:Any)
    {
        thePlayer.stop()
    }
    
    func setupthePlayer(){
        let URL = URL(string: serverurl!)!
        let theMedia = VLCMedia(url: URL)
        
        thePlayer.media = theMedia
        thePlayer.drawable = thePlayerView
        
        thePlayer.play()
        
    }
    
}
