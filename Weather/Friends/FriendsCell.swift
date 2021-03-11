//
//  FriendsViewCell.swift
//  Weather
//
//  Created by Daniil Kniss on 09.12.2020.
//

import UIKit
import Kingfisher

class FriendsCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var username: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    func configure(with friend: User) {
        username.text = String(friend.firstName + " " + friend.lastName)
        let url = URL(string: friend.photo)
        avatar.kf.setImage(with: url)
        avatar.contentMode = .scaleAspectFill
    }
}
