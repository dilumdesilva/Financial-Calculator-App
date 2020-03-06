//
//  Calculation.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/6/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit


//MARK: Calculation Model to populate calculation view
class Calculation {
    let name: String
    let icon: UIImage
    let segueID: String
    let cellColour: UIColor
    
    init(name: String, icon: UIImage, segueID: String, cellColour: UIColor) {
        self.name = name
        self.icon = icon
        self.segueID = segueID
        self.cellColour = cellColour
    }
    
    func getCalculationName() -> String {
        return name
    }
    
    func getCalculationIcon() -> UIImage {
        return icon
    }
    
    func getSegueID() -> String {
        return segueID
    }
    
    func getCellColour() -> UIColor {
        return cellColour
    }
}
