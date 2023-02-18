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
    
    override func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)
            self.contentView.layer.cornerRadius = 40
            self.layer.masksToBounds = true
        
        }
    
    
}
