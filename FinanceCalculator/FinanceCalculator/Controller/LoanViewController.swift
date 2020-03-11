//
//  LoanViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/10/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

let LOAN_USER_DEFAULTS_KEY = "loan"
private let LOAN_USER_DEFAULTS_MAX_COUNT = 5

class loanViewController: UIViewController, CustomKeyboardDelegate {
    @IBOutlet var viewScroller: UIScrollView!
    @IBOutlet var outerStackView: UIStackView!
    @IBOutlet var outerStackViewTopConstaint: NSLayoutConstraint!
    
    @IBOutlet var loanVCLoanAmountTFStackView: UIStackView!
    @IBOutlet var loanAmountTextField: UITextField!
    
    @IBOutlet var loanVCInterestTFStackView: UIStackView!
    @IBOutlet var interestTextField: UITextField!
    
    @IBOutlet var loanVCPaymentTFStackView: UIStackView!
    @IBOutlet var paymentTextField: UITextField!
    
    @IBOutlet var loanVCNumberOfPaymentsTFStackView: UIStackView!
    @IBOutlet var numberOfPayments: UITextField!
    
    @IBOutlet var btnReset: UIBarButtonItem!
    @IBOutlet var btnCalculate: UIBarButtonItem!
    @IBOutlet var btnSave: UIBarButtonItem!
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 10.0
    var textFieldToKeyBoardGap = 10
    var keyBoardHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide)))
        
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
        loanAmountTextField.setAsNumericKeyboard(delegate: self)
        interestTextField.setAsNumericKeyboard(delegate: self)
        paymentTextField.setAsNumericKeyboard(delegate: self)
        numberOfPayments.setAsNumericKeyboard(delegate: self)
        
        /// Obser which tracks the keyboard show event
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func validateTexFields() -> Int {
        var counter = 0
        if !(loanAmountTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(interestTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(paymentTextField.text?.isEmpty)! {
            counter += 1
        }
        if !(numberOfPayments.text?.isEmpty)! {
            counter += 1
        }
        
        return counter
    }
    
    /// Resetting the text feilds
    /// - Warning: This function needs to be changed when a new text field is added
    ///
    func resetTextFields() {
        loanAmountTextField.text = ""
        interestTextField.text = ""
        paymentTextField.text = ""
        numberOfPayments.text = ""
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
    
    /// This will function will invoked by the ui tap gesture
    @objc func keyboardWillHide() {
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.outerStackViewTopConstaint.constant = self.outerStackViewTopConstraintDefaultHeight
            self.view.layoutIfNeeded()
        })
    }
    
    func calculateMissingComponent() {
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
        let P = Double(loanAmountTextField.text!)
        let R = Double(interestTextField.text!)
        let PMT = Double(paymentTextField.text!)
        let N = Double(numberOfPayments.text!)
        
        /// Identify missing component and Perform relavant calculation
        var missingValue = 0.0
        if (loanAmountTextField.text?.isEmpty)! {
            missingValue = missingLoanPrincipalAmount(interest: R!, monthlyPayment: PMT!, terms: N!)
            loanAmountTextField.text = String(missingValue)
        }
        if (interestTextField.text?.isEmpty)! {
            missingValue = missingLoanInterestRate(principalAmount: P!, monthlyPayment: PMT!, terms: N!)
            interestTextField.text = String(missingValue)
        }
        if (paymentTextField.text?.isEmpty)! {
            missingValue = missingLoanMonthlyPayment(interest: R!, principalAmount: P!, terms: N!)
            paymentTextField.text = String(missingValue)
        }
        if (numberOfPayments.text?.isEmpty)! {
            do {
                try missingValue = Double(missingLoanPaymentTerms(interest: R!, principalAmount: P!, monthlyPayment: PMT!))
            } catch let err {
                print(err)
            }
            numberOfPayments.text = String(missingValue)
        }
    }
    
    @IBAction func resetLoanView(_ sender: UIBarButtonItem) {
        resetTextFields()
    }
    
    @IBAction func performCalculation(_ sender: Any) {
        if validateTexFields() == 3 {
            /// calculate Missing Component
            calculateMissingComponent()
            btnSave.isEnabled = true
            
        } else if validateTexFields() == 4 {
            showAlert(message: "Invalid Calculation. You must leave one field to proceed with a calculation", title: "Loan Calculation Warning")
        } else {
            showAlert(message: "Please fill at least three fields to perform a calculation", title: "Loan Calculation Warning")
        }
    }
    
    @IBAction func saveCalculation(_ sender: Any) {
        ///
        /// P           -    loanAmount
        /// R           -    interest rate
        /// PMT      -    Payment
        /// N           -    Number of Terms in months
        ///
        if validateTexFields() == 4 {
            let calculation = "P = \(loanAmountTextField.text!),  R = \(interestTextField.text!),\nPMT = \(paymentTextField.text!),  N = \(numberOfPayments.text!)"
            
            var arr = UserDefaults.standard.array(forKey: LOAN_USER_DEFAULTS_KEY) as? [String] ?? []
            
            if arr.count >= LOAN_USER_DEFAULTS_MAX_COUNT {
                arr = Array(arr.suffix(LOAN_USER_DEFAULTS_MAX_COUNT - 1))
            }
            
            arr.append(calculation)
            UserDefaults.standard.set(arr, forKey: LOAN_USER_DEFAULTS_KEY)
            
            showAlert(message: "You Loan Calculation has been saved check history section for saved data", title: "Saved Successfully")
            
        } else {
            showAlert(message: "You are trying to save an empty conversion!", title: "Loan Calculation Saving Error")
        }
    }
    
    @IBAction func loanTextFieldDidChange(_ sender: UITextField) {
        btnReset.isEnabled = true
        btnCalculate.isEnabled = true
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
