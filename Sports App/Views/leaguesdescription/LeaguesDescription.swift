//
//  LeaguesDescription.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Kingfisher
class LeaguesDescription: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    @IBOutlet weak var TeamsLabelGui: UILabel!
    
    @IBOutlet weak var latest_resultlabel: UILabel!
    
    @IBOutlet weak var upcoming_label: UILabel!
    
    var events :UpComingEvents?
    var latestEvents: LatestRes?
    var sportType :String?
    var legKey:Int?
    
    @IBOutlet weak var upComming: UICollectionView!
    @IBOutlet weak var latestResult: UICollectionView!
    @IBOutlet weak var teams: UICollectionView!
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        print(legKey)
        super.viewDidLoad()
    
        TeamsLabelGui.layer.cornerRadius = 15
        TeamsLabelGui.clipsToBounds = true
        latest_resultlabel.layer.cornerRadius = 15
        latest_resultlabel.clipsToBounds = true
        upcoming_label.layer.cornerRadius = 15
        upcoming_label.clipsToBounds = true
        
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
        
        if sportType == "tennis"
        {
            TeamsLabelGui.text = "Players"
        }
        else{
            TeamsLabelGui.text = "Teams"
        }
        
        
            
        ApiService.fetchUpComming(sport_type: self.sportType ?? "",legKey: legKey ?? 0) {  data in
            self.events = data
            DispatchQueue.main.async{
                self.latestResult.reloadData()

                UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.upComming.reloadData()
                    self.teams.reloadData()
                    self.latestResult.reloadData()
                    self.upComming.alpha = 1
                    fadeView.removeFromSuperview()
                    self.activityView.stopAnimating()
                }, completion: nil)
            }
        }

    
        ApiService.fetchLatestRes(sport_type: self.sportType ?? "") { data in
            self.latestEvents = data
            DispatchQueue.main.async{
                
                self.latestResult.reloadData()

                
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
 
            return events?.result.count ?? 0
        }
        if sportType == "cricket"
        {
            return events?.result.count ?? 0
        }
            
            return latestEvents?.result.count ?? 0
        
        if sportType == "cricket"{
            
            return events?.result.count ?? 0
        }
       
            return latestEvents?.result.count ?? 0
            

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
                
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].home_team_logo ?? ""),placeholder: UIImage(named: ""))
 
                cell.team2Img.kf.setImage(with: URL(string: events?.result[indexPath.row].away_team_logo ?? ""))
                cell.date.text = events?.result[indexPath.row].event_date
                cell.timeLabel.text = events?.result[indexPath.row].event_time
                
            case "tennis" :
                cell.team1Label.text =  events?.result[indexPath.row].event_first_player
                cell.timeLabel.text = events?.result[indexPath.row].event_time
                cell.team2Label.text = events?.result[indexPath.row].event_second_player
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "player1"))
                cell.team2Img.kf.setImage(with: URL(string: events?.result[indexPath.row].event_second_player_logo ?? ""),placeholder: UIImage(named: "player2"))
                cell.date.text = events?.result[indexPath.row].event_date
                
            case "basketball":
                cell.team1Label.text =  events?.result[indexPath.row].event_home_team
                cell.team2Label.text = events?.result[indexPath.row].event_away_team
                cell.timeLabel.text = events?.result[indexPath.row].event_time
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "holder1"))
                cell.team2Img.kf.setImage(with: URL(string: events?.result[indexPath.row].event_away_team_logo ?? ""),placeholder: UIImage(named: "league"))
                
                cell.date.text = events?.result[indexPath.row].event_date
                
            case "cricket":
                
                cell.team1Label.text =  events?.result[indexPath.row].event_home_team
                cell.team2Label.text = events?.result[indexPath.row].event_away_team
                cell.team1Img.kf.setImage(with: URL(string:events?.result[indexPath.row].event_home_team_logo ?? ""),placeholder: UIImage(named: "cricket1"))
                cell.timeLabel.text = events?.result[indexPath.row].event_time
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
             switch(sportType){
             case "tennis":
                 cell.team1Label.text = latestEvents?.result[indexPath.row].event_first_player
                 cell.team2Label.text = latestEvents?.result[indexPath.row].event_second_player
                 cell.scoreLabel.text = latestEvents?.result[indexPath.row].event_final_result
                 cell.team1img.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].event_first_player_logo ?? ""),placeholder: UIImage(named: "player1"))
                 cell.team2img.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].event_second_player_logo ?? ""),placeholder: UIImage(named: "player2"))
                 
             case "cricket":
                 // get it from the same api of upcomming abd teams as it not found in latest res api
                 cell.team1Label.text = events?.result[indexPath.row].event_home_team
                 cell.team2Label.text = events?.result[indexPath.row].event_away_team
                 cell.scoreLabel.text = events?.result[indexPath.row].event_away_final_result
                 cell.team1img.kf.setImage(with: URL(string: events?.result[indexPath.row].home_team_logo ?? ""),placeholder: UIImage(named: "cricket1"))
                 cell.team2img.kf.setImage(with: URL(string: events?.result[indexPath.row].away_team_logo ?? ""),placeholder: UIImage(named: "cricket2"))
             default :
                 cell.team1Label.text = latestEvents?.result[indexPath.row].event_home_team
                 cell.team2Label.text = latestEvents?.result[indexPath.row].event_away_team
                 cell.scoreLabel.text = latestEvents?.result[indexPath.row].event_final_result
                 cell.team1img.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].home_team_logo ?? ""),placeholder:UIImage(named:"holder1") )
                 cell.team2img.kf.setImage(with: URL(string: latestEvents?.result[indexPath.row].away_team_logo ?? ""),placeholder: UIImage(named:"league"))
             }
            
            return cell
            
        }
        
        // -------------- Teams collection ------------
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsItem
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


        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teams
        {
            if sportType == "tennis"{
                
                print("tennis")
            }
            else{
                
                let teamsDeatailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamsDetailsView") as! TeamsDetailsView
                
                teamsDeatailsVC.team_key = events?.result[indexPath.row].home_team_key
                teamsDeatailsVC.sporttype = sportType
                
                self.navigationController?.pushViewController(teamsDeatailsVC, animated: true)}
        }
    }
    
    


}
