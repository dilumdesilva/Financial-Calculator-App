//
//  History.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/10/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class History {
    let type: String
    let icon: UIImage
    let calculation: String
    
    init(type: String, icon: UIImage, calculation: String) {
        self.type = type
        self.icon = icon
        self.calculation = calculation
    }
    
    func getHistoryType() -> String {
        return type
    }
    
    func getHistoryIcon() -> UIImage {
        return icon
    }
    
    func getHistoryCalculation() -> String {
        return calculation
    }
}

