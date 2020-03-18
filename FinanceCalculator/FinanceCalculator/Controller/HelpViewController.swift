//
//  HelpViewController.swift
//  FinanceCalculator
//
//  Created by Dilum De Silva on 2/27/20.
//  Copyright © 2020 Dilum De Silva. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    

    @IBOutlet weak var helpCollectionView: UICollectionView!
    var helpCards = HelpViewCards.fetchCardData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helpCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension HelpViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HelpCollectionViewCell", for: indexPath) as! HelpCollectionViewCell
        
        let helpViewCard = helpCards[indexPath.item]
        cell.helpViewCards = helpViewCard
        
        return cell
    }
    
    
}
