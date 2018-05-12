//
//  CustomMessageCell.swift
//  Studify
//
//  Created by Rosalie Wessels on 13/04/2018.
//

import UIKit

class CustomMessageCell: UITableViewCell {


    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    
    //title
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var dueDateBody: UILabel!
    
    //teacher
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
        
        
        
    }


}
