//
//  CalculationsViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 2/27/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class CalculationsViewController: UIViewController{
    
    @IBOutlet weak var calculationsCollectionView: UICollectionView!
    
    
    var calculations = [Calculation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set Delegates
        //self.calculationsCollectionView.delegate = self
        self.calculationsCollectionView.dataSource = self
        
        //Register Cells
        self.calculationsCollectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        
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
        let compundSavings = Calculation(name: "Savings", icon: UIImage(named: "icon_savings")!, segueID: "goToSavingsCalculation", cellColour: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00))
        let loans = Calculation(name: "Loans", icon: UIImage(named: "icon_loan")!, segueID: "goToLoansCalculation", cellColour: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00))
        let mortgage = Calculation(name: "Mortgage", icon: UIImage(named: "icon_mortgage")!, segueID: "goToMortgageCalculation", cellColour: UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.00))
        
        calculations += [compundSavings, loans, mortgage]
    }
}


extension CalculationsViewController: UICollectionViewDataSource{
    //MARK: Protocol Stubs related to the calculations collection view
    
    ///Return - calculation count to be used to populate the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculations.count
    }
    
    ///Generate - calculation collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// Initializing a reusable sell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        /// Initializing cell content and assigning data source
        cell.setData(text: self.calculations[indexPath.row].getCalculationName(), icon: self.calculations[indexPath.row].getCalculationIcon())

        
        /// Initializing cell styles
        cell.contentView.backgroundColor = calculations[indexPath.row].getCellColour()
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00).cgColor
        cell.contentView.layer.masksToBounds = false
        
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


