//
//  UINavigationItem+Helpers.swift
//  selfigram
//
//  Created by Luke Sartori on 2018-03-26.
//  Copyright © 2018 Luke. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationItem {
    func addNavbarLogo() {
        let logo = UIImage(named: "Selfigram-logo")
        self.titleView = UIImageView(image: logo)
    }
}
