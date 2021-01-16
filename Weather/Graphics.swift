//
//  Graphics.swift
//  Weather
//
//  Created by Daniil Kniss on 15.12.2020.
//

import UIKit

class AvatarImage: UIImageView {
    @IBInspectable var borderColor: UIColor = .gray
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
}

class AvatarShadow: UIView {
    @IBInspectable var shadowColor: UIColor = .lightGray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: -3)
    @IBInspectable var shadowOpacity: Float = 0.8
    @IBInspectable var shadowRadius: CGFloat = 3
    
    override func awakeFromNib() {
        self.backgroundColor = .clear
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        
    }
}
