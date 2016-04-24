//
//  HomeViewController.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 27/02/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController: UIViewController {

    
    /**
     
        OUTLET VIEW
     */
    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var genderUser: UILabel!
    
    /**
        OBJECTS
     */
    var user:User = User()
    var unique = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Instanciando o Bussines com datasource
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    
        
//        if unique == false {
//            
//            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//            let permissions = ["public_profile", "email", "user_friends"]
//            fbLoginManager.logInWithReadPermissions(permissions, handler: { (result, error) -> Void in
//                
//                if (error == nil){
//                    
//                    let fbloginresult : FBSDKLoginManagerLoginResult = result
//                    
//                    if(fbloginresult.grantedPermissions.contains("email")){
//                    
//                    if((FBSDKAccessToken.currentAccessToken()) != nil){
//                        self.unique = true;
//
//                        self.returnUserData()
//                    }
//                }
//                }
//            })
//        }
        
    }
    
    
    func returnUserData() {
        
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if (error == nil){
                    print(result)
                    
                    self.user.name = (result["name"] as? String)!
                    self.user.email = (result.valueForKey("email") as? String)!
                    self.user.gender = (result["gender"] as? String)!
                    
                    //recupera o ID do facebook do usuario
                    let userId = result["id"] as! String
                    let facebookProfilePicture = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    //processo para pegar a foto
                    if let fbPicture = NSURL(string: facebookProfilePicture) {
                        if let data = NSData(contentsOfURL: fbPicture) {
                            self.user.photo = UIImage(data: data)!
                        }
                    }
                    
                    self.popularView()
                    
                    self.salvarUserNoBanco()
                    self.unique = true;
                }
            })
        }
    }
    func salvarUserNoBanco(){
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context)
        newUser.setValue(self.user.name, forKey: "name")
        newUser.setValue(self.user.email, forKey: "email")
        newUser.setValue(self.user.gender, forKey: "gender")
        newUser.setValue(self.user.id, forKey: "id")
        newUser.setValue(self.user.idFacebook, forKey: "idFacebook")
        newUser.setValue(self.user.photo, forKey: "photo")
        newUser.setValue(self.user.password, forKey: "password")
        
        do{
            try context.save()
        }catch {
                    
        }
    }
    
    func popularView(){
        self.photoUser.image = self.user.photo
        self.nameUser.text = self.user.name
        self.genderUser.text = self.user.gender
        self.emailUser.text = self.user.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      //  print("chegou aqui")
    //}
    

}
