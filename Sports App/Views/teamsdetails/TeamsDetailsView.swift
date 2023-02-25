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
    var favKey = ""
    
    @IBOutlet weak var coachLabel: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var Coach: UILabel!
    
    @IBOutlet weak var favorite_btn: UIButton!
    
    //---passed---data--------------
    
    var team_key:Int?
    var sporttype:String?
    var details:TeamDetails?
    var team_details :TeamCK?

    
    let activityView = UIActivityIndicatorView(style: .large)

    
    @IBOutlet weak var playersCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if sporttype == "football"{
            coachLabel.text = "Coach"
        }else{
            coachLabel.text = ""
        }
        //----------call----userdefault----function----to---check---buttonstate--------
        //-----------fetch-------------data-----from Api---using----teamKey---------
        //--------------check---------buttonState------------------------
        
        let API_URL = "https://apiv2.allsportsapi.com/\(sporttype ?? "")/?&met=Teams&teamId=\(team_key ?? 0)&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34"
        
        switch sporttype
        {
        case "basketball","cricket" :
            ApiService.fetchFromApi(API_URL: API_URL) { [self] (response : TeamCK?,dictionary) in
                team_details = response

                DispatchQueue.main.async {
                    self.teamImage.kf.setImage(with: URL(string:self.team_details?.result.first?.team_logo ?? ""),placeholder: UIImage(named: "teamHolder"))
                    self.teamImage.layer.cornerRadius = self.teamImage.frame.size.width/2.0
                    self.teamImage.clipsToBounds = true

                    self.Coach.text = " "
                    self.teamName.text = self.team_details?.result.first?.team_name
                }
            }

        default :
            ApiService.fetchFromApi(API_URL: API_URL) { data,dictionary in
                self.details = data
                DispatchQueue.main.async{
                    
                    self.favKey = "\(self.team_key ?? 0)"
                    print(self.favKey)
                    if UserDefaults.standard.bool(forKey: self.favKey){
                        self.favorite_btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        print("add fav")
                        
                    }else{
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
         
        favorite_btn.isSelected =  UserDefaults.standard.bool(forKey: self.favKey)

        
        favorite_btn.isSelected = !favorite_btn.isSelected
        if favorite_btn.isSelected {
            
            favorite_btn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            CoreDataManager.saveToCoreData(team_name: details?.result.first?.team_name ?? "", team_logo: details?.result.first?.team_logo ?? "",team_key: team_key ?? 0)
            UserDefaults.standard.set(true, forKey: "\(favKey)")
            
            
            guard let name = details?.result.first?.team_name else{
                return
            }
            
            showToast(message: "\(name) added to favourite successfully )", seconds: 1.0)
            
        }
        else{
            
            favorite_btn.setImage(UIImage(systemName: "heart"), for: .normal)
            CoreDataManager.deleteFromCoreData(team_name: details?.result.first?.team_name ?? "")
            UserDefaults.standard.set(false, forKey:  "\(favKey)")

        
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
            alert.view.layer.cornerRadius = 15
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
            }
        }


}

