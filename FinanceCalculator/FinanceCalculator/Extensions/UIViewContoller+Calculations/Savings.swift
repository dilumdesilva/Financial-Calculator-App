//
//  CompoundInterestSavings.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/7/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    //MARK: - Calculations related to the savings without regular contributions
    func findMissingWithoutRCPresentValue(interest: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {

        let FV = Double(futureValue)
        let I = Double(interest) / 100
        let N = Double(noOfYears)
        let CPY = Double(compoundsPerYear)
        let PV = Double(FV / pow(1 + (I / CPY), CPY * N))

        return PV.toFixed(2)

    }

    func findMissingWithoutRCFutureValue(presentValue: Double, interest: Double, compoundsPerYear: Double, noOfYears: Double) -> Double {

        let PV = Double(presentValue)
        let I = Double(interest) / 100
        let N = Double(noOfYears)
        let CPY = Double(compoundsPerYear)
        let FV = Double(PV * (pow((1 + I / CPY), CPY * N)))

       return FV.toFixed(2)

    }

    func findMissingWithoutRCNumberOfPayments(presentValue: Double, interest: Double, compoundsPerYear: Double, futureValue: Double) -> Double {

        let PV = Double(presentValue)
        let FV = Double(futureValue)
        let I = Double(interest) / 100
        let CPY = Double(compoundsPerYear)
        let N = Double(log(FV / PV) / (CPY * log(1 + (I / CPY))))

        return N.toFixed(2)

    }

    func findMissingWithoutRCInterest(presentValue: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {

        let PV = Double(presentValue)
        let FV = Double(futureValue)
        let CPY = Double(compoundsPerYear)
        let N = Double(noOfYears)
        let I = Double(CPY * (pow(FV / PV, (1 / (CPY * N))) - 1))

        return (I * 100).toFixed(2)

    }
    
    //MARK: - Calculations related to the savings with regular contributions
    
    func findMissingWithRCPresentValue(paymentTimeIsBeginning: Bool, interest: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double, paymentValue: Double) -> Double {
        
        let FV = Double(futureValue)
        let PMT = Double(paymentValue)
        let I = Double(interest) / 100
        let CPY = Double(compoundsPerYear)
        let N = Double(noOfYears)
        
        var PV: Double
        
        if paymentTimeIsBeginning {
            PV = (FV - (PMT * (pow((1 + I / CPY), CPY * N) - 1) / (I / CPY)) * (1 + I / CPY)) / pow((1 + I / CPY), CPY * N)
        } else {
            PV = (FV - (PMT * (pow((1 + I / CPY), CPY * N) - 1) / (I / CPY))) / pow((1 + I / CPY), CPY * N)
        }
        
        return PV.toFixed(2)
        
    }

    func findMissingWithRCPaymentValue(paymentTimeIsBeginning: Bool, presentValue: Double, interest: Double, compoundsPerYear: Double, futureValue: Double, noOfYears: Double) -> Double {

        let FV = Double(futureValue)
        let PV = Double(presentValue)
        let I = Double(interest) / 100
        let CPY = Double(compoundsPerYear)
        let N = Double(noOfYears)

        var PMT: Double

        if paymentTimeIsBeginning {
            PMT = Double((FV - (PV * pow((1 + I / CPY), CPY * N))) / ((pow((1 + I / CPY), CPY * N) - 1) / (I / CPY)))
        } else {
            PMT = Double((FV - (PV * pow((1 + I / CPY), CPY * N))) / ((pow((1 + I / CPY), CPY * N) - 1) / (I / CPY)) / (1 + I / CPY))
        }

        return PMT.toFixed(2)

    }

    func findMissingFutureValue(paymentTimeIsBeginning: Bool, presentValue: Double, interest: Double, compoundsPerYear: Double, noOfYears: Double, paymentValue: Double) -> Double {

        let PMT = Double(paymentValue)
        let I = Double(interest) / 100
        let PV = Double(presentValue)
        let CPY = Double(compoundsPerYear)
        let N = Double(noOfYears)

        var FV: Double = 0

        if paymentTimeIsBeginning {
            FV = PV * pow((1 + I / CPY), CPY * N) + (PMT * (pow((1 + I / CPY), CPY * N) - 1) / (I / CPY)) * (1 + I / CPY)
        } else {
            FV = PV * pow((1 + I / CPY), CPY * N) + (PMT * (pow((1 + I / CPY), CPY * N) - 1) / (I / CPY))
        }

        return FV.toFixed(2)

    }

    func findMissingWithRCNumberOfYears(paymentTimeIsBeginning: Bool, presentValue: Double, interest: Double, compoundsPerYear: Double, futureValue: Double, paymentValue: Double) -> Double {

        let FV = Double(futureValue)
        let PV = Double(presentValue)
        let PMT = Double(paymentValue)
        let I = Double(interest) / 100
        let CPY = Double(compoundsPerYear)

        var N: Double = 0;

        if paymentTimeIsBeginning {
            N = ((log(FV + PMT + ((PMT * CPY) / I)) - log(PV + PMT + ((PMT * CPY) / I))) / (CPY * log(1 + (I / CPY))))
        } else {
            N = Double((log(FV + ((PMT * CPY) / I)) - log(((I * PV) + (PMT * CPY)) / I)) / (CPY * log(1 + (I / CPY))))
        }

        if N.isNaN || N.isInfinite {
            return 0.0
        } else {
            return N.toFixed(2)
        }

    }
}
