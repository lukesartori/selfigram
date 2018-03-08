//
//  Post.swift
//  selfigram
//
//  Created by Luke Sartori on 2018-03-07.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation
import UIKit

class Post { // Object
    
    let image: UIImage //Property 1
    let user: User //Property 2
    let comment: String //Property 3
    
    init(image: UIImage, user: User, comment: String) { //Initialize properties
        self.image = image // pass properties for post
        self.user = user
        self.comment = comment
    }
}
