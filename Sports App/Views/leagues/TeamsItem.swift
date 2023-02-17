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
}

