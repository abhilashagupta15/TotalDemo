//
//  HomeTableViewCell.swift
//  Total Demo
//
//  Created by Nimish Gupta on 10/11/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_likes: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
