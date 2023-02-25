//
//  LeaguesTableView.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Alamofire


class LeaguesTableView: UITableViewController ,UISearchResultsUpdating, UISearchBarDelegate{
   

    var sport:String?
    var leage_name : [String] = []
    var leage_key : [Int] = []
    var leage_image : [String] = []
    var Count : Int?
    var events :UpComingEvents?

    var filteredNames : [String] = []
    //var searchController: UISearchController!
    let searchController = UISearchController(searchResultsController: nil)

    var isSearchBarEmpty: Bool{
            return searchController.searchBar.text!.isEmpty
        }
    var isFiltering : Bool{
            return searchController.isActive && !isSearchBarEmpty
        }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        initializeSearcBar()
        
       changeSportTypeName()
        
        guard let sport_type = sport else{return}
        
        print(sport_type )
        let API_URL = "https://apiv2.allsportsapi.com/\(sport_type)/?met=Leagues&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34"
        ApiService.fetchFromApi(API_URL: API_URL) { (data : LeagueSport?,dictionary) in
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

        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Task"
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField

        textFieldInsideSearchBar?.textColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = false
                
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if isFiltering {
               return filteredNames.count
           }
           return leage_name.count
       }
      
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableCell
           
           let leagName : String
           
           if isFiltering {
               leagName = filteredNames[indexPath.row]
               
           }else{
               leagName = leage_name[indexPath.row]
           }
            
           cell.leage_label.text = leagName
           cell.leage_image.kf.setImage(with: URL(string: leage_image[indexPath.row]),placeholder: UIImage(named: "teamHolder"))

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
    // Helper Function
    func filterContentForSearchText(_ searchText : String, category : String? = nil){
        filteredNames = leage_name.filter{
            return $0.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }


    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            
            //           filteredNames = searchText.isEmpty ? leage_name :  leage_name.filter({ (name: String)-> Bool in
            //                return name.range(of: searchText,options: .caseInsensitive) != nil
            //            })
            //            print(searchText)
            //            leage_name = filteredNames
            //            tableView.reloadData()
            //        }
            filterContentForSearchText(searchController.searchBar.text!)
        }
    }
    func showAlert(){
        let alert = UIAlertController(title: "attention", message: "There is no events today", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }

}
