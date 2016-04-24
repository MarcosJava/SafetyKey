//
//  ViewController.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 27/02/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit
import CoreData

var isLogged = false;

class ViewController: UIViewController {
    
    /**
            OUTLETS VIEW
     */
    @IBOutlet weak var emailTx: UITextField!
    @IBOutlet weak var passwordTx: UITextField!
    
    
    /**
         
     UIVIEW
     
     */
    
    override func viewDidAppear(animated: Bool) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        if isLogged == true {
            self.performSegueWithIdentifier("forHome", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Opcoes adicionais
        self.passwordTx.hidden = true
        
        
        
//        if (FBSDKAccessToken.currentAccessToken() != nil) {
//            print("Tem a permissao")
//            isLogged = true
//        }
//        if facebook.hasUserLogged() == true {
//            self.performSegueWithIdentifier("forHome", sender: self)
//        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     
        TouchesBegan e textField , para sumir o teclado quando der tap na view
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        emailTx.resignFirstResponder()
        passwordTx.resignFirstResponder()
        return true
    }
    
    
    /**
            ACTIONS VIEW
    */
    @IBAction func changeEmail(sender: AnyObject) {
        print("Digitando !")
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if emailTest.evaluateWithObject(self.emailTx.text) == true {
            self.passwordTx.hidden = false
        }
        
        
    }
    
    @IBAction func register(sender: AnyObject) {
        displayAlert("Atenção", message: "Em manutenção")
    }
    
    @IBAction func signInSimple(sender: AnyObject) {
        
        if (emailTx.text == "" || emailTx.text?.isEmpty == true) {
            displayAlert("Atenção", message: "Email é obrigatorio")
        
        } else if (passwordTx.text == "") || (passwordTx.text?.isEmpty == true) {
            displayAlert("Atenção", message: "Senha é obrigatorio")
        
        } else {
            displayAlert("Atenção", message: "Log In apenas com facebook")
        }
    }
    

    
    @IBAction func signInFacebook(sender: AnyObject) {
        isLogged = true
        self.performSegueWithIdentifier("forHome", sender: self)
    }
    
    
    
    func putImageBackground() {
        let imageBackground = UIImage(named: "background_keys.jpg")
        imageBackground
        self.view.backgroundColor = UIColor(patternImage: imageBackground!)
    }
    
    func displayAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

    
}

