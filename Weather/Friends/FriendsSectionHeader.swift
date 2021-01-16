//
//  FriendsSectionHeader.swift
//  Weather
//
//  Created by Daniil Kniss on 19.12.2020.
//

import UIKit

class FriendsSectionHeader: UITableViewHeaderFooterView {
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
        detailTextLabel?.text = ""
    }
}
