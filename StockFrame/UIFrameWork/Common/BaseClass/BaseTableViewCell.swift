//
//  BaseTableViewCell.swift
//  StockFrame
//
//  Created by fdt on 2018/7/20.
//  Copyright © 2018年 ljt. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override class var requiresConstraintBasedLayout : Bool {
        return true;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
