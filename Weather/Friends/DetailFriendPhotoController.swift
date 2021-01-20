//
//  DetailFriendPhotoController.swift
//  Weather
//
//  Created by Daniil Kniss on 28.12.2020.
//

import UIKit

class DetailFriendPhotoController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!
    
    var photoAlbum = [UIImage]()
    
    var selectedPhoto: UIImage?
    
    var user: User?
    
    var previousPhoto = UIImageView()
    
    var nextPhoto = UIImageView()
    
    var photoId = 0

    override func viewDidLoad() {

        super.viewDidLoad()
        
       
        
       
        
        
        photo.image = user?.photoAlbum[photoId]
        photo.isUserInteractionEnabled = true
        
        
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        rightSwipeGesture.direction = .right
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        
    }
    
    @objc private func leftSwipe(_ gesture: UISwipeGestureRecognizer) {
        
        
        if photoId < (user?.photoAlbum.count)! - 1 {
            
            
            
            nextPhoto.frame = CGRect(x: 500, y: photo.frame.origin.y , width: photo.frame.width, height: photo.frame.height)
            nextPhoto.contentMode = .scaleAspectFit
            self.view.addSubview(nextPhoto)
            nextPhoto.image = user?.photoAlbum[photoId + 1]
            
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
            previousPhoto.image = user?.photoAlbum[photoId - 1]
            
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

