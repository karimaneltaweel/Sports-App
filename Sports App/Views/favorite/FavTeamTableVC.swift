//
//  FavTeamTableVC.swift
//  Sports App
//
//  Created by Omar on 21/02/2023.
//

import UIKit
import Kingfisher



class FavTeamTableVC:   UIViewController, UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var table_v: UITableView!
    var favoriteTeams : [FavoriteTeam] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("view Did load")
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("will Appear")
        favoriteTeams = CoreDataManager.fetchFromCoreData()
        table_v.reloadData()
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoriteTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavViewCell
        cell.layer.cornerRadius = 15
        cell.fav_label.text = favoriteTeams[indexPath.row].team_name
        
        let url = URL(string: favoriteTeams[indexPath.row].team_logo ?? "")
        cell.fav_img.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showAlert(indexPath: indexPath)
        }

    }
    
    
    
    func showAlert(indexPath: IndexPath){
        // declare Alert
        let alert = UIAlertController(title: "Delete", message: "are you sure about deletion", preferredStyle: .alert)
        
        
        
        //AddAction
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler: { [self] action in
            print("ok clicked")
            CoreDataManager.deleteFromCoreData(team_name: favoriteTeams[indexPath.row].team_name ?? "")
            favoriteTeams.remove(at: indexPath.row)
            table_v.deleteRows(at: [indexPath], with: .fade)
            
                    table_v.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel , handler: { action in
            print("Cancel clicked")
        }))
        

        //showAlert
        self.present(alert, animated: true) {
            print("alert done")
        }
    }
}
