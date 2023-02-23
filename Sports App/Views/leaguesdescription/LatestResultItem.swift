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
    
    
}
