//
//  TabBarController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 2/27/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITabBarController subclass to handle its methods
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is UINavigationController{
            print("Current app view: Calculations Tab")
        } else if viewController is HistoryViewController{
            print("Current app view: History Tab")
        } else if viewController is HelpViewController{
            print("Current app view: Help Tab")
        }
    }
}
