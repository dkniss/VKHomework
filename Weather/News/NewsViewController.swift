//
//  NewsViewController.swift
//  Weather
//
//  Created by Daniil Kniss on 19.12.2020.
//

import UIKit
import Kingfisher

class NewsViewController: UITableViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var news = [News]()
    var users = [User]()
    var groups = [Group]()
    var nextFrom: String = ""
    var isLoading = false
    var countRow = 0
    
    
    private let refresher = UIRefreshControl()

   
    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")

        getNewsFeed()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let currentOffset = scrollView.contentOffset.y
         let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
         let deltaOffset = maximumOffset - currentOffset
         
         if deltaOffset <= 0 {
             loadMore()
         }
     }
        
    func loadMore() {
        if !isLoading {
            self.isLoading = true
            self.activityIndicator.startAnimating()
            self.tableView.tableFooterView?.isHidden = false
            self.getNewsFeed()
            DispatchQueue.global().async {
                sleep(2)
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    self.isLoading = false
                    self.activityIndicator.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                }
            }
        }
    }
    
 
    func getNewsFeed() {
        NetworkService.loadNewsFeed(token: Session.shared.token, from: nextFrom) { [weak self] news, users, groups, nextFrom in
            self?.news += news
            self?.users = users
            self?.groups = groups
            self?.nextFrom = nextFrom
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
            cell.authorName.text = user.first!.firstName + " " + user.first!.lastName
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
