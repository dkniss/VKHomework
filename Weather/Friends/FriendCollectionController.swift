//
//  FriendCollectionController.swift
//  Weather
//
//  Created by Daniil Kniss on 16.12.2020.
//

import UIKit



class FriendCollectionController: UICollectionViewController {
    
    var user: User?
    
    var photo = [Photo]()
    
    var photoId = 0
    
    var friend = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.loadPhotos(token: Session.shared.token, ownerId: user!.id) { [weak self] photos in
            self?.photo = photos
            self?.collectionView.reloadData()
            NetworkService.savePhotosData(photos)
        }
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
     }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
        cell.configure(with: photo[indexPath.row])
        
        
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPhoto = photo[indexPath.row]
        
        photoId = indexPath.row
        
        self.performSegue(withIdentifier: "detailPhoto", sender: selectedPhoto)
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPhoto" {
            
            guard let detailVC = segue.destination as? DetailFriendPhotoController else { return }
            
            guard let selectedPhoto = sender as? Photo else { return }
            
            detailVC.userPhoto = photo
            detailVC.selectedPhoto = selectedPhoto
            detailVC.photoId = photoId
            
            

        }
    }
    
    
}
