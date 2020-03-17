//
//  Mortgage.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/7/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import Foundation
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
    /// Calculation for principalAmount:
    ///     P = (PMT / R) * (1 - (1 / pow(1 + R, N)))
    ///
    func calculateMissingPrincipalAmount(interest: Double, monthlyPayment: Double, terms: Double) -> Double {
        let PMT = monthlyPayment
        let R = (interest / 100.0) / 12
        let N = terms
        let P = (PMT / R) * (1 - (1 / pow(1 + R, N)))
        return P.toFixed(2)
    }
    
    ///
    /// Calcualates the missing monthly payment when principalAmount, interest and terms are given
    /// Parmeters:
    ///     principalAmount: Double     - P
    ///     monthlyPayment: Double    - PMT
    ///     terms: Double                      - N
    ///
    /// Calculation for monthly payment:
    ///
    ///
    func calculateMissingInterestRate(principalAmount: Double, monthlyPayment: Double, terms: Double) -> Double {
        /// initial calculation
        var x = 1 + (((monthlyPayment*terms/principalAmount) - 1) / 12)
        /// var x = 0.1;
        let FINANCIAL_PRECISION = Double(0.000001) // 1e-6
        
        func F(_ x: Double) -> Double { // f(x)
            /// (loan * x * (1 + x)^n) / ((1+x)^n - 1) - pmt
            return Double(principalAmount * x * pow(1 + x, terms) / (pow(1+x, terms) - 1) - monthlyPayment);
        }
                            
        func FPrime(_ x: Double) -> Double { // f'(x)
            /// (loan * (x+1)^(n-1) * ((x*(x+1)^n + (x+1)^n-n*x-x-1)) / ((x+1)^n - 1)^2)
            let c_derivative = pow(x+1, terms)
            return Double(principalAmount * pow(x+1, terms-1) *
                (x * c_derivative + c_derivative - (terms*x) - x - 1)) / pow(c_derivative - 1, 2)
        }
        
        while(abs(F(x)) > FINANCIAL_PRECISION) {
            x = x - F(x) / FPrime(x)
        }

        /// Convert to yearly interest & Return as a percentage
        /// with two decimal fraction digits
        let R = Double(12 * x * 100).toFixed(2)

        /// if the found value for I is inf or less than zero
        /// there's no interest applied
        if R.isNaN || R.isInfinite || R < 0 {
            return 0.0;
        } else {
          /// this may return a value more than 100% for cases such as
          /// where payment = 2000, terms = 12, amount = 10000  <--- unreal figures
          return R
        }
    }
    
    ///
    /// Calcualates the missing monthly payment when principalAmount, interest and terms are given
    /// Parmeters:
    ///     principalAmount: Double     - P
    ///     interest: Double                   - R
    ///     terms: Double                      - N
    ///
    /// Calculation for monthly payment:
    ///     PMT = (R * P) / (1 - pow(1 + R, -N))
    ///
    func calculateMissingMonthlyPayment(interest: Double, principalAmount: Double, terms: Double) -> Double {
        let R = (interest / 100.0) / 12
        let P = principalAmount
        let N = terms
        let PMT = (R * P) / (1 - pow(1 + R, -N))
        return PMT
    }
    
    ///
    /// Calcualates the missing monthly payment when principalAmount, interest and terms are given
    /// Parmeters:
    ///     principalAmount: Double     - P
    ///     interest: Double                   - R
    ///     monthlyPayment: Double    - PMT
    ///
    /// Calculation for monthly payment:
    ///     N = (log(D/(D-PV)) / log(1+I))
    ///
    func calculateMissingPaymentTerms(interest: Double, principalAmount: Double, monthlyPayment: Double) throws -> Int {
        /// To find the minimum monthly payment
        let minMonthlyPayment = calculateMissingMonthlyPayment(interest: interest, principalAmount: principalAmount, terms: 1) - principalAmount
        
        if Int(monthlyPayment) <= Int(minMonthlyPayment) {
            throw calculationError.runtimeError("Invalid monthly payment")
        }
        
        let PMT = monthlyPayment
        let P = principalAmount
        let I = (interest / 100.0) / 12
        let D = PMT / I
        let N = (log(D / (D - P)) / log(1 + I))
        return Int(N)
    }
    
    /// To indicate runtime errors during the calculations
    enum calculationError: Error {
        case runtimeError(String)
    }
}
