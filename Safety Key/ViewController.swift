//
//  ViewController.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 27/02/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    /**
            OBJECTS
     */
    
    var facebook = FacebookUtil()
    
    
    
    /**
            OUTLETS VIEW
     */
    @IBOutlet weak var emailTx: UITextField!
    @IBOutlet weak var passwordTx: UITextField!
    
    
    
    /**
            ACTIONS VIEW
    */
    @IBAction func register(sender: AnyObject) {
    }
    @IBAction func signInSimple(sender: AnyObject) {
        self.performSegueWithIdentifier("forHome", sender: self)
    }
    
    @IBAction func signInFacebook(sender: AnyObject) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        let permissions = ["public_profile", "email", "user_friends"]
        
        
        fbLoginManager.logInWithReadPermissions(permissions, handler: { (result, error) -> Void in
            
            if (error == nil){
                
                if let fbloginresult : FBSDKLoginManagerLoginResult = result {
                    
                    if(fbloginresult.grantedPermissions.contains("email")) {
                        
                        if((FBSDKAccessToken.currentAccessToken()) != nil){
                            
                            //self.returnUserData()
                            self.performSegueWithIdentifier("forHome", sender: self)
                        }
                        //fbLoginManager.logOut()
                       // self.performSegueWithIdentifier("forHome", sender: self)
                    }
                }
            }
        })
        
        

        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if facebook.hasUserLogged() == true {
            self.performSegueWithIdentifier("forHome", sender: self)
        }
        
        //colocando a imagem no backgroud 
        //self.putImageBackground()
        
        
    }
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func putImageBackground() {
        let imageBackground = UIImage(named: "background_keys.jpg")
        imageBackground
        self.view.backgroundColor = UIColor(patternImage: imageBackground!)
    }

    
    func returnUserData() {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, email"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                
                if let userEmail = result["email"] {
                        print("User Email is: \(userEmail)")
                }
                
            }
        })
    }


}

