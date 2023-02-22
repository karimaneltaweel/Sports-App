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
    
    var fav1 :UIButton.Configuration?
    var fav2 :UIButton.Configuration?
    
    
    @IBOutlet weak var playersCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //----------call----userdefault----function----to---check---buttonstate--------
        //        fav1 = UIButton.Configuration.plain()
        //        fav1?.buttonSize = .large
        //        fav1?.cornerStyle = .medium
        //        fav1?.image = UIImage(systemName: "heart")
        //
        //        fav2 = UIButton.Configuration.plain()
        //        fav2?.buttonSize = .large
        //        fav2?.cornerStyle = .medium
        //        fav2?.image = UIImage(systemName: "heart.fill")
        //
        
        
        //        print(team_key)
        //        print(sporttype)
        
        //-----------fetch-------------data-----from Api---using----teamKey---------
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
            
        } else{
            favorite_btn.setImage(UIImage(systemName: "heart"), for: .normal)
            
            CoreDataManager.deleteFromCoreData(team_name: details?.result.first?.team_name ?? "")
            
            print("deleted")
            
            UserDefaults.standard.set(false, forKey: keyFav)
            UserDefaults.standard.set(true, forKey: keyNotFav)
            print("I am not selected.")
            
            //        if (favorite_btn.configuration?.image == UIImage(systemName: "heart")){
            //            favorite_btn.configuration = fav2
            //            print("saved")
            //            CoreDataManager.saveToCoreData(team_name: details?.result.first?.team_name ?? "", team_logo: details?.result.first?.team_logo ?? "")
            //        }
            //        else if(favorite_btn.configuration?.image == UIImage(systemName: "heart.fill")){
            //            favorite_btn.configuration = fav1
            //
            //            CoreDataManager.deleteFromCoreData(team_name: details?.result.first?.team_name ?? "")
            //        }
        }}
    
    @IBAction func favAction(_ sender: Any) {
        updateUI()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2.065, height: self.view.frame.height * 0.42)
    }


}
