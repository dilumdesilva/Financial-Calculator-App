//
//  CalculationsViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 2/27/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class CalculationsViewController: UIViewController {
    @IBOutlet var calculationsCollectionView: UICollectionView!
    
    var calculations = [Calculation]()
    
    var estimateWidth = 160.0
    var cellMarginSize = 18.0
    
    override func viewDidLoad() {
        //setCustomNavigationBar
        setCustomNavBar()
        
        super.viewDidLoad()

        // set Delegates
        self.calculationsCollectionView.delegate = self
        self.calculationsCollectionView.dataSource = self
        
        // Register Cells
        self.calculationsCollectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        
        // Setup GridView
        self.setupGridView()
        
        //Generate Calculations
        self.generateCalculations()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupGridView()
        DispatchQueue.main.async {
            self.calculationsCollectionView.reloadData()
        }
    }
    
    func setCustomNavBar(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    
    func setupGridView() {
        let flow = calculationsCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
    }
    
    /// This function generates calculation types
    /// supported by the application
    ///
    /// Types of calculations
    ///     - Compound Savings
    ///     - Loans
    ///     - Mortgage
    func generateCalculations() {
        let compundSavings = Calculation(name: "Savings", icon: UIImage(named: "icon_savings")!, segueID: "goToSavingsCalculation", cellColour: UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1.00))
        let loans = Calculation(name: "Loan", icon: UIImage(named: "icon_loan")!, segueID: "goToLoansCalculation", cellColour: UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1.00))
        let mortgage = Calculation(name: "Mortgage", icon: UIImage(named: "icon_mortgage")!, segueID: "goToMortgageCalculation", cellColour: UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1.00))
        
        calculations += [compundSavings, loans, mortgage]
    }
}

// MARK: - Extenstions of protocol stubs related to the calculations collection view

extension CalculationsViewController: UICollectionViewDataSource {
    /// Return - calculation count to be used to populate the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.calculations.count
    }
    
    /// Generate - calculation collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// Initializing a reusable sell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        /// Initializing cell content and assigning data source
        cell.setData(text: self.calculations[indexPath.row].getCalculationName(), icon: self.calculations[indexPath.row].getCalculationIcon())
        
        /// Initializing cell styles
        cell.contentView.backgroundColor = self.calculations[indexPath.row].getCellColour()
        cell.contentView.layer.cornerRadius = 15.0
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.00).cgColor
        cell.contentView.layer.masksToBounds = false
        
        return cell
    }
    
    /// Function to be invoked when the user clicks an item in the collection view
    ///
    /// Usage:
    ///     performSegue() - this function has been used to navigate to the relevant page using the segueID
    ///         params:  Identifier.SegueID
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: self.calculations[indexPath.row].getSegueID(), sender: self)
    }
}

extension CalculationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.calculateWidth()
        return CGSize(width: width, height: width)
    }
    
    func calculateWidth() -> CGFloat {
        let estimatedWidth = CGFloat(estimateWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width / estimatedWidth))
        
        let margin = CGFloat(cellMarginSize * 2)
        let width = (self.view.frame.size.width - CGFloat(self.cellMarginSize) * (cellCount - 1) - margin) / cellCount
        
        return width
    }
}
