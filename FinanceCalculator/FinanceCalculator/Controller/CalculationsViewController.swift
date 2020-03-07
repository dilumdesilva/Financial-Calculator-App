//
//  CalculationsViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 2/27/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class CalculationsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var calculations = [Calculation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateCalculations()
    }
    
    /// This function generates calculation types
    /// supported by the application
    ///
    /// Types of calculations
    ///     - Compound Savings
    ///     - Loans
    ///     - Mortgage
    func generateCalculations(){
        //let compundSavings = Calculation(name: "Compound Savings", icon:, )
    }
    
    //MARK: Protocol Stubs related to the calculations collection view
    
    ///Return - calculation count to be used to populate the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculations.count
    }
    
    ///Generate - calculation collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// Initializing a reusable sell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalculationViewCell
        
        /// Initializing cell content and assigning content source
        cell.ImgViewCalculationIcon.image = calculations[indexPath.row].getCalculationIcon()
        cell.LblCalculationName.text = calculations[indexPath.row].getCalculationName()
        
        /// Initializing cell styles 
        
        return cell
    }
    
    ///Function to be invoked when the user clicks an item in the collection view
    ///
    ///Usage:
    ///     performSegue() - this function has been used to navigate to the relevant page using the segueID
    ///         params:  Identifier.SegueID
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: calculations[indexPath.row].getSegueID(), sender: self)
    }
    
    
    
}
