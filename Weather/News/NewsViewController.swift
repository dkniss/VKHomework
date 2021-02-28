//
//  NewsViewController.swift
//  Weather
//
//  Created by Daniil Kniss on 19.12.2020.
//

import UIKit
import Kingfisher

class NewsViewController: UITableViewController {
    
    var news = [News]()
    var users = [User]()
    var groups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        NetworkService.loadNewsFeed(token: Session.shared.token) { [weak self] news, users, groups in
            self?.news = news
            self?.users = users
            self?.groups = groups
            self?.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        let currentNews = news[indexPath.row]
        
        
        if currentNews.sourceId > 0 {
            let user = users.filter{ $0.id == currentNews.sourceId }
            cell.authorName.text = user.first?.firstName
            let url = URL(string: user.first?.photo ?? "")
            cell.authorAvatar.kf.setImage(with: url)
        } else {
            let group = groups.filter{ $0.id == -currentNews.sourceId }
            cell.authorName.text = group.first?.name
            let url = URL(string: group.first?.photo ?? "")
            cell.authorAvatar.kf.setImage(with: url)
        }
        
        cell.configurePost(with: currentNews)
        
        
        
        
        return cell
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
