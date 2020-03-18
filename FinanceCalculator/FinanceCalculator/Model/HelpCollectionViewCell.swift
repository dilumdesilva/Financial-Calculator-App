//
//  HelpCollectionViewCell.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/17/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class HelpCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bgImageView: UIImageView!
    @IBOutlet var bgColourView: UIView!
    @IBOutlet var helpCalculationTitle: UILabel!

    @IBOutlet weak var titleDescriptionLabel: UILabel!
    
    var helpViewCards: HelpViewCards! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        if let helpViewCard = helpViewCards {
            bgImageView.image = helpViewCard.cardbgImage
            bgColourView.backgroundColor = helpViewCard.bgColor
            helpCalculationTitle.text = helpViewCard.title
            titleDescriptionLabel.text = helpViewCard.description
        } else {
            bgImageView.image = nil
            bgColourView.backgroundColor = nil
            helpCalculationTitle.text = nil
            titleDescriptionLabel.text = nil
        }
        
        bgColourView.layer.cornerRadius = 10.0
        bgColourView.layer.masksToBounds = true
        bgImageView.layer.cornerRadius = 10.0
        bgImageView.layer.masksToBounds = true
    }
}
