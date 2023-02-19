//
//  TeamsDetailsView.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Kingfisher
class TeamsDetailsView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
   
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var Coach: UILabel!
    
    var team_key:Int?
    var sporttype:String?
    var details:TeamDetails?
    
    @IBOutlet weak var playersCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(team_key)
        
        ApiService.fetchTeamDetails(sport_type: sporttype ?? "", team_key: team_key ?? 0) { data in
            self.details = data
            DispatchQueue.main.async{
//                self.playersCollection.reloadData()
                
                self.teamImage.kf.setImage(with: URL(string:self.details?.result[0].team_logo ?? ""),placeholder: UIImage(named: "teamHolder"))
                self.teamImage.layer.cornerRadius = self.teamImage.frame.size.width/2.0
                        self.teamImage.clipsToBounds = true
                
                self.Coach.text = self.details?.result[0].coaches[0].coach_name
                self.teamName.text = self.details?.result[0].team_name
                self.playersCollection.reloadData()
                
            }
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
    
    @IBAction func favAction(_ sender: Any) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2.15, height: self.view.frame.height * 0.42)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
