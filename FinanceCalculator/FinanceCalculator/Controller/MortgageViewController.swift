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

class MortgageViewController: UIViewController {
    
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
    
    
    var activeTextField = UITextField()
    var outerStackViewTopConstraintDefaultHeight: CGFloat = 17.0
    var textFieldToKeyBoardGap = 20
    var keyBoardHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide)))
        
        if isTextFieldEmpty(){
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ///setting text field styles
        loanAmountTextField._darkPlaceHolderColor(UIColor.darkText)
    }
    
    /// This will function will invoked by the ui tap gesture
    @objc func keyboardWillHide(){
        view.endEditing(true)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.outerStackViewTopConstaint.constant = self.outerStackViewTopConstraintDefaultHeight
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func resetMortageView(_ sender: Any) {
        resetTextFields()
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
    
}

//extension MortgageViewController: CustomKeyboardDelegate{
//    func numericKeyPressed(key: Int) {
//        <#code#>
//    }
//
//    func backspacePressed() {
//        <#code#>
//    }
//
//    func symbolPressed(symbol: String) {
//        <#code#>
//    }
//
//    func hideKeyboardPressed() {
//        <#code#>
//    }
//
//
//}
