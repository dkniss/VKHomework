//
//  AllGroupsCell.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import UIKit
import Kingfisher

class AllGroupsCell: UITableViewCell {
    @IBOutlet weak var allGroupsAvatar: UIImageView!
    
    @IBOutlet weak var allGroupsName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with groups: Group) {
        allGroupsName.text = String(groups.name)
        let url = URL(string: groups.photo)
        allGroupsAvatar.kf.setImage(with: url)
    
    }
}
