//
//  TeamsDetailsView.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Kingfisher
import CoreData
class TeamsDetailsView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
   
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var Coach: UILabel!
    
    @IBOutlet weak var favorite_btn: UIButton!
    var team_key:Int?
    var sporttype:String?
    var details:TeamDetails?
    var fav1 :UIButton.Configuration?
    var fav2 :UIButton.Configuration?
    
    
    @IBOutlet weak var playersCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fav1 = UIButton.Configuration.plain()
        fav1?.buttonSize = .large
        fav1?.cornerStyle = .medium
        fav1?.image = UIImage(systemName: "heart")
        
        fav2 = UIButton.Configuration.plain()
        fav2?.buttonSize = .large
        fav2?.cornerStyle = .medium
        fav2?.image = UIImage(systemName: "heart.fill")
        
        
        
        print(team_key)
        print(sporttype)
        
        ApiService.fetchTeamDetails(sport_type: sporttype ?? "", team_key: team_key ?? 0) { data in
            self.details = data
            DispatchQueue.main.async{
                
                self.teamImage.kf.setImage(with: URL(string:self.details?.result.first?.team_logo ?? ""),placeholder: UIImage(named: "teamHolder"))
                self.teamImage.layer.cornerRadius = self.teamImage.frame.size.width/2.0
                self.teamImage.clipsToBounds = true
                
                self.Coach.text = self.details?.result.first?.coaches.first?.coach_name
                self.teamName.text = self.details?.result.first?.team_name
                self.playersCollection.reloadData()
                
            }
            
            print(self.details?.result[0].team_name)
            print(self.Coach.text = self.details?.result[0].coaches[0].coach_name)
            
        }
   
    }
    
   
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details?.result[0].players.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playeritem", for: indexPath) as! PlayerItem
        
        cell.Playername.text = details?.result[0].players[indexPath.row].player_name
        cell.playerAge.text = details?.result[0].players[indexPath.row].player_age
        cell.playerPosition.text = details?.result[0].players[indexPath.row].player_type
        cell.playerNumber.text = details?.result[0].players[indexPath.row].player_number
        cell.PlayerImage.kf.setImage(with: URL(string:details?.result[0].players[indexPath.row].player_image ?? ""),placeholder: UIImage(named: "playerHolder"))

        return cell
        
    }
    
    fileprivate func updateUI() {
        if (favorite_btn.configuration?.image == UIImage(systemName: "heart")){
            favorite_btn.configuration = fav2
            print("saved")
            CoreDataManager.saveToCoreData(team_name: details?.result.first?.team_name ?? "", team_logo: details?.result.first?.team_logo ?? "")
        }
        else if(favorite_btn.configuration?.image == UIImage(systemName: "heart.fill")){
            favorite_btn.configuration = fav1

//            CoreDataManager.deleteFromCoreData(team_name: details?.result.first?.team_name ?? "")
        }
    }
    
    @IBAction func favAction(_ sender: Any) {
        updateUI()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2.065, height: self.view.frame.height * 0.42)
    }


}
