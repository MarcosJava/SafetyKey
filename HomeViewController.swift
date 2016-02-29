//
//  HomeViewController.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 27/02/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit

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
   // var user:User = User()
   // var facebookUtil:FacebookUtil = FacebookUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getInformationUser()
//        putDataView()
    
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
//        if FBSDKAccessToken.currentAccessToken().userID == nil{
//
//        } else {
//            print(FBSDKAccessToken.currentAccessToken().userID)
//        }
        
        if((FBSDKAccessToken.currentAccessToken()) == nil){ //PEDE PERMISSAO NOVAMENTE, PQ NAO ESTAMOS SALVANDO O USER AINDA
            
            let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
            let permissions = ["public_profile", "email"]
            
            
            
            fbLoginManager.logInWithReadPermissions(permissions, handler: { (result, error) -> Void in
            
                if (error == nil){
                
                //let fbloginresult : FBSDKLoginManagerLoginResult = result
                //if(fbloginresult.grantedPermissions.contains("id")){

                        if((FBSDKAccessToken.currentAccessToken()) != nil){
                        
                            self.getData()
                        }
                }
                //}
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
//    func getInformationUser(){
//        user = facebookUtil.getUser()
//    }
//    
//    func putDataView(){
//        nameUser.text = user.name as? String
//        emailUser.text = user.email as? String
//        genderUser.text = user.gender as? String
//        photoUser.image = user.photo
//    }
    
    func getData(){
       
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if (error == nil){
                    print(result)
                    
                    self.nameUser.text = (result["name"] as! String)
                    
                    if let email = result["email"] {
                        //self.emailUser.text = email as! String
                    } else {
                        self.emailUser.text = "Não tem email"
                    }
                    
                    self.genderUser.text = (result["gender"] as! String)
                    
                    //recupera o ID do facebook do usuario
                    let userId = result["id"] as! String
                    let facebookProfilePicture = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    //processo para pegar a foto
                    if let fbPicture = NSURL(string: facebookProfilePicture) {
                        if let data = NSData(contentsOfURL: fbPicture) {
                            self.photoUser.image = UIImage(data: data)!
                        }
                    }
                    
                    
                }
            })
        

    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("chegou aqui")
    }
    

}
