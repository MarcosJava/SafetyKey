//
//  User.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 27/02/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: NSNumber?
    var idFacebook: String?
    var name : String?
    var gender : String?
    var email : String?
    var password : String?
    var photo : UIImage?
    
    
    override var description:String {
        return "id: \(id) idFacebook: \(idFacebook) name: \(name) gender:\(gender) email:\(email) password:\(password) photo:\(photo)"
    }
  
    

}
