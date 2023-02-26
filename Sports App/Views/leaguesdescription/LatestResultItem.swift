//
//  LatestResultItem.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit

class LatestResultItem: UICollectionViewCell {
    
    @IBOutlet weak var team1Label: UILabel!
    
    @IBOutlet weak var team2Label: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var team2img: UIImageView!
    
    
    @IBOutlet weak var team1img: UIImageView!
    
    
    override func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)
            self.layer.cornerRadius = 40
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
            self.contentView.layer.cornerRadius = 40
            self.layer.masksToBounds = true
        
        
        team1img.layer.cornerRadius = team1img.frame.size.width/2
        team1img.layer.cornerRadius = team1img.frame.size.height/2


        team1img.clipsToBounds = true
        
        team2img.layer.cornerRadius = team2img.frame.size.width/2
        team2img.layer.cornerRadius = team2img.frame.size.height/2


        team2img.clipsToBounds = true
        
        scoreLabel.layer.cornerRadius = 15
        scoreLabel.clipsToBounds = true
    
        }
    
    func configureCell(sportType : String , item:Event , latestResItem : EventRes)
    {
        switch(sportType){
        case "tennis":
            team1Label.text = latestResItem.event_first_player
            team2Label.text = latestResItem.event_second_player
            scoreLabel.text = latestResItem.event_final_result
            team1img.kf.setImage(with: URL(string: latestResItem.event_first_player_logo ?? ""),placeholder: UIImage(named: "player1"))
            team2img.kf.setImage(with: URL(string: latestResItem.event_second_player_logo ?? ""),placeholder: UIImage(named: "player2"))
            
        case "cricket":
            // get it from the same api of upcomming abd teams as it not found in latest res api
            team1Label.text = item.event_home_team
            team2Label.text = item.event_away_team
            scoreLabel.text = item.event_away_final_result
            team1img.kf.setImage(with: URL(string: item.home_team_logo ?? ""),placeholder: UIImage(named: "cricket1"))
            team2img.kf.setImage(with: URL(string: item.away_team_logo ?? ""),placeholder: UIImage(named: "cricket2"))
        default :
            team1Label.text = latestResItem.event_home_team
            team2Label.text = latestResItem.event_away_team
            scoreLabel.text = latestResItem.event_final_result
            team1img.kf.setImage(with: URL(string: latestResItem.home_team_logo ?? ""),placeholder:UIImage(named:"holder1") )
            team2img.kf.setImage(with: URL(string: latestResItem.away_team_logo ?? ""),placeholder: UIImage(named:"league"))
        }
    }
    
    
}
