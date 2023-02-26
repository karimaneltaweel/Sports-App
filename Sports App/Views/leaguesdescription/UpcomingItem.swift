//
//  UpcomingItem.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit

class UpcomingItem: UICollectionViewCell {
    
    @IBOutlet weak var team1Img: UIImageView!
    @IBOutlet weak var team2Img: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)
        
            self.contentView.layer.cornerRadius = 40
            self.layer.cornerRadius = 40
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        
            self.team1Img.layer.cornerRadius = team1Img.frame.size.width/2
            self.team1Img.layer.cornerRadius = team1Img.frame.size.height/2

            self.team2Img.layer.cornerRadius = team2Img.frame.size.width/2
            self.team2Img.layer.cornerRadius = team2Img.frame.size.height/2

            self.layer.masksToBounds = true
        }
    func configureCell(sportType : String , item:Event)
    {
        switch(sportType){
        case "football" :
           team1Label.text =  item.event_home_team
        
            team2Label.text = item.event_away_team
            
            team1Img.kf.setImage(with: URL(string:item.home_team_logo ?? ""),placeholder: UIImage(named: ""))

            team2Img.kf.setImage(with: URL(string: item.away_team_logo ?? ""))
            date.text = item.event_date
           timeLabel.text = item.event_time
            
        case "tennis" :
            team1Label.text =  item.event_first_player
            timeLabel.text = item.event_time
            team2Label.text = item.event_second_player
            team1Img.kf.setImage(with: URL(string:item.event_first_player_logo ?? ""),placeholder: UIImage(named: "player1"))
            team2Img.kf.setImage(with: URL(string: item.event_second_player_logo ?? ""),placeholder: UIImage(named: "player2"))
            date.text = item.event_date
            
        case "basketball":
            team1Label.text =  item.event_home_team
            team2Label.text = item.event_away_team
            timeLabel.text = item.event_time
            team1Img.kf.setImage(with: URL(string:item.event_home_team_logo ?? ""),placeholder: UIImage(named: "holder1"))
            team2Img.kf.setImage(with: URL(string: item.event_away_team_logo ?? ""),placeholder: UIImage(named: "league"))
            
            date.text = item.event_date
            
        case "cricket":
            
            team1Label.text =  item.event_home_team
            team2Label.text = item.event_away_team
            team1Img.kf.setImage(with: URL(string:item.event_home_team_logo ?? ""),placeholder: UIImage(named: "cricket1"))
            timeLabel.text = item.event_time
           team2Img.kf.setImage(with: URL(string: item.event_away_team_logo ?? ""),placeholder: UIImage(named: "cricket2"))
            date.text = item.event_date_start
        default:
           print("no type")
        }
    }
}
