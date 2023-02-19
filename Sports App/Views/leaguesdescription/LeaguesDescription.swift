//
//  LeaguesDescription.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Kingfisher
class LeaguesDescription: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
//    var upcommingEvents = [Event]()
    var events :UpComingEvents?
    var sportType :String?
    
    @IBOutlet weak var upComming: UICollectionView!
    @IBOutlet weak var latestResult: UICollectionView!
    @IBOutlet weak var teams: UICollectionView!
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let fadeView:UIView = UIView()
                    fadeView.frame = self.view.frame
                fadeView.backgroundColor = UIColor.white
                    fadeView.alpha = 0.4

                    self.view.addSubview(fadeView)

                    self.view.addSubview(activityView)
                    activityView.hidesWhenStopped = true
                    activityView.center = self.view.center
                    activityView.startAnimating()
        
        
       changeSportTypeName()
        
        ApiService.fetchUpComming(sport_type: sportType ?? "") { data in
        
            self.events = data
//            if let events = data?.result {
//                self.upcommingEvents = events
//
//            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                                    self.upComming.reloadData()
                                    self.teams.reloadData()
                                        self.upComming.alpha = 1
                                        fadeView.removeFromSuperview()
                                        self.activityView.stopAnimating()
                                    }, completion: nil)
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
        if (collectionView == upComming || collectionView == teams){
            
//            return upcommingEvents.count
            return events?.result.count ?? 0
        }
//        if (collectionView == latestResult){
//
//            return 20
//
//        }
        
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
                cell.team1Label.text =  events?.result[indexPath.row].event_home_team
            
                cell.team2Label.text = events?.result[indexPath.row].event_away_team
                
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].home_team_logo ?? ""))
                
//                print("p1 img : "+(events?.result[indexPath.row].event_home_team_logo ?? ""))

                cell.team2Img.kf.setImage(with: URL(string: events?.result[indexPath.row].away_team_logo ?? ""))
                cell.date.text = events?.result[indexPath.row].event_date
                
            case "tennis" :
                cell.team1Label.text =  events?.result[indexPath.row].event_first_player
            
                cell.team2Label.text = events?.result[indexPath.row].event_second_player
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "player1"))
                cell.team2Img.kf.setImage(with: URL(string: events?.result[indexPath.row].event_second_player_logo ?? ""),placeholder: UIImage(named: "player2"))
                cell.date.text = events?.result[indexPath.row].event_date
                
            case "basketball":
                cell.team1Label.text =  events?.result[indexPath.row].event_home_team
                cell.team2Label.text = events?.result[indexPath.row].event_away_team
                
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "holder1"))
                cell.team2Img.kf.setImage(with: URL(string: events?.result[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "league"))
                
                cell.date.text = events?.result[indexPath.row].event_date
                
            case "cricket":
                
                cell.team1Label.text =  events?.result[indexPath.row].event_home_team
                cell.team2Label.text = events?.result[indexPath.row].event_away_team
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "cricket1"))
    
                cell.team2Img.kf.setImage(with: URL(string: events?.result[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "cricket2"))
                cell.date.text = events?.result[indexPath.row].event_date_start
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
        print(sportType ?? "")
        print(events?.result.count)
        switch(sportType)
        {
        case "football":
            cell.teamsImage.kf.setImage(with: URL(string:events?.result[indexPath.row].home_team_logo ?? ""))
        case "tennis":
            cell.teamsImage.kf.setImage(with: URL(string:events?.result[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "player1"))
        case "basketball":
            cell.teamsImage.kf.setImage(with: URL(string:events?.result[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "placeholder"))

        default :
            cell.teamsImage.kf.setImage(with: URL(string:events?.result[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "cricketPH"))

        }


//        cell.teamsImage.image = UIImage(named: "placeholder")
        return cell
    }
    
    


}
