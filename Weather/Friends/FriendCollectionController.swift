//
//  FriendCollectionController.swift
//  Weather
//
//  Created by Daniil Kniss on 16.12.2020.
//

import UIKit



class FriendCollectionController: UICollectionViewController {
    
    var user: User?
    
    var photoId = 0
    
    var friend = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.loadPhotos(token: Session.shared.token)
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (user?.photoAlbum.count)!
     }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCell
        
    
        cell.photo.image = user?.photoAlbum[indexPath.row]
        cell.photo.contentMode = .scaleAspectFill
 
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let selectedPhoto = user?.photoAlbum[indexPath.row] else { return }
        
        photoId = indexPath.row
        
        self.performSegue(withIdentifier: "detailPhoto", sender: selectedPhoto)
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPhoto" {
            
            guard let detailVC = segue.destination as? DetailFriendPhotoController else { return }
            
            guard let selectedPhoto = sender as? UIImage else { return }
            
            
            detailVC.user = self.user
            detailVC.selectedPhoto = selectedPhoto
            detailVC.photoId = photoId
            
            

        }
    }
    
    
}
