//
//  HomwTableViewCell.swift
//  BabyOto
//
//  Created by Developer on 7/27/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameSound: UILabel!
    @IBOutlet weak var iconSound: UIImageView!
    @IBOutlet weak var buttonPause: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
