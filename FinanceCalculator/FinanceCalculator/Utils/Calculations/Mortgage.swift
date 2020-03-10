//
//  Mortgage.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/7/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

extension UIViewController {
    ///
    /// A           -    the future value of the investment/loan, including interest
    /// P           -    the principal investment amount (the initial deposit or loan amount – present value)
    /// R           -    the annual interest rate (e.g. 3.2% is 0.032)
    /// N           -    the number of times that interest is compounded per unit time (this is always monthly for the purpose of this coursework, i.e. 12 per year)
    /// T           -     the time the money is invested or borrowed in months
    /// PMT      -    the Payment
    /// PayPY   -    the number of payments per year
    /// CpY       -    the number of compound payments per year
    /// PmtAt    -    the payment due at the beginning or end of each period (default is END)
    ///
    
    //  MARK: - Calculations related to the Mortgage
    
    ///
    /// Calcualates the missing monthly payment when principalAmount, interest and terms are given
    /// Parmeters:
    ///     monthlyPayment: Double    - PMT
    ///     interest: Double                   - R
    ///     terms: Double                      - N
    ///
    /// Calculation for principalAmount:  P = (PMT / R) * (1 - (1 / pow(1 + R, N)))
    ///
    func missingPrincipalAmount(interest: Double, monthlyPayment: Double, terms: Double) -> Double {
        let PMT = monthlyPayment;
        let R = (interest / 100.0) / 12;
        let N = terms;
        let P = (PMT / R) * (1 - (1 / pow(1 + R, N)));
        return P
    }
    
    func missingInterestRate() -> Double {
        return 2.0
    }
    
    ///
    /// Calcualates the missing monthly payment when principalAmount, interest and terms are given
    /// Parmeters:
    ///     principalAmount: Double     - P
    ///     interest: Double                   - R
    ///     terms: Double                      - N
    ///
    /// Calculation for monthly payment:  PMT = (R * P) / (1 - pow(1 + R, -N))
    ///
    func missingMonthlyPayment(interest: Double, principalAmount: Double, terms: Double) -> Double {
        let R = (interest / 100.0) / 12
        let P = principalAmount
        let N = terms
        let PMT = (R * P) / (1 - pow(1 + R, -N));
        return PMT
    }
    
    func missingPaymentTerms() -> Double {
        return 2.0
    }
}
