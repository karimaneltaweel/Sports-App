//
//  TeamsItem.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit

class TeamsItem: UICollectionViewCell {
    
    @IBOutlet weak var teamsImage: UIImageView!
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSubviews()
        self.teamsImage.layer.cornerRadius = teamsImage.frame.size.width/2
        self.teamsImage.layer.cornerRadius = teamsImage.frame.size.height/2

//        self.layer.cornerRadius = self.frame.size.width/2.0
        self.teamsImage.clipsToBounds = true
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 0.5
    }
    
    func configureCell(sportType : String , item:Event)
    {
        switch(sportType)
        {
        case "football":
            teamsImage.kf.setImage(with: URL(string:item.home_team_logo ?? ""))
        case "tennis":
            teamsImage.kf.setImage(with: URL(string:item.event_first_player_logo ?? ""),placeholder: UIImage(named: "player1"))
        case "basketball":
            teamsImage.kf.setImage(with: URL(string:item.event_home_team_logo ?? ""),placeholder: UIImage(named: "placeholder"))

        default :
            teamsImage.kf.setImage(with: URL(string:item.event_home_team_logo ?? ""),placeholder: UIImage(named: "cricketPH"))

        }
    }
}

