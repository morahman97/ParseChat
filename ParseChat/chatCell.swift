//
//  chatCell.swift
//  ParseChat
//
//  Created by Mo on 2/22/18.
//  Copyright © 2018 Mo. All rights reserved.
//

import UIKit

class chatCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var chatTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
