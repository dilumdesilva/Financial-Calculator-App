//
//  UITextField_PlaceHolderColor.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 3/9/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

// MARK: - Extenstion to make the placeholder colors of UITextField to be matched for lighter background
extension UITextField {
    ///This functions sets the color recived as parameter to the placeholder
    func _darkPlaceHolderColor(_ color: UIColor){
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
}
