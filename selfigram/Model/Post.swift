//
//  Post.swift
//  selfigram
//
//  Created by Luke Sartori on 2018-03-07.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation
import UIKit
import Parse

//class Post { // Object
//
//    let imageURL: URL //Property 1
//    let user: User //Property 2
//    let comment: String //Property 3
//
//    init(imageURL:URL, user:User, comment:String){
//        // You can name the property you are passing into the function the
//        // same name as the class' property. To distinguish the two
//        // add "self." to the beginning of the class' property.
//        // So for example we are passing in an UImage called image and setting it as our
//        // image property for Post.
//        self.imageURL = imageURL
//        self.user = user
//        self.comment = comment
//    }
//}

class Post:PFObject, PFSubclassing {
    
    @NSManaged var image:PFFile
    @NSManaged var user:PFUser
    @NSManaged var comment:String
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    // convenience init method, because it’s building on top of PFObject’s init, rather than overriding it.
    convenience init(image:PFFile, user:PFUser, comment:String){
        // You can name the property you are passing into the function the
        // same name as the class' property. To distinguish the two
        // add "self." to the beginning of the class' property.
        self.init()
        self.image = image
        self.user = user
        self.comment = comment
    }
}
