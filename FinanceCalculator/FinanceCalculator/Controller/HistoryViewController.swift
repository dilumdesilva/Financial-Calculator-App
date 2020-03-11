//
//  HistoryViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 2/27/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnClearHistory: UIBarButtonItem!
    
    var histories = [History]()
    var calculationType = MORTGAGE_USER_DEFAULTS_KEY
    var icon: UIImage = UIImage(named: "icon_s_loan")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /// generate the history of the initial segement
        recallHistory(type: calculationType, icon: icon)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        /// Handle history clear button visibility
        toggleClearHistoryVisibility()
    }
    
    @IBAction func handleSegmentedControllerChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            calculationType = SAVINGS_WORC_USER_DEFAULTS_KEY
            icon = UIImage(named: "icon_s_savings")!
        case 1:
            calculationType = SAVINGS_WORC_USER_DEFAULTS_KEY
            icon = UIImage(named: "icon_s_savings")!
        case 2:
            calculationType = LOAN_USER_DEFAULTS_KEY
            icon = UIImage(named: "icon_s_loan")!
        case 3:
            calculationType = MORTGAGE_USER_DEFAULTS_KEY
            icon = UIImage(named: "icon_s_mortgage")!
        default:
            break
        }
        
        recallHistory(type: calculationType, icon: icon)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        toggleClearHistoryVisibility()
    }
    
    func recallHistory(type: String, icon: UIImage) {
        histories = []
        let historyList = UserDefaults.standard.value(forKey: calculationType) as? [String]
        
        if historyList?.count ?? 0 > 0 {
            for calculation in historyList! {
                let history = History(type: type, icon: icon, calculation: calculation)
                histories += [history]
            }
        }
    }
    
    /// This function handles the visibity of the history clear button
    ///
    func toggleClearHistoryVisibility() {
        if histories.count > 0 {
            btnClearHistory.isEnabled = true
        } else {
            btnClearHistory.isEnabled = false
        }
    }
    
    /// This function handles the clear history action
    /// If saved history available this function will clear them when user click on the clear button
    @IBAction func performClearHistory(_ sender: Any) {
        if histories.count > 0 {
            UserDefaults.standard.set([], forKey: calculationType)
            
            showAlert(message: "The saved calculations were successfully deleted!", title: "User History Cleared")
            
            recallHistory(type: calculationType, icon: icon)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            toggleClearHistoryVisibility()
        }
    }
    
    /// This function sets the number of sections in table view.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if histories.count == 0 {
            self.tableView.setTableEmptyMessage("No previous calculation found", UIColor.darkGray)
        } else {
            self.tableView.restore()
        }
        
        return histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HistoryTableViewCell
        cell.lblCalculationHistory.lineBreakMode = .byWordWrapping
        cell.lblCalculationHistory.numberOfLines = 3
        cell.lblCalculationHistory.text = String(histories[indexPath.row].getHistoryCalculation())
        cell.imgVHistoryTypeIcon.image = histories[indexPath.row].getHistoryIcon()
        
        // Card(cell) styles
        cell.isUserInteractionEnabled = false
        cell.contentView.backgroundColor = UIColor(red: 30 / 255, green: 30 / 255, blue: 30 / 255, alpha: 1.00)
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00).cgColor
        cell.contentView.layer.masksToBounds = false
        
        return cell
    }
}
