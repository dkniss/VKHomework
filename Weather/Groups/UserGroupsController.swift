//
//  UserGroupsController.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class UserGroupsController: UITableViewController {
    
    private let isMember = 1
    
//    fileprivate var notificationToken: NotificationToken?
//
//    private lazy var groups = try? Realm().objects(Group.self).filter("isMember = %@", String(isMember)).sorted(byKeyPath: "id")
//
//    private lazy var filteredGroups = groups
//
    
    private var groups = [FirebaseGroup]()
    private let ref = Database.database(url: "https://vkapp-746cc-default-rtdb.europe-west1.firebasedatabase.app/") .reference(withPath: "Users/User with ID: \(Session.shared.userId)/Added Groups")
    
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value, with: { snapshot in
            var groups: [FirebaseGroup] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let group = FirebaseGroup(snapshot: snapshot) {
                    groups.append(group)
                }
            }
            self.groups = groups
            self.tableView.reloadData()
        })
        
//        notificationToken = filteredGroups?.observe { [weak self] change in
//            guard let self = self else { return }
//            switch change {
//            case .initial:
//                print("CASE INITIAL")
//                self.tableView.reloadData()
//            case let .update(_, deletions, insertions, modifications):
//                self.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
//                print(deletions)
//                print(insertions)
//                print(modifications)
//            case .error(let error):
//                print(error)
//            }
//        }
        
    }
    
//    deinit {
//        notificationToken?.invalidate()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
//        NetworkService.loadUserGroups(token: Session.shared.token,
//                                  userId: Session.shared.userId) { [weak self] groups in
//            try? RealmService.save(items: groups)
//            self?.tableView.reloadData()
//        }
        
     
        
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по группам"
        navigationItem.searchController = searchController
        definesPresentationContext = true

     
       
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        UIImageView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.25, options: []) {
            let cell = tableView.cellForRow(at: indexPath) as? UserGroupCell
            
            cell?.groupAvatar.transform = .init(scaleX: 0.7, y: 0.7)
            cell?.groupAvatar.transform = .init(scaleX: 1, y: 1)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as? UserGroupCell
        else { return UITableViewCell() }
        
        let group = groups[indexPath.row]
        
        cell.groupName.text = group.groupName
        
        
        return cell
        
        
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as? UserGroupCell,
//            let group = filteredGroups[indexPath.row]
//
//        else { return UITableViewCell() }
//
//
//            cell.configure(with: group)
//
//        return cell
    }

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            
            guard let allGroupsController = segue.source as? AllGroupsController else { return }
            
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                
                guard
                    let newGroupName = allGroupsController.groups?[indexPath.row].name,
                    let newGroupId = allGroupsController.groups?[indexPath.row].id
                      else { return }
                
                let group = FirebaseGroup(groupName: newGroupName, groupId: newGroupId)
                
                let groupRef = self.ref.child(newGroupName)
                
                groupRef.setValue(group.toAnyObject())
                
            
                
//                guard let group = allGroupsController.groups?[indexPath.row] else { return }
//
//                NetworkService.joinGroup(token: Session.shared.token, groupId: group.id)
//
//
//                do {
//                    let realm = try Realm()
//                    try realm.write{
//                        group.isMember = "1"
//                        realm.add(group, update: .modified)
//                    }
//                } catch {
//                    print(error)
//                }
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            if editingStyle == .delete {
                
                let group = groups[indexPath.row]
                group.ref?.removeValue()
//
//                guard let group = filteredGroups?[indexPath.row] else { return }
//
//                NetworkService.leaveGroup(token: Session.shared.token, groupId: group.id)
//
//                do {
//                    let realm = try Realm()
//                    realm.beginWrite()
//                    group.isMember = "0"
//                    realm.add(group, update: .modified)
//                    try realm.commitWrite()
//                } catch {
//                    print(error)
//                }
//
            }
        
        }

}

extension UserGroupsController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
//        let predicate = NSPredicate(format: "name contains[cd] %@", searchText)
        
//        if searchText.isEmpty {
//            filteredGroups = groups
//            tableView.reloadData()
//            return
//        }
//
        
//        filteredGroups = groups?.filter(predicate)
        
        tableView.reloadData()
    }
    
    
}
    
    

