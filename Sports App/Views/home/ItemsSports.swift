//
//  ItemsSports.swift
//  Sports App
//
//  Created by kariman eltawel on 15/02/2023.
//

import UIKit

class ItemsSports: UICollectionViewCell {
    
    @IBOutlet weak var sportimg: UIImageView!
    @IBOutlet weak var sportlabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true

    }
}

