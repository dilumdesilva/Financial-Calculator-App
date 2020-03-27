//
//  HelpViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 2/27/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    ///outlets related to the help view cards
    @IBOutlet weak var mortgageViewCard: UIView!
    @IBOutlet weak var mortgageTitle: UILabel!
    @IBOutlet weak var mortgageDescription: UILabel!
    
    @IBOutlet weak var loanViewCard: UIView!
    @IBOutlet weak var loanTitle: UILabel!
    @IBOutlet weak var loanDescription: UILabel!
    
    @IBOutlet weak var savingsWRCCard: UIView!
    @IBOutlet weak var savingsWRCTitle: UILabel!
    @IBOutlet weak var savingsWRCDescription: UILabel!
    
    @IBOutlet weak var savingsWORCCard: UIView!
    @IBOutlet weak var savingsWORCTitle: UILabel!
    @IBOutlet weak var savingsWORCDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCardStyles()
        setCardContent()
    }
    
    /// To set the card styles
    func setCardStyles(){
        ///Making cards with rounded corners
        mortgageViewCard.layer.cornerRadius = 20
        mortgageViewCard.layer.masksToBounds = true
        mortgageViewCard.layer.borderColor = UIColor.darkGray.cgColor
        mortgageViewCard.layer.borderWidth = 0.8
        
        loanViewCard.layer.cornerRadius = 20
        loanViewCard.layer.masksToBounds = true
        loanViewCard.layer.borderColor = UIColor.darkGray.cgColor
        loanViewCard.layer.borderWidth = 0.8
        
        savingsWRCCard.layer.cornerRadius = 20
        savingsWRCCard.layer.masksToBounds = true
        savingsWRCCard.layer.borderColor = UIColor.darkGray.cgColor
        savingsWRCCard.layer.borderWidth = 0.8
        
        savingsWORCCard.layer.cornerRadius = 20
        savingsWORCCard.layer.masksToBounds = true
        savingsWORCCard.layer.borderColor = UIColor.darkGray.cgColor
        savingsWORCCard.layer.borderWidth = 0.8
    }
    
    func setCardContent(){
        ///setting titles of the cards
        mortgageTitle.text = Constants.Mortgage_Title
        loanTitle.text = Constants.Loan_Title
        savingsWORCTitle.text = Constants.SavingsWithoutRC_Title
        savingsWRCTitle.text = Constants.SavingsWithRC_Title
        
        ///setting descriptions of the cards
        mortgageDescription.text = Constants.Mortgage_Desc
        mortgageDescription.sizeToFit()
        loanDescription.text = Constants.Loan_Desc
        savingsWORCDescription.text = Constants.SavingsWithoutRC_Desc
        savingsWRCDescription.text = Constants.SavingsWithRC_Desc
    }
}
