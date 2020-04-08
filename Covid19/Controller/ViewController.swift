//
//  ViewController.swift
//  Covid19
//
//  Created by Harshvardhan Patidar on 07/04/20.
//  Copyright © 2020 Harshvardhan Patidar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var newConfirmedLbl: UILabel!
    @IBOutlet weak var totalConfirmedLbl: UILabel!
    @IBOutlet weak var newDethLbl: UILabel!
    @IBOutlet weak var totalDethLbl: UILabel!
    @IBOutlet weak var newRecoveredLbl: UILabel!
    @IBOutlet weak var totalRecoveredLbl: UILabel!
    
    
    var covidManager = CovidManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager.delegate = self
        covidManager.performSummaryRequest()
    }
    
    @IBAction func refereshButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func searchButton(_ sender: Any) {
    
        print(searchBar.text!)
    
    }
}
extension ViewController: CovidManagerDelegate{
    func didUpdateData(_ covidManager: CovidManager, data : CovidModel) {
        DispatchQueue.main.async {
            self.newConfirmedLbl.text = String(data.newConfirmed)
            self.newConfirmedLbl.text = String(data.newConfirmed)
            self.totalConfirmedLbl.text = String(data.totalConfirmed)
            self.newDethLbl.text = String(data.newDeaths)
            self.totalDethLbl.text = String(data.totalDeaths)
            self.newRecoveredLbl.text = String(data.newRecovered)
            self.totalRecoveredLbl.text = String(data.totalRecovered)
        }

    }
}



