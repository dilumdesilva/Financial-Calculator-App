//
//  Mortgage.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/7/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import Foundation

enum MortageCalculationComponent{
    case loanAmount
    case interestRate
    case payment
    case numberOfYears
    
    static let getAllComponents = [loanAmount, interestRate, payment, numberOfYears]
}


struct Mortage {
    let value: Double
    let component: MortageCalculationComponent
    
    init(component: MortageCalculationComponent, value: Double) {
        self.component = component
        self.value = value
    }
    
    func calculateMissingComponent(component missing: MortageCalculationComponent) -> Double{
        var missingOutput = 0.0
        
        switch component {
        case .loanAmount:
            print("Missing")
        case .interestRate:
            print("Missing")
        case .payment:
            print("Missing")
        case .numberOfYears:
            print("Missing")
        }
        
        missingOutput = 1.0
        return missingOutput
    }
}


  


