//
//  selfieCell.swift
//  selfigram
//
//  Created by Luke Sartori on 2018-03-14.
//  Copyright © 2018 Luke. All rights reserved.
//

import UIKit

class selfieCell: UITableViewCell {

    @IBOutlet weak var selfieImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
