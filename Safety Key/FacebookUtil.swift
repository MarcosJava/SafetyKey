//
//  FacebookUtil.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 27/02/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit

class FacebookUtil: NSObject {
    
    
   
    var user:User = User()
    
    func hasUserLogged() -> Bool{
        
        // Usuário já está logado, funcionam como ir para o próximo view controller.
        if (FBSDKAccessToken.currentAccessToken() != nil){
            return true;
        } else {
            return false;
        }
        
    }
    
    func getUser() -> User {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        let permissions = ["public_profile", "email", "user_friends"]
        fbLoginManager.logInWithReadPermissions(permissions, handler: { (result, error) -> Void in
            
            if (error == nil){
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    if((FBSDKAccessToken.currentAccessToken()) != nil){
                        
                        self.returnUserData()
                    }
                }
            }
        })
        
        
        return self.user
    }
    
    
    func returnUserData() {
        
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                    
                if (error == nil){
                    print(result)
                    
                    self.user.name = result.valueForKey("name") as! NSString
                    //self.user.email = result.valueForKey("email") as! NSString
                    self.user.gender = result["gender"] as! NSString
                    
                    //recupera o ID do facebook do usuario
                    let userId = result["id"] as! String
                    let facebookProfilePicture = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    //processo para pegar a foto
                    if let fbPicture = NSURL(string: facebookProfilePicture) {
                        if let data = NSData(contentsOfURL: fbPicture) {
                            self.user.photo = UIImage(data: data)!
                        }
                    }
                    
                    
                }
            })
            
        }

    }
    

}
