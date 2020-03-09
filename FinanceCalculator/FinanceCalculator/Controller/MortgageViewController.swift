//
//  MortgageViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/9/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

let MORTGAGE_USER_DEFAULTS_KEY = "mortgage"
private let MORTGAGE_USER_DEFAULTS_MAX_COUNT = 5

class MortgageViewController: UIViewController, CustomKeyboardDelegate {

    @IBOutlet weak var viewScroller: UIScrollView!
    @IBOutlet weak var outerStackView: UIStackView!
    @IBOutlet weak var outerStackViewTopConstaint: NSLayoutConstraint!
    @IBOutlet weak var mortgageLoanAmountTFStackView: UIStackView!
    @IBOutlet weak var loanAmountTextField: UITextField!
    @IBOutlet weak var mortgageInterestTFStackView: UIStackView!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var mortgagePaymentTFStackView: UIStackView!
    @IBOutlet weak var paymentTextField: UITextField!
    @IBOutlet weak var mortgageNoYearsTFStackView: UIStackView!
    @IBOutlet weak var numberOfYearsTextField: UITextField!
    
    @IBOutlet weak var btnCalculate: UIBarButtonItem!
    @IBOutlet weak var btnReset: UIBarButtonItem!
    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 10.0
    var textFieldToKeyBoardGap = 10
    var keyBoardHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide)))
        
        if validateTexFields() == 0 {
            self.btnReset.isEnabled = false
            self.btnCalculate.isEnabled = false
            self.btnSave.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ///setting text field styles
        loanAmountTextField._darkPlaceHolderColor(UIColor.darkText)
        loanAmountTextField.setAsNumericKeyboard(delegate: self)
        
        interestTextField._darkPlaceHolderColor(UIColor.darkText)
        interestTextField.setAsNumericKeyboard(delegate: self)
        
        paymentTextField._darkPlaceHolderColor(UIColor.darkText)
        paymentTextField.setAsNumericKeyboard(delegate: self)
        
        numberOfYearsTextField._darkPlaceHolderColor(UIColor.darkText)
        numberOfYearsTextField.setAsNumericKeyboard(delegate: self)
        
        ///Obser which tracks the keyboard show event
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    /// This will function will invoked by the ui tap gesture
    @objc func keyboardWillHide(){
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.outerStackViewTopConstaint.constant = self.outerStackViewTopConstraintDefaultHeight
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let firstResponder = self.findFirstResponder(inView: self.view)
        
        if firstResponder != nil{
            activeTextField = firstResponder as! UITextField;
            
            let activeTextFieldSuperView = activeTextField.superview!
            
            if let info = notification.userInfo{
                let keyboard:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
                let targetY = view.frame.size.height - keyboard.height - 15 - activeTextField.frame.size.height
                let initialY = outerStackView.frame.origin.y + activeTextFieldSuperView.frame.origin.y + activeTextField.frame.origin.y

                if initialY > targetY {
                    let diff = targetY - initialY
                    let targetOffsetForTopConstraint = outerStackViewTopConstaint.constant + diff
                    self.view.layoutIfNeeded()
                    
                    UIView.animate(withDuration: 0.25, animations: {
                        self.outerStackViewTopConstaint.constant = targetOffsetForTopConstraint
                        self.view.layoutIfNeeded()
                    })
                }
                
                var contentInset:UIEdgeInsets = self.viewScroller.contentInset
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
    
    
    @IBAction func performCalculation(_ sender: Any) {
        if validateTexFields() >= 3 {
            showAlert(message: "can perform", title: "performCalculation")
        }else {
            showAlert(message: "cant perform", title: "performCalculation")
        }
    }
    
    ///Function which is getting triggered once a textbox is changed
    @IBAction func mortgageTextFieldDidChange(_ sender: UITextField) {
        self.btnReset.isEnabled = true
        self.btnCalculate.isEnabled = true
//        var component: MortageCalculationComponent?
//
//        if sender.tag == 1 {
//            component = MortageCalculationComponent.loanAmount
//        } else if sender.tag == 2 {
//            component = MortageCalculationComponent.interestRate
//        } else if sender.tag == 3 {
//            component = MortageCalculationComponent.payment
//        } else if sender.tag == 4 {
//            component = MortageCalculationComponent.numberOfYears
//        }
    }
    
    @IBAction func resetMortageView(_ sender: Any) {
        resetTextFields()
    }
    
    func validateTexFields() -> Int{
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
        if !(numberOfYearsTextField.text?.isEmpty)! {
            counter += 1
        }
        
        return counter
    }
    
    func updateTextFeilds(){
        
    }
    
    /// Resetting the text feilds
    /// - Warning: This function needs to be changed when a new text field is added
    ///
    func resetTextFields(){
        if !isTextFieldEmpty(){
            loanAmountTextField.text = ""
            interestTextField.text = ""
            paymentTextField.text = ""
            numberOfYearsTextField.text = ""
        }
    }
    
    /// Resuable function to check whether the text feilds are empty
    /// - Warning: This function needs to be changed when a new text field is added
    ///
    /// Usage:
    ///     if isTextFieldsEmpty() // true | false
    ///
    func isTextFieldEmpty() -> Bool{
        if !(loanAmountTextField.text?.isEmpty)! && !(interestTextField.text?.isEmpty)! && !(paymentTextField.text?.isEmpty)! && !(numberOfYearsTextField.text?.isEmpty)!{
            return false
        }
        return true
    }
    
    
    func numericKeyPressed(key: Int) {
        print("")
    }
    
    func backspacePressed() {
        print("")
    }
    
    func symbolPressed(symbol: String) {
        print("")
    }
    
    func hideKeyboardPressed() {
        print("")
    }
    
}
