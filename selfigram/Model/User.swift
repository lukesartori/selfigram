//
//  User.swift
//  selfigram
//
//  Created by Luke Sartori on 2018-03-07.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation
import UIKit

class User{
    let username: String
    let profileImage: UIImage
    
    init(aUsername: String, aProfileImage: UIImage) {
        username = aUsername
        profileImage = aProfileImage
    }
}
