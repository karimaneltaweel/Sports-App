//
//  PlayerItem.swift
//  Sports App
//
//  Created by Omar on 17/02/2023.
//

import UIKit

class PlayerItem: UICollectionViewCell {
    
    
    @IBOutlet weak var PlayerImage: UIImageView!
    
    @IBOutlet weak var Playername: UILabel!
    
    @IBOutlet weak var playerAge: UILabel!
    
    @IBOutlet weak var playerPosition: UILabel!
    
    @IBOutlet weak var playerNumber: UILabel!
    
    override func layoutSublayers(of layer: CALayer) {
        
        super.layoutSubviews()
        self.PlayerImage.layer.cornerRadius = PlayerImage.frame.size.width/2.0
        self.playerPosition.clipsToBounds = true
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        }
        
    }

