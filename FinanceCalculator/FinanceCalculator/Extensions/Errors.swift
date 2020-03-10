//
//  Errors.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/10/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

extension UIViewController {
    /// To indicate runtime errors during the calculations
    enum CalculationError: Error {
        case runtimeError(String)
    }
}
