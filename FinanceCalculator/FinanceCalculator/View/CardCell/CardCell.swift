//
//  CardCell.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/8/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {

    @IBOutlet weak var cardIcon: UIImageView!
    @IBOutlet weak var cardLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setData(text: String, icon: UIImage){
        self.cardLabel.text = text
        self.cardIcon.image = icon
    }

}
