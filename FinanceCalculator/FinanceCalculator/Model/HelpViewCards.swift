//
//  HelpViewCards.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/17/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class HelpViewCards{
    var title = ""
    var description = ""
    var cardbgImage: UIImage
    var bgColor: UIColor
    
    init(title:String, description:String, bgImage:UIImage, bgColor:UIColor) {
        self.title = title
        self.description = description
        self.cardbgImage = bgImage
        self.bgColor = bgColor
    }
    
    static func fetchCardData() -> [HelpViewCards]
    {
        return [
            HelpViewCards(title: Constants.SavingsWithRC_Title,
                          description: Constants.SavingsWithRC_Desc,
                          bgImage: UIImage(named: "bg3")!,
                          bgColor: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255/0, alpha: 0.8)),
                          
            HelpViewCards(title: Constants.SavingsWithoutRC_Title,
                          description: Constants.SavingsWithoutRC_Desc,
                          bgImage: UIImage(named: "bg3")!,
                          bgColor: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255/0, alpha: 0.8)),
                          
            HelpViewCards(title: Constants.Loan_Title,
                          description: Constants.Loan_Desc,
                          bgImage: UIImage(named: "bg3")!,
                          bgColor: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255/0, alpha: 0.8)),
                          
            HelpViewCards(title: Constants.Mortgage_Title,
                          description: Constants.Mortgage_Desc,
                          bgImage: UIImage(named: "bg3")!,
                          bgColor: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255/0, alpha: 0.8)),
        ]
    }
}

