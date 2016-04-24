//
//  FormSenhasViewController.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 23/03/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit

protocol FormSenhasViewControllerDelegate{
    func addAccount(didAddAccount: Account)
}

class FormSenhasViewController: UIViewController {
   
    
    
    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var tfNome: UITextField!
    @IBOutlet weak var tfSenha: UITextField!
    
    var delegate:FormSenhasViewControllerDelegate?
    
    var account:Account?
    @IBAction func save(sender: AnyObject) {
        print("Chegou aqui")
        
        account = Account()
        account!.name = tfNome.text!
        account!.login = tfLogin.text!
        account!.password = tfSenha.text!
        
                    
        if (self.delegate != nil) {
           self.delegate?.addAccount(self.account!)
        }
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cadastro de Senha"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
