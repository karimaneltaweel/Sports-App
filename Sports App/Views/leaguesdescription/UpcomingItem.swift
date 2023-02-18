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
    
    override func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)
            self.contentView.layer.cornerRadius = 40
            self.team1Img.layer.cornerRadius = team1Img.frame.size.width/2
            self.team1Img.layer.cornerRadius = team1Img.frame.size.height/2

            self.team2Img.layer.cornerRadius = team2Img.frame.size.width/2
            self.team2Img.layer.cornerRadius = team2Img.frame.size.height/2

            self.layer.masksToBounds = true
        }
}
