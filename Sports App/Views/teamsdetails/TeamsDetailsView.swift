//
//  TeamsDetailsView.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Kingfisher
import CoreData

protocol RenderTableView
{
    func renderTableView()
}
class TeamsDetailsView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    var keyFav = ""
    var keyNotFav = ""
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var Coach: UILabel!
    
    @IBOutlet weak var favorite_btn: UIButton!
    
    //---passed---data--------------
    
    var team_key:Int?
    var sporttype:String?
    var details:TeamDetails?
    var team_details :TeamCK?
    
    var fav1 :UIButton.Configuration?
    var fav2 :UIButton.Configuration?
    
    
    @IBOutlet weak var playersCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //----------call----userdefault----function----to---check---buttonstate--------
        //-----------fetch-------------data-----from Api---using----teamKey---------
        switch sporttype
        {
        case "basketball","cricket" :
            ApiService.fetchFromApi(team_key: team_key ?? 0, sport_type: sporttype ?? "") { [self] (response : TeamCK?) in
                team_details = response

                DispatchQueue.main.async {
                    self.teamImage.kf.setImage(with: URL(string:self.team_details?.result.first?.team_logo ?? ""),placeholder: UIImage(named: "teamHolder"))
                    self.teamImage.layer.cornerRadius = self.teamImage.frame.size.width/2.0
                    self.teamImage.clipsToBounds = true

                    self.Coach.text = " "
                    self.teamName.text = self.team_details?.result.first?.team_name
//                    self.playersCollection.reloadData()
                }
            }

        default :
            ApiService.fetchTeamDetails(sport_type: sporttype ?? "", team_key: team_key ?? 0) { data in
                self.details = data
                DispatchQueue.main.async{
                    
                    self.keyFav = "\(self.team_key)"
                    self.keyNotFav = "\(self.team_key)"
                    print(self.keyFav)
                    print(self.keyNotFav)
                    if UserDefaults.standard.bool(forKey: self.keyFav){
                        self.favorite_btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        print("add fav")
                    }else if UserDefaults.standard.bool(forKey: self.keyNotFav){
                        self.favorite_btn.setImage(UIImage(systemName: "heart"), for: .normal)
                        print("not fav")
                    }
                    
                    self.teamImage.kf.setImage(with: URL(string:self.details?.result.first?.team_logo ?? ""),placeholder: UIImage(named: "teamHolder"))
                    self.teamImage.layer.cornerRadius = self.teamImage.frame.size.width/2.0
                    self.teamImage.clipsToBounds = true

                    self.Coach.text = self.details?.result.first?.coaches.first?.coach_name
                    self.teamName.text = self.details?.result.first?.team_name
                    self.playersCollection.reloadData()
                    
                
                }
                
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
    
    fileprivate func updateUI() {
        
        
        favorite_btn.isSelected = !favorite_btn.isSelected
        
        if favorite_btn.isSelected {
            print("I am selected.")
            favorite_btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
            print("saved")
            
            CoreDataManager.saveToCoreData(team_name: details?.result.first?.team_name ?? "", team_logo: details?.result.first?.team_logo ?? "")
            
            UserDefaults.standard.set(false, forKey: keyNotFav)
            UserDefaults.standard.set(true, forKey: keyFav)
            
            showToast(message: "\(details?.result.first?.team_name!) added to favourite successfully )", seconds: 7.0)
            
            
        } else{
            favorite_btn.setImage(UIImage(systemName: "heart"), for: .normal)
            
            CoreDataManager.deleteFromCoreData(team_name: details?.result.first?.team_name ?? "")
            
            print("deleted")
            
            UserDefaults.standard.set(false, forKey: keyFav)
            UserDefaults.standard.set(true, forKey: keyNotFav)
            print("I am not selected.")
        
        }}
    
    @IBAction func favAction(_ sender: Any) {
        updateUI()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2.065, height: self.view.frame.height * 0.42)
    }

    func showToast(message : String, seconds: Double){
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.view.backgroundColor = .red
            //alert.view.alpha = 0.5
            alert.view.layer.cornerRadius = 15
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
            }
        }

}
