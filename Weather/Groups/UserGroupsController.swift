//
//  UserGroupsController.swift
//  Weather
//
//  Created by Daniil Kniss on 10.12.2020.
//

import UIKit

class UserGroupsController: UITableViewController {
    
    var groups = [
        Group(name: "GeekBrains", theme: "Учеба", avatar: UIImage(named: "geekbrains"))
    ]

    private var filteredGroups = [Group]()
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.loadGroups(token: Session.shared.token)
        
        NetworkService.loadSearchedGroups(token: Session.shared.token)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по группам"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredGroups.count
        }
        
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
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupCell", for: indexPath) as! UserGroupCell
        
        let group: Group
        
        if isFiltering {
            group = filteredGroups[indexPath.row]
        } else {
            group = groups[indexPath.row]
        }
         
        cell.groupName.text = group.name
        cell.groupAvatar.image = group.avatar
         
         return cell
     }

    @IBAction func addGroup(segue: UIStoryboardSegue) {
            
            if segue.identifier == "addGroup" {
            
                guard let allGroupsController = segue.source as? AllGroupsController else { return }
            
                if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
          
                    let group = allGroupsController.groups[indexPath.row]
         
                    if !groups.contains(group) {
         
                        groups.append(group)
    
                        tableView.reloadData()
                    }
                }
            }
        }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
            
                groups.remove(at: indexPath.row)
        
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }


}

extension UserGroupsController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredGroups = groups.filter({ (group: Group) -> Bool in
            return group.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    
}
