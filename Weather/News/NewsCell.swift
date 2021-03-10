//
//  NewsCell.swift
//  Weather
//
//  Created by Daniil Kniss on 19.12.2020.
//

import UIKit
import Kingfisher

class NewsCell: UITableViewCell {

    @IBOutlet weak var authorAvatar: UIImageView!
    
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var newsText: UILabel! {
        didSet {
            newsText.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var repostsCount: UILabel!
    
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
    
    func configurePost(with news: News) {
        let newsImageUrl = URL(string: news.newsImage)
        newsImage.kf.setImage(with: newsImageUrl)
        newsText.text = news.newsText
        likesCount.text = String(news.likesCount)
        commentsCount.text = String(news.commentsCount)
        repostsCount.text = String(news.repostsCount)
        
    }
    
    
    func configureHeader(with users: User) {
        
    }
    
    
    var isLiked = false
    
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
        guard var likeCounter = Int(likesCount.text ?? "0") else { return }
        
        animateLikeButton()
        
        if isLiked == false {
            likeCounter = likeCounter + 1
            likesCount.text = "\(likeCounter)"
            isLiked = true
        } else {
            likeCounter = likeCounter - 1
            likesCount.text = "\(likeCounter)"
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
