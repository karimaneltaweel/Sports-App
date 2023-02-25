//
//  FavoriteViewCell.swift
//  Sports App
//
//  Created by Omar on 25/02/2023.
//

import UIKit

class FavoriteViewCell: UITableViewCell {

    @IBOutlet weak var fav_img: UIImageView!
    
    
    @IBOutlet weak var fav_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fav_img.layer.cornerRadius = fav_img.frame.size.width/2
        fav_img.layer.cornerRadius = fav_img.frame.size.height/2
        fav_img.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
       

    }

}
