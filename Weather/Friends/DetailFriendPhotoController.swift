//
//  DetailFriendPhotoController.swift
//  Weather
//
//  Created by Daniil Kniss on 28.12.2020.
//

import UIKit
import Kingfisher

class DetailFriendPhotoController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    

    
    var userPhoto = [Photo]()
    
    var selectedPhoto: Photo?
    
    var previousPhoto = UIImageView()
    
    var nextPhoto = UIImageView()
    
    var photoId = 0

    override func viewDidLoad() {

        super.viewDidLoad()
        
        let url = URL(string: selectedPhoto!.url)
        photo.kf.setImage(with: url)
        
//        photo.image = selectedPhoto
        photo.isUserInteractionEnabled = true
        
        
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        rightSwipeGesture.direction = .right
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        
    }
    
   
    
    @objc private func leftSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        
        if photoId < userPhoto.count - 1 {
            
            
            
            nextPhoto.frame = CGRect(x: 500, y: photo.frame.origin.y , width: photo.frame.width, height: photo.frame.height)
            nextPhoto.contentMode = .scaleAspectFit
            self.view.addSubview(nextPhoto)
            let url = URL(string: userPhoto[photoId + 1].url)
            nextPhoto.kf.setImage(with: url)
            
            print(photoId)
            
           
           
       
            UIImageView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: {

                UIImageView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                    self.photo.transform = .init(scaleX: 0.7, y: 0.7)
                    self.previousPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                    self.nextPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                }
                UIImageView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.50) {
                    self.photo.center.x -= 500
                    self.nextPhoto.center.x -= 500
                    self.previousPhoto.center.x -= 500
                }
                UIImageView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                    self.photo.transform = .init(scaleX: 1, y: 1)
                    self.previousPhoto.transform = .init(scaleX: 1, y: 1)
                    self.nextPhoto.transform = .init(scaleX: 1, y: 1)

                }
            }, completion: { _ in self.photo.image = self.nextPhoto.image })
            
            photoId += 1
            
      
            
            
            
        } else {
            
            
            
            UIImageView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
                UIImageView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    self.photo.transform = .init(scaleX: 0.7, y: 0.7)
                    self.previousPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                    self.nextPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                }
                
                UIImageView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1) {
                    self.photo.transform = .init(scaleX: 1, y: 1)
                    self.previousPhoto.transform = .init(scaleX: 1, y: 1)
                    self.nextPhoto.transform = .init(scaleX: 1, y: 1)
                
                }
                
        })
        }
        
    }
    
    @objc private func rightSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        
        
        
        if photoId > 0 {
            
            print(photoId)
            
            previousPhoto.frame = CGRect(x: -500, y: photo.frame.origin.y, width: photo.frame.width, height: photo.frame.height)
            previousPhoto.contentMode = .scaleAspectFit
            self.view.addSubview(previousPhoto)
            let url = URL(string: userPhoto[photoId - 1].url)
            previousPhoto.kf.setImage(with: url)
            
            UIImageView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: {
            
                UIImageView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                    self.photo.transform = .init(scaleX: 0.7, y: 0.7)
                    self.previousPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                    self.nextPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                }
                
                UIImageView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                    self.photo.center.x += 500
                    self.nextPhoto.center.x += 500
                    self.previousPhoto.center.x += 500
                
                }
                UIImageView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1) {
                    self.photo.transform = .init(scaleX: 1, y: 1)
                    self.previousPhoto.transform = .init(scaleX: 1, y: 1)
                    self.nextPhoto.transform = .init(scaleX: 1, y: 1)
                
                }
            }, completion: {_ in self.photo.image = self.previousPhoto.image  })
            
            photoId -= 1
            
            
            
        } else {
            
            UIImageView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
            
                UIImageView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    self.photo.transform = .init(scaleX: 0.7, y: 0.7)
                    self.previousPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                    self.nextPhoto.transform = .init(scaleX: 0.7, y: 0.7)
                }
                
                UIImageView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1) {
                    self.photo.transform = .init(scaleX: 1, y: 1)
                    self.previousPhoto.transform = .init(scaleX: 1, y: 1)
                    self.nextPhoto.transform = .init(scaleX: 1, y: 1)
                
                }
                
        })
        }
    
    }

    
//    func hideNavigationBar() {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        }
    
//    func hideTabBar() {
//        self.tabBarController?.tabBar.isHidden = true
//
//    }

    
    


}

