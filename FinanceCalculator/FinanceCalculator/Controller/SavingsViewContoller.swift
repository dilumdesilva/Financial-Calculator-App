//
//  SavingsViewContoller.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/10/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

let SAVINGS_WRC_USER_DEFAULTS_KEY = "savingswrc"
let SAVINGS_WORC_USER_DEFAULTS_KEY = "savingsworc"

private let SAVINGS_WOR_USER_DEFAULTS_MAX_COUNT = 4
private let SAVINGS_WR_USER_DEFAULTS_MAX_COUNT = 5

class SavingsViewController: UIViewController, CustomKeyboardDelegate {
    @IBOutlet var viewScroller: UIScrollView!
    @IBOutlet var outerStackView: UIStackView!
    @IBOutlet var outerStackViewTopConstaint: NSLayoutConstraint!
    @IBOutlet var segmentedController: UISegmentedControl!
    
    @IBOutlet var presentValuleTextField: UITextField!
    @IBOutlet var interestTextField: UITextField!
    @IBOutlet var compoundsPerYearTextField: UITextField!
    @IBOutlet var futureValueTextField: UITextField!
    @IBOutlet var numberOfYearsTextField: UITextField!
    @IBOutlet var paymentValueTextField: UITextField!
    @IBOutlet var paymentValueStackView: UIStackView!
    @IBOutlet var paymentValueLabel: UILabel!
    
    @IBOutlet var btnReset: UIBarButtonItem!
    @IBOutlet var btnCalculate: UIBarButtonItem!
    @IBOutlet var btnSave: UIBarButtonItem!
    
