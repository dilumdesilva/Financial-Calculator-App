//
//  HistoryTableViewCell.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/10/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblCalculationHistory: UILabel!
    @IBOutlet weak var imgVHistoryTypeIcon: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
    }
}
