//
//  UITextField+CustomKeyboard.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/9/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

private var numericKeyboardDelegate: CustomKeyboardDelegate?

extension UITextField: CustomKeyboardDelegate {
    func setAsNumericKeyboard(delegate: CustomKeyboardDelegate?) {
        let numericKeyboard = CustomKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: customKeyboardHeight))
        self.inputView = numericKeyboard
        numericKeyboardDelegate = delegate
        numericKeyboard.delegate = self
    }
    
    func unsetAsNumericKeyboard() {
        if let numericKeyboard = self.inputView as? CustomKeyboard {
            numericKeyboard.delegate = nil
        }
        self.inputView = nil
        numericKeyboardDelegate = nil
    }
    
    internal func numericKeyPressed(key: Int) {
        self.insertText(String(key))
        numericKeyboardDelegate?.numericKeyPressed(key: key)
    }
    
    internal func backspacePressed() {
        self.deleteBackward()
        numericKeyboardDelegate?.backspacePressed()
    }
    
    internal func symbolPressed(symbol: String) {
        self.insertText(String(symbol))
        numericKeyboardDelegate?.symbolPressed(symbol: symbol)
    }
    
    internal func hideKeyboardPressed() {
        numericKeyboardDelegate?.hideKeyboardPressed()
    }
}
