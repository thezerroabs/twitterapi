//
//  TweetViewController.swift
//  lalalaTwitter
//
//  Created by Cata on 13/05/16.
//  Copyright © 2016 Cata. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit
import Alamofire

class TweetViewController: UIViewController{
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBAction func sendBtnPressed(sender: UIButton) {
        // TODO send soemthing

    }
    
    override func viewDidLoad(){
        super.viewDidLoad();
        
        // TODO: Base this Tweet ID on some data from elsewhere in your app
        TWTRAPIClient().loadTweetWithID("631879971628183552") { (tweet, error) in
            if let unwrappedTweet = tweet {
                let tweetView = TWTRTweetView(tweet: unwrappedTweet)
                tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2);
                self.view.addSubview(tweetView)
            } else {
                NSLog("Tweet load error: %@", error!.localizedDescription);
            }
        }

    }
}