//
//  LeaguesTableView.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Alamofire


class LeaguesTableView: UITableViewController ,UISearchResultsUpdating{
   

    var sport:String?
    var leage_name : [String] = []
    var leage_key : [Int] = []
    var leage_image : [String] = []
    
    var filteredNames : [String] = []
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSearcBar()
        guard let sport_type = sport else{return}
        
        print(sport_type )
       changeSportTypeName()
        
        ApiService.fetchLeagues(sport_type: sport ?? "football") { data in
            for i in 0..<(data?.result.count ?? 0){
                self.leage_name.append(data?.result[i].league_name ?? "")
                self.leage_key.append(data?.result[i].league_key ?? 0)

                self.leage_image.append(data?.result[i].league_logo ?? "")
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
    
    func initializeSearcBar(){
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false

        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
                
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
        cell.leage_image.kf.setImage(with: URL(string: leage_image[indexPath.row]),placeholder: UIImage(named: "teamHolder"))
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagues_desc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesDescription") as!LeaguesDescription
        
      
        leagues_desc.sportType = sport
        leagues_desc.legKey = leage_key[indexPath.row]
        
        leagues_desc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(leagues_desc, animated: true)
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            
//            if  searchText.isEmpty {
//                filteredNames = leage_name
//            }else{
//                var predicate = NSPredicate(format: "leage_name CONTAINS[c] \(searchText)")
//                leage_name.predicate = predicate
//
//            }
           filteredNames = searchText.isEmpty ? leage_name :  leage_name.filter({ (name: String)-> Bool in
                return name.range(of: searchText,options: .caseInsensitive) != nil
            })
            print(searchText)
            leage_name = filteredNames
            tableView.reloadData()
        }
    }

}
