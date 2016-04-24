//
//  TableViewController.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 18/03/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, FormSenhasViewControllerDelegate{

    var count = 0
    var lstAccount:[Account] = []
    var account:Account?
    
    
    func addAccount(didAddAccount: Account){
        print("chegou aqui na table")
        //self.lstAccount.append(didAddAccount);
        
        self.account = Account(entity: Account.entityDescription(), insertIntoManagedObjectContext: nil)
        self.account?.name = didAddAccount.name
        self.account?.login = didAddAccount.login
        self.account?.password = didAddAccount.password
        self.account?.salvar()
        
        var retorno = DataManager.getAllManagedObjectsFromEntity(User.entityDescription())
        
        var user:User = User(entity: User.entityDescription(), insertIntoManagedObjectContext: nil)
        if(retorno.sucesso){
            user = (retorno.objects.objectAtIndex(0) as? User)!
        }
        self.account?.user = user
        self.account?.salvar()
        
        
        self.refresh()
        //print(didAddAccount)
    }
    
    func displayAlertWithModal(){
        let alert = UIAlertController(title: "Nova Senha", message: "Adicione os parametros", preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "Salvar", style: .Default) { (action: UIAlertAction) -> Void in
            
            let textFieldPlace = alert.textFields?.first
            print(textFieldPlace!.text!)
            
            let place = textFieldPlace!.text!
            if !place.isEmpty {
                let account = Account()
                account.name = place
                account.login = "Mark"
                account.password = "P1nt0"
                self.lstAccount.append(account);
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler({ (textField: UITextField) -> Void in
            textField.placeholder = "Nome do Local"
            textField.keyboardType = .Default
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        })
    }
    func displayAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    var refresher:  UIRefreshControl!
    
    func pushToReload(){
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        refresher.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refresher)
    }
    func refresh(){
        self.tableView.reloadData()
        self.refresher.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Total de lista \(lstAccount.count)")
        pushToReload() 
    }
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstAccount.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("senhaCell", forIndexPath: indexPath) as! SenhaCell
        
        cell.nomeSenha.text = lstAccount[indexPath.row].name
        cell.login.text = lstAccount[indexPath.row].login
        cell.resultadoSenha.text = lstAccount[indexPath.row].password

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Recupera a Cell que recebeu o tap
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        if cell.accessoryType == .Checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.None //desmarca o v na Cell do TabView
        } else {
            cell.accessoryType = .Checkmark; //marca o v na Cell do TabView
        }


    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            self.lstAccount.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepare")
        if segue.identifier == "goFormAccount" {
            let view = segue.destinationViewController as! FormSenhasViewController
            view.delegate = self;
        }
    }


}
