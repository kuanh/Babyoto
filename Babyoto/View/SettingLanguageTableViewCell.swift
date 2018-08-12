//
//  SettingTableViewCell.swift
//  BabyOto
//
//  Created by Developer on 7/31/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class SettingLanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var displayLanguage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