    /// Payment Time --> End of the month by default
    @IBOutlet var paymentTimeLabel: UILabel!
    @IBOutlet var paymentTimeSwitch: UISwitch!
    var paymentTimeIsBeginning = false
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 10.0
    var textFieldToKeyBoardGap = 10
    var keyBoardHeight: CGFloat = 0
    var isSavingsWithRContributionSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide)))
        
        if segmentedController.selectedSegmentIndex == 0 {
            withoutRContributionViewSelected()
        } else {
            withRContributionViewSelected()
        }
        
        if validateTexFields() == 0 {
            btnReset.isEnabled = false
            btnCalculate.isEnabled = false
            btnSave.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// setting custom numeric keyboard
        setCustomNumericKeyboard()
    }
    
    /// Setting custom keyboard as the keyboard for all the text fields
    func setCustomNumericKeyboard() {
        presentValuleTextField.setAsNumericKeyboard(delegate: self)
        interestTextField.setAsNumericKeyboard(delegate: self)
        compoundsPerYearTextField.setAsNumericKeyboard(delegate: self)
        futureValueTextField.setAsNumericKeyboard(delegate: self)
        numberOfYearsTextField.setAsNumericKeyboard(delegate: self)
        paymentValueTextField.setAsNumericKeyboard(delegate: self)
        
        /// Obser which tracks the keyboard show event
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @IBAction func handleSegmentedControllerChanged(_ sender: UISegmentedControl) {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            withoutRContributionViewSelected()
            resetTextFields()
        case 1:
            withRContributionViewSelected()
            resetTextFields()
        default:
            break
        }
    }
    
    func withoutRContributionViewSelected() {
        isSavingsWithRContributionSelected = false
        paymentValueStackView.isHidden = true
    }
    
    func withRContributionViewSelected() {
        isSavingsWithRContributionSelected = true
        paymentTimeSwitch.isOn = false
        paymentValueStackView.isHidden = false
    }
    
    @IBAction func paymentTimeChanged(_ sender: UISwitch) {
        if paymentTimeSwitch.isOn == false {
            paymentTimeLabel.text = "End of Month"
            paymentTimeIsBeginning = false
        } else {
            paymentTimeLabel.text = "Begining of Month"
            paymentTimeIsBeginning = true
        }
    }
    
    
    @IBAction func resetSavingsView(_ sender: Any) {
        resetTextFields()
    }
    
    @IBAction func performSavingsCalculations(_ sender: UIBarButtonItem) {
        calculateMissingComponent()
    }
    
    
    @IBAction func saveSavingsCalculations(_ sender: UIBarButtonItem) {
        
    }
    
    
    func calculateMissingComponent() {
        let presentVal = Double(presentValuleTextField.text!)
        let interest = Double(interestTextField.text!)
        let compoundsPY = 12.0
        let futureVal = Double(futureValueTextField.text!)
        let numOfYears = Double(numberOfYearsTextField.text!)
        let paymentVal = Double(paymentValueTextField.text!)
        var missingValue = 0.0
        /// Perform calculation for without regular contibtions
        if isSavingsWithRContributionSelected == false {
            if (presentValuleTextField.text?.isEmpty)! {
                missingValue = findMissingWithoutRCPresentValue(interest: interest!, compoundsPerYear: compoundsPY, futureValue: futureVal!, noOfYears: numOfYears!)
                presentValuleTextField.text = String(missingValue)
            }
            if (interestTextField.text?.isEmpty)! {
                missingValue = findMissingWithoutRCInterest(presentValue: presentVal!, compoundsPerYear: compoundsPY, futureValue: futureVal!, noOfYears: numOfYears!)
                interestTextField.text = String(missingValue)
            }
            if (futureValueTextField.text?.isEmpty)! {
                missingValue = findMissingWithoutRCFutureValue(presentValue: presentVal!, interest: interest!, compoundsPerYear: compoundsPY, noOfYears: numOfYears!)
                futureValueTextField.text = String(missingValue)
            }
            if (numberOfYearsTextField.text?.isEmpty)! {
                missingValue = findMissingWithoutRCNumberOfPayments(presentValue: presentVal!, interest: interest!, compoundsPerYear: compoundsPY, futureValue: futureVal!)
                numberOfYearsTextField.text = String(missingValue)
            }
        }
        /// Perform calculations for with regualr contributions
        if isSavingsWithRContributionSelected == true {
            if (presentValuleTextField.text?.isEmpty)! {
                missingValue = findMissingWithRCPresentValue(paymentTimeIsBeginning: paymentTimeIsBeginning, interest: interest!, compoundsPerYear: compoundsPY, futureValue: futureVal!, noOfYears: numOfYears!, paymentValue: paymentVal!)
                presentValuleTextField.text = String(missingValue)
            }
            if (interestTextField.text?.isEmpty)! {
                showAlert(message: "Currently unable to calulate interest for compound savings with regular contributions", title: "Unsupported Operation")
                interestTextField.text = String(missingValue)
            }
            if (futureValueTextField.text?.isEmpty)! {
                missingValue = findMissingFutureValue(paymentTimeIsBeginning: paymentTimeIsBeginning, presentValue: presentVal!, interest: interest!, compoundsPerYear: compoundsPY, noOfYears: numOfYears!, paymentValue: paymentVal!)
                futureValueTextField.text = String(missingValue)
            }
            if (numberOfYearsTextField.text?.isEmpty)! {
                missingValue = findMissingWithRCNumberOfYears(paymentTimeIsBeginning: paymentTimeIsBeginning, presentValue: presentVal!, interest: interest!, compoundsPerYear: compoundsPY, futureValue: futureVal!, paymentValue: paymentVal!)
                numberOfYearsTextField.text = String(missingValue)
            }
            if (paymentValueTextField.text?.isEmpty)! {
                missingValue = findMissingWithRCPaymentValue(paymentTimeIsBeginning: paymentTimeIsBeginning, presentValue: presentVal!, interest: interest!, compoundsPerYear: compoundsPY, futureValue: futureVal!, noOfYears: numOfYears!)
                paymentValueTextField.text = String(missingValue)
            }
        }
    }
    
    /// This will function will invoked by the ui tap gesture
    @objc func keyboardWillHide() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.outerStackViewTopConstaint.constant = self.outerStackViewTopConstraintDefaultHeight
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let firstResponder = findFirstResponder(inView: view)
        
        if firstResponder != nil {
            activeTextField = firstResponder as! UITextField
            
            let activeTextFieldSuperView = activeTextField.superview!
            
            if let info = notification.userInfo {
                let keyboard: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
                let targetY = view.frame.size.height - keyboard.height - 15 - activeTextField.frame.size.height
                let initialY = outerStackView.frame.origin.y + activeTextFieldSuperView.frame.origin.y + activeTextField.frame.origin.y
                
                if initialY > targetY {
                    let diff = targetY - initialY
                    let targetOffsetForTopConstraint = outerStackViewTopConstaint.constant + diff
                    view.layoutIfNeeded()
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        self.outerStackViewTopConstaint.constant = targetOffsetForTopConstraint
                        self.view.layoutIfNeeded()
                    })
                }
                
                var contentInset: UIEdgeInsets = viewScroller.contentInset
                contentInset.bottom = keyboard.size.height
                viewScroller.contentInset = contentInset
            }
        }
    }
    
    func findFirstResponder(inView view: UIView) -> UIView? {
        for subView in view.subviews {
            if subView.isFirstResponder {
                return subView
            }
            
            if let recursiveSubView = self.findFirstResponder(inView: subView) {
                return recursiveSubView
            }
        }
        
        return nil
    }
    
    func validateTexFields() -> Int {
        var counter = 0
        if isSavingsWithRContributionSelected == false {
            if !(presentValuleTextField.text?.isEmpty)! { counter += 1 }
            if !(interestTextField.text?.isEmpty)! { counter += 1 }
            if !(compoundsPerYearTextField.text?.isEmpty)! { counter += 1 }
            if !(futureValueTextField.text?.isEmpty)! { counter += 1 }
            if !(numberOfYearsTextField?.text?.isEmpty)! { counter += 1 }
        } else {
            if !(presentValuleTextField.text?.isEmpty)! { counter += 1 }
            if !(interestTextField.text?.isEmpty)! { counter += 1 }
            if !(compoundsPerYearTextField.text?.isEmpty)! { counter += 1 }
            if !(futureValueTextField.text?.isEmpty)! { counter += 1 }
            if !(numberOfYearsTextField?.text?.isEmpty)! { counter += 1 }
            if !(paymentValueTextField?.text?.isEmpty)! { counter += 1 }
        }
        return counter
    }
    
    func isTextFieldEmpty() -> Bool {
        /// Checking whether text fields are not empty in the
        /// savings without regular contributions view
        if isSavingsWithRContributionSelected == false {
            if !(paymentValueTextField.text?.isEmpty)!,
                !(interestTextField.text?.isEmpty)!,
                !(compoundsPerYearTextField.text?.isEmpty)!,
                !(futureValueTextField.text?.isEmpty)!,
                !(numberOfYearsTextField.text?.isEmpty)!
            { return false }
        }
        /// Checking whether text fields are not empty in the
        /// savings with regular contributions view
        if !isSavingsWithRContributionSelected {
            if !(paymentValueTextField.text?.isEmpty)!,
                !(interestTextField.text?.isEmpty)!,
                !(compoundsPerYearTextField.text?.isEmpty)!,
                !(futureValueTextField.text?.isEmpty)!,
                !(numberOfYearsTextField.text?.isEmpty)!,
                !(paymentValueTextField.text?.isEmpty)!
            { return false }
        }
        
        return true
    }
    
    @IBAction func savingsTextFieldDidChange(_ sender: UITextField) {
        btnReset.isEnabled = true
        btnCalculate.isEnabled = true
    }
    
    func resetTextFields() {
        presentValuleTextField.text = ""
        interestTextField.text = ""
        compoundsPerYearTextField.text = ""
        futureValueTextField.text = ""
        numberOfYearsTextField.text = ""
        paymentValueTextField.text = ""
        
        /// reset payementTime switch and label
        if isSavingsWithRContributionSelected == true {
            paymentTimeSwitch.isOn = false
            paymentTimeLabel.text = "End of Month"
        }
    }
    
    func numericKeyPressed(key: Int) {
        print("Numeric key \(key) pressed!")
    }
    
    func backspacePressed() {
        print("Backspace pressed!")
    }
    
    func symbolPressed(symbol: String) {
        print("Symbol \(symbol) pressed!")
    }
    
    func hideKeyboardPressed() {
        keyboardWillHide()
    }
}
