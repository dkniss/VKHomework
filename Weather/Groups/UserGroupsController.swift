//
//  UserGroupsController.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import UIKit
import RealmSwift

class UserGroupsController: UITableViewController {
    
//    var groups = [Group]()
    
    
    
    private let isMember = 1
    
    private lazy var groups = try? Realm().objects(Group.self).filter("isMember = %@", String(isMember)).sorted(byKeyPath: "id") {
        didSet {
            tableView.reloadData()
        }
    }
    
//    var searchResults = try? Realm().objects(Group.self)

    private lazy var filteredGroups = groups
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }

    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkService.loadUserGroups(token: Session.shared.token,
                                  userId: Session.shared.userId) { [weak self] groups in
            try? RealmService.save(items: groups)
            self?.tableView.reloadData()
        }
        

        
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
        
        return filteredGroups?.count ?? 0
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as? UserGroupCell,
            let group = filteredGroups?[indexPath.row]
            
        else { return UITableViewCell() }
        
       
            cell.configure(with: group)
        
        return cell
    }

    @IBAction func addGroup(segue: UIStoryboardSegue) {

            if segue.identifier == "addGroup" {

                guard let allGroupsController = segue.source as? AllGroupsController else { return }

                if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {

                    let group = allGroupsController.groups?[indexPath.row]
                    
                    NetworkService.joinGroup(token: Session.shared.token, groupId: group?.id ?? 0)
                    
                    let realm = try? Realm()
                    
                    if let group = groups?[indexPath.row] {
                        try? realm?.write {
                            realm?.add(group)
                        }
                    }
                    
                        tableView.reloadData()
                    }
                }
            }
        

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            if editingStyle == .delete {
                
                
                NetworkService.leaveGroup(token: Session.shared.token, groupId: groups?[indexPath.row].id ?? 0)
                
                let realm = try? Realm()
                
                if let group = groups?[indexPath.row] {
                    try? realm?.write {
                        realm?.delete(group)
                    }
                }

                tableView.deleteRows(at: [indexPath], with: .fade)
                
                tableView.reloadData()
            }
        }

}

extension UserGroupsController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        let predicate = NSPredicate(format: "name contains[cd] %@", searchText)
        
        if searchText.isEmpty {
            filteredGroups = groups
            tableView.reloadData()
            return
        }
        
        filteredGroups = groups?.filter(predicate)
        
        tableView.reloadData()
    }
    
    
}
    
    

