//
//  LeaguesTableView.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Alamofire


class LeaguesTableView: UITableViewController {

    var sport:String?
    var leage_name : [String] = []
    var leage_key : [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let sport_type = sport else{return}
        
        print(sport_type )
       changeSportTypeName()

//        switch(sport){
//        case "Football" :
//            sport = "football"
//        case "Tennis" :
//            sport = "tennis"
//        case "Basketball":
//            sport = "basketball"
//        case "Cricket":
//            sport = "cricket"
//        default:
//           print("no type")
//        }
        
        ApiService.fetchLeagues(sport_type: sport ?? "football") { data in
            for i in 0..<(data?.result.count ?? 0){
                self.leage_name.append(data?.result[i].league_name ?? "")
                self.leage_key.append(data?.result[i].league_key ?? 0)

            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        

        
    }

    func changeSportTypeName(){
        switch(sport){
        case "Football" :
            sport = "football"
        case "Tennis" :
            sport = "tennis"
        case "Basketball":
            sport = "basketball"
        case "Cricket":
            sport = "cricket"
        default:
           print("no type")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leage_name.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableCell

        
        cell.leage_label.text = leage_name[indexPath.row]
        
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagues_desc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesDescription") as!LeaguesDescription
        
      
        leagues_desc.sportType = sport
        leagues_desc.legKey = leage_key[indexPath.row]
        
        leagues_desc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(leagues_desc, animated: true)
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
