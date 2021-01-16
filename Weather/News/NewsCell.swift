//
//  NewsCell.swift
//  Weather
//
//  Created by Daniil Kniss on 19.12.2020.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var userText: UILabel! {
        didSet {
            userText.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var imageNews: UIImageView!
    
    @IBOutlet weak var newsLikeButton: UIButton!
    
    @IBOutlet weak var newsLikeCounterLabel: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var likeCounter = 0
    var isLiked = false
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
        animateLikeButton()
        
        if isLiked == false {
            likeCounter = likeCounter + 1
            newsLikeCounterLabel.text = "\(likeCounter)"
            isLiked = true
        } else {
            likeCounter = likeCounter - 1
            newsLikeCounterLabel.text = "\(likeCounter)"
            isLiked = false
        }
            
    }

    
    func animateLikeButton() {
        UIView.transition(with: newsLikeButton,
                          duration: 0.5,
                          options: .transitionCrossDissolve) {
            switch self.isLiked {
            case true:
                self.newsLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            case false:
                self.newsLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
}
