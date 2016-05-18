//
//  ViewController.swift
//  lalalaTwitter
//
//  Created by Cata on 13/05/16.
//  Copyright © 2016 Cata. All rights reserved.
//

import UIKit
import TwitterKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initTwittter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTwittter(){
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                    message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                
                if(Twitter.sharedInstance().sessionStore.session()!.userID != ""){
                    Globals.globals.userID = Int(Twitter.sharedInstance().sessionStore.session()!.userID)!
                    self.getBarerToken()
                    
                    print("logged")
                }else{
                    print("not logged")
                }
            // TODO: Base this Tweet ID on some data from elsewhere in your app
                    // make requests with client

                
                self.performSegueWithIdentifier("goinapp", sender: self)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        // TODO: Change where the log in button is positioned in your view
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

    }
    
    
    func getBarerToken (){
        let secret = "KaiY5W9G0gw2WE3scmOtT6ctA:1RUDE5678JQojFrXmbOeo5iDnIpNDCs2jVAEsmzQ6WQIiDNqce"
        let base64Encoded = secret.dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        let getBarerTokenURL = "https://api.twitter.com/oauth2/token"
        
        let headers = [
            "Authorization" : "Basic " + base64Encoded,
            "Content-Type" : "application/x-www-form-urlencoded;charset=UTF-8"
        ]
        
        let params = [
            "grant_type" : "client_credentials",
        ]
        
        Alamofire.request(.POST, getBarerTokenURL, parameters: params, headers: headers)
            .responseJSON{
                response in
                print(response)
                Globals.globals.tokenType = response.result.value!["token_type"] as! String
                Globals.globals.token = response.result.value!["access_token"] as! String

                
        }
        
    }
    
    
    func printUserCredentials(){
        print("Toke: \(Globals.globals.token)\nToken Type: \(Globals.globals.tokenType)\nUser ID: \(Globals.globals.userID)\n")
        
    }


}


