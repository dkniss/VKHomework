//
//  FriendCollectionController.swift
//  Weather
//
//  Created by Daniil Kniss on 16.12.2020.
//

import UIKit
import RealmSwift
import Kingfisher



class FriendCollectionController: UICollectionViewController {
    
    var user: User?
    
    private lazy var photo = try? Realm().objects(Photo.self).filter("ownerId == %@", String(user?.id ?? 0)).sorted(byKeyPath: "id")
    
    private var notificationToken: NotificationToken?
    
    private var operationManager = OperationsManager()
    
    private var photoCache = [IndexPath: UIImage]()
    
    var photoId = 0
    
//
//    var friend = [User]()
//
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notificationToken = photo?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                self.collectionView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self.collectionView.update(deletions: deletions,
                                           insertions: insertions,
                                           modifications: modifications)
            case .error(let error):
                print(error)
                
            }
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.loadPhotos(token: Session.shared.token, ownerId: user?.id ?? 0  ) { [weak self] photos in
            try? RealmService.save(items: photos)
            self?.collectionView.reloadData()
        }
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo?.count ?? 0
     }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as? FriendCell,
            let currentPhoto = photo?[indexPath.row]
        else { return UICollectionViewCell() }
        
        if let filteredImage = photoCache[indexPath] {
            cell.photo.image = filteredImage
        } else {
            cell.photo.kf.setImage(with: URL(string: currentPhoto.url)) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(retriveImageResult):
                    self.startFiltration(for: retriveImageResult.image, at: indexPath)
                case .failure:
                    print("❌ error while downloading image: \(currentPhoto.url)")
                }
            }
        }
   
    
        return cell
        
    }
    
    private func startFiltration(for image: UIImage,
                                 at indexPath: IndexPath) {
        
        
        guard
            operationManager.operationInProgress[indexPath] == nil
        else {
            print("Operation in Progress")
            return
        }
        
        let sepiaOperation = SepiaFilterOperation(image)
        
        sepiaOperation.completionBlock = { [weak self] in
            guard
                let self = self,
                !sepiaOperation.isCancelled
            else { return }
            self.photoCache[indexPath] = sepiaOperation.image
            self.operationManager.operationInProgress[indexPath] = nil
            
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: [indexPath])
        }
        
        operationManager.operationInProgress[indexPath] = sepiaOperation
        operationManager.filteringQ.addOperation(sepiaOperation)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedPhoto = photo?[indexPath.row]
        
        photoId = indexPath.row
        
        self.performSegue(withIdentifier: "detailPhoto", sender: selectedPhoto)
    }
   

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailPhoto" {
            
            guard let detailVC = segue.destination as? DetailFriendPhotoController else { return }
            
            guard let selectedPhoto = sender as? Photo else { return }
            
            detailVC.userPhoto = Array(photo!)
            detailVC.selectedPhoto = selectedPhoto
            detailVC.photoId = photoId
            
            

        }
    }
    
    
}

