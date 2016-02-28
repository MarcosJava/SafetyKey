//
//  User.swift
//  Safety Key
//
//  Created by Marcos Felipe Souza on 27/02/16.
//  Copyright © 2016 LeoMarcos. All rights reserved.
//

import CoreData
import UIKit

class User: NSObject {
    
    var name : NSString?
    var gender : NSString?
    var email : NSString?
    var password : NSString?
    var photo : UIImage?
    
    override var description:String {
        return "name: \(name) gender:\(gender) email:\(email) password:\(password) photo:\(photo)"
    }
  
    

}
