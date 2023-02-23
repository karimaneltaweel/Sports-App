//
//  LeaguesTableCell.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit

class LeaguesTableCell: UITableViewCell {

    
    
    @IBOutlet weak var leage_label: UILabel!
    
    
    @IBOutlet weak var leage_image: UIImageView!
    
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
        // -----leage_image-----
        leage_image.layer.cornerRadius = leage_image.frame.size.width/2
        leage_image.layer.cornerRadius = leage_image.frame.size.height/2


        leage_image.clipsToBounds = true
        
        
        
        contentView.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}
