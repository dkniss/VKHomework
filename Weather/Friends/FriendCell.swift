//
//  FriendCell.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import UIKit

class FriendCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photo: UIImageView! 
        
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton! 
    
    @IBOutlet weak var likeCounterLabel: UILabel!
    
    var likeCounter = 0
    var isLiked = false
    
    
   
    @IBAction func likeButtonPressed(_ sender: Any) {
        animateLikeButton()
        if isLiked == false {
            likeCounter = likeCounter + 1
            likeCounterLabel.text = "\(likeCounter)"
            isLiked = true
        } else {
            likeCounter = likeCounter - 1
            likeCounterLabel.text = "\(likeCounter)"
            isLiked = false
        }
            
    }
    
    func animateLikeButton() {
        UIView.transition(with: likeButton,
                          duration: 0.5,
                          options: .transitionCrossDissolve) {
            switch self.isLiked {
            case true:
                self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            case false:
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
}


