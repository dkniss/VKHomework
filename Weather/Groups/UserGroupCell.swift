//
//  UserGroupCell.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import UIKit
import Kingfisher

class UserGroupCell: UITableViewCell {
    
    @IBOutlet weak var groupAvatar: UIImageView!
    
    @IBOutlet weak var groupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with groups: Group) {
        groupName.text = String(groups.name)
        let url = URL(string: groups.photo)
        groupAvatar.kf.setImage(with: url)
    }

}
