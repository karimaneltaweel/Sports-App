//
//  FavTeamTableVC.swift
//  Sports App
//
//  Created by Omar on 21/02/2023.
//

import UIKit
import Kingfisher

class FavTeamTableVC: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    var favoriteTeams : [FavoriteTeam] = []
    
    
    @IBOutlet weak var table_v: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTeams = CoreDataManager.fetchFromCoreData()
        
        table_v.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table_v.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        
        cell.textLabel?.text = favoriteTeams[indexPath.row].team_name
        
        var url = URL(string: favoriteTeams[indexPath.row].team_logo ?? "")
        cell.imageView?.kf.setImage(with: url)
        
        return cell
    }
    
}
