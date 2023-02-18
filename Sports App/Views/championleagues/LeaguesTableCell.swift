//
//  LeaguesTableCell.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit

class LeaguesTableCell: UITableViewCell {

    
    
    @IBOutlet weak var leage_label: UILabel!
    
    
    
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
        contentView.layer.cornerRadius = 20
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}
