//
//  NewsViewController.swift
//  Weather
//
//  Created by Daniil Kniss on 19.12.2020.
//

import UIKit

class NewsViewController: UITableViewController {
    
    var news = [News(userAvatar: UIImage(named: "userPhoto"), username: "Иван Иванов", userText: "Водопад представляет собой водный поток, падающий с крутого обрыва. Часто крупные водопады состоят из цепочки мелких порогов и каскадов.", newsImage: UIImage(named: "waterfall")),
                News(userAvatar: UIImage(named: "userPhoto"), username: "Игнат Румянцев", userText: "Город — крупный населённый пункт, жители которого заняты, как правило, не сельским хозяйством. Имеет развитый комплекс хозяйства и экономики.", newsImage: UIImage(named: "city")),
                News(userAvatar: UIImage(named: "userPhoto"), username: "Валерий Плеханов", userText: "Французский бульдог — порода собак. Некрупная, отличающаяся крупной, но короткой мордой, плоским раздвоенным носом, широкой раздвоенной верхней губой.", newsImage: UIImage(named: "frenchie")),
                

    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell
        
        let currentNews = news[indexPath.row]
        
        cell?.userAvatar.image = currentNews.userAvatar
        cell?.username.text = currentNews.username
        cell?.userText.text = currentNews.userText
        cell?.imageNews.image = currentNews.newsImage
        cell?.userAvatar.contentMode = .scaleAspectFill
        cell?.imageNews.contentMode = .scaleToFill
        
        return cell!
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
