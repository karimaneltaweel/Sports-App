//
//  PlayerItem.swift
//  Sports App
//
//  Created by Omar on 17/02/2023.
//

import UIKit

class PlayerItem: UICollectionViewCell {
    
    
    @IBOutlet weak var player_img: UIImageView!
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSubviews()
        self.player_img.layer.cornerRadius = player_img.frame.size.width/2
        self.player_img.layer.cornerRadius = player_img.frame.size.height/2

//        self.layer.cornerRadius = self.frame.size.width/2.0
        self.player_img.clipsToBounds = true
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowRadius = 0.5
    }
}
