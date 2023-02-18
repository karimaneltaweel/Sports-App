//
//  LeaguesDescription.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Kingfisher
class LeaguesDescription: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    var upcommingEvents = [Event]()
    var sportType :String?
    
    @IBOutlet weak var upComming: UICollectionView!
    @IBOutlet weak var latestResult: UICollectionView!
    @IBOutlet weak var teams: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       changeSportTypeName()
        
        ApiService.fetchUpComming(sport_type: sportType ?? "") { data in
        
            if let events = data?.result {
                self.upcommingEvents = events
              
            }
            
            DispatchQueue.main.async {
                self.upComming.reloadData()
            }
            

        }
        
        
        
    }
    
    func changeSportTypeName(){
        switch(sportType){
        case "Football" :
            sportType = "football"
        case "Tennis" :
            sportType = "tennis"
        case "Basketball":
            sportType = "basketball"
        case "Cricket":
            sportType = "cricket"
        default:
           print("no type")
        }
    }
    

    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == upComming){
            
            return upcommingEvents.count
            
        }
        if (collectionView == latestResult){

            return 20
            
        }
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == upComming){
            
            return CGSize(width:self.view.frame.width, height: self.view.frame.height*0.17)
            
        }
        if (collectionView == latestResult){

            return CGSize(width: self.view.frame.width*0.95 , height: self.view.frame.height * 0.17)
            
        }
        
        return CGSize(width: self.view.frame.width * 0.35, height: self.view.frame.height * 0.17)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == upComming){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpcomingItem
            
            switch(sportType){
            case "football" :
                cell.team1Label.text =  upcommingEvents[indexPath.row].event_home_team
            
                cell.team2Label.text = upcommingEvents[indexPath.row].event_away_team
                cell.team1Img.kf.setImage(with: URL(string:upcommingEvents[indexPath.row].home_team_logo ?? ""))
                print("p1 img : "+(upcommingEvents[indexPath.row].event_home_team_logo ?? ""))

                cell.team2Img.kf.setImage(with: URL(string: upcommingEvents[indexPath.row].away_team_logo ?? ""))
                cell.date.text = upcommingEvents[indexPath.row].event_date
            case "tennis" :
                cell.team1Label.text =  upcommingEvents[indexPath.row].event_first_player
            
                cell.team2Label.text = upcommingEvents[indexPath.row].event_second_player
                cell.team1Img.kf.setImage(with: URL(string:upcommingEvents[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "placeholder"))
                cell.team2Img.kf.setImage(with: URL(string: upcommingEvents[indexPath.row].event_second_player_logo ?? ""),placeholder: UIImage(named: "placeholder"))
                cell.date.text = upcommingEvents[indexPath.row].event_date
                
            case "basketball":
                cell.team1Label.text =  upcommingEvents[indexPath.row].event_home_team
                cell.team2Label.text = upcommingEvents[indexPath.row].event_away_team
                
                cell.team1Img.kf.setImage(with: URL(string:upcommingEvents[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "placeholder"))
                cell.team2Img.kf.setImage(with: URL(string: upcommingEvents[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "placeholder"))
                
                cell.date.text = upcommingEvents[indexPath.row].event_date
                
            case "cricket":
                
                cell.team1Label.text =  upcommingEvents[indexPath.row].event_home_team
                cell.team2Label.text = upcommingEvents[indexPath.row].event_away_team
                cell.team1Img.kf.setImage(with: URL(string:upcommingEvents[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "placeholder"))
    
                cell.team2Img.kf.setImage(with: URL(string: upcommingEvents[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "placeholder"))
                cell.date.text = upcommingEvents[indexPath.row].event_date_start
            default:
               print("no type")
            }

            return cell
            
        }
        //------------- latest result collection --------------
        if (collectionView == latestResult){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestresult", for: indexPath) as! LatestResultItem
            cell.team2Label.text = "real"
            cell.team1Label.text = "ahly"
            cell.scoreLabel.text = "2-1"
            
            return cell
            
        }
        
        // -------------- Teams collection ------------
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsItem
//        switch(sportType){
//        case "football":
//            cell.teamsImage.kf.setImage(with: URL(string:upcommingEvents[indexPath.row].home_team_logo ?? ""))
//        case "tennis":
//            cell.teamsImage.kf.setImage(with: URL(string:upcommingEvents[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "placeholder"))
//
//        default :
//            cell.teamsImage.kf.setImage(with: URL(string:upcommingEvents[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "placeholder"))
//
//        }
//
//
//        cell.teamsImage.image = UIImage(named: "placeholder")
        return cell
    }
    
    


}
