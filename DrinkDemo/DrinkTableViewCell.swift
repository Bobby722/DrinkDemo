//
//  DrinkTableViewCell.swift
//  DrinkDemo
//
//  Created by 林嫈沛 on 2019/4/17.
//  Copyright © 2019 lohaslab. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var drink: UILabel!
    @IBOutlet weak var sweet: UILabel!
    @IBOutlet weak var ice: UILabel!
    @IBOutlet weak var size: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
