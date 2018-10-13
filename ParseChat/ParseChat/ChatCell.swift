//
//  ChatCell.swift
//  ParseChat
//
//  Created by Julie Bao on 10/8/18.
//  Copyright © 2018 Julie Bao. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var message: UILabel!
    
    public var usr: String = ""
    {
        // if a chat message has the user property set, set the username label to the user's username
        didSet{
             // User found! update username label with username
            username.text = usr
            if usr == "EMPTY"
            {// No user found, set default username
                username.text = "🤖"
            }
        }
    }
    public var msg: String = ""
    {
        didSet{
            message.text = msg
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
