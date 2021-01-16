//
//  FriendsViewController.swift
//  Weather
//
//  Created by Daniil Kniss on 09.12.2020.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    var friends = [
        User(firstName: "Иван", lastName: "Иванов", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3")]),
        User(firstName: "Наталья", lastName: "Порохина", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo4"), UIImage(named: "photo5")]),
        User(firstName: "Михаил", lastName: "Астафьев", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo6"), UIImage(named: "photo7"), UIImage(named: "photo8")]),
        User(firstName: "София", lastName: "Романова", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo1"), UIImage(named: "photo4"), UIImage(named: "photo6"), UIImage(named: "photo8")]),
        User(firstName: "Борис", lastName: "Парфенов", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo5"), UIImage(named: "photo2"), UIImage(named: "photo1"), UIImage(named: "photo3"), UIImage(named: "photo6"), UIImage(named: "photo8"), UIImage(named: "photo7"), UIImage(named: "photo4")]),
        User(firstName: "Наталья", lastName: "Потапова", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo3"), UIImage(named: "photo7"), UIImage(named: "photo2")]),
        User(firstName: "Василий", lastName: "Калинкин", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo4"), UIImage(named: "photo5")]),
        User(firstName: "Анастасия", lastName: "Попова", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo1"), UIImage(named: "photo4"), UIImage(named: "photo6"), UIImage(named: "photo8")]),
        User(firstName: "Вячеслав", lastName: "Муравьев", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo6"), UIImage(named: "photo7"), UIImage(named: "photo8")]),
        User(firstName: "Геннадий", lastName: "Захаров", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo5"), UIImage(named: "photo2"), UIImage(named: "photo1"), UIImage(named: "photo3"), UIImage(named: "photo6"), UIImage(named: "photo8"), UIImage(named: "photo7"), UIImage(named: "photo4")]),
        User(firstName: "Маргарита", lastName: "Румянцева", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo4"), UIImage(named: "photo5")]),
        User(firstName: "Филлип", lastName: "Борисов", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo3"), UIImage(named: "photo7"), UIImage(named: "photo2")]),
        User(firstName: "Юрий", lastName: "Котов", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo1"), UIImage(named: "photo4"), UIImage(named: "photo6"), UIImage(named: "photo8")]),
        User(firstName: "Евгений", lastName: "Романов", avatar: UIImage(named: "userPhoto"), photoAlbum: [UIImage(named: "photo5"), UIImage(named: "photo7"), UIImage(named: "photo4"), UIImage(named: "photo3"), UIImage(named: "photo8"), UIImage(named: "photo2"), UIImage(named: "photo1")]),
    ]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredFriends = [User]() {
        didSet {
            (firstLetters, sortedFriends) = sort(filteredFriends)
        }
    }
        
    
    var firstLetters = [Character]()
    var sortedFriends = [Character: [User]]()
    
    let sectionTitles = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ".map(String.init)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.loadFriends(token: Session.shared.token)
        
        
        filteredFriends = friends
        
        
        tableView.register(FriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "FriendsSectionHeader")
        
        (firstLetters, sortedFriends) = sort(filteredFriends)
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
       return firstLetters.count
        
    }
           


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let charFriends = firstLetters[section]
        return sortedFriends[charFriends]?.count ?? 0
    }
        
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
       
        UIImageView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.25, options: []) {
            let cell = tableView.cellForRow(at: indexPath) as? FriendsCell
            
            cell?.avatar.transform = .init(scaleX: 0.7, y: 0.7)
            cell?.avatar.transform = .init(scaleX: 1, y: 1)
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        let firstLetter = firstLetters[indexPath.section]
        if let friends = sortedFriends[firstLetter] {
            cell.username.text = friends[indexPath.row].firstName + " " + friends[indexPath.row].lastName
            cell.avatar.image = friends[indexPath.row].avatar
            cell.avatar.contentMode = .scaleAspectFill
  
        }
    
            return cell
        
        }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendsSectionHeader") as? FriendsSectionHeader
           else { return nil }
        sectionHeader.contentView.backgroundColor = .lightGray
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(firstLetters[section])
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles
    }
        
    override func tableView(_ tableView: UITableView,
                   sectionForSectionIndexTitle title: String,
                   at index: Int) -> Int {
        index
    }
    
    private func sort(_ friends: [User]) -> (characters: [Character], sortedFriends: [Character: [User]]) {
        var characters = [Character]()
        var sortedFriends = [Character: [User]]()
        
        filteredFriends.forEach { friend in
            guard let character = friend.firstName.first else { return }
            if var thisCharFriends = sortedFriends[character] {
                thisCharFriends.append(friend)
                sortedFriends[character] = thisCharFriends
            } else {
                sortedFriends[character] = [friend]
                characters.append(character)
            }
        }
        
        characters.sort()
        
        return (characters, sortedFriends)
    }
    
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "forecast",
            let controller = segue.destination as? FriendCollectionController,
            let index = tableView.indexPathForSelectedRow
        else { return }

        let firstLetter = firstLetters[index.section]
        
        if let friends = sortedFriends[firstLetter] {
            
            controller.user = friends[index.row]
        }

    }

    
    
    
}

extension FriendsViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar:  UISearchBar, textDidChange searchText: String) {
        filteredFriends(with: searchText)
       
    }
    
    fileprivate func filteredFriends(with text: String) {
        
        
        if text.isEmpty {
            filteredFriends = friends
            tableView.reloadData()
            return
        }
  
        filteredFriends = friends.filter { $0.firstName.lowercased().contains(text.lowercased())}
        
        tableView.reloadData()
    }
}
