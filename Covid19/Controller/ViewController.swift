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
    @IBOutlet weak var mainLabel: UILabel!
    
    var covidManager = CovidManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager.delegate = self
        covidManager.performSummaryRequest(countryName: nil)
    }
    
    @IBAction func refereshButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func searchButton(_ sender: Any) {
        covidManager.performSummaryRequest(countryName: self.searchBar.text)
    }
    
    
}
extension ViewController: CovidManagerDelegate{

//    //var covData: CovidData
    
    func didUpdateData(_ covidManager: CovidManager, data : CovidData, countryName: String?) {
        //self.covData = data
        DispatchQueue.main.async {
            self.showCountryData(data: data, countryName: countryName)
        }
    }
    
//    func onSearchButtonClick(){
//        DispatchQueue.main.async {
//            //self.showCountryData(data: self.covData, countryName: self.searchBar.text)
//        }
//    }
    
    func showCountryData(data : CovidData, countryName: String?){
        if (countryName != nil){
            for countryDetail in data.Countries{
                if(countryDetail.Country == countryName){
                    self.fillData(newConfirmed: String(countryDetail.NewConfirmed),
                                  totalConfirmed: String(countryDetail.TotalConfirmed),
                                  newDeaths: String(countryDetail.NewDeaths),
                                  totalDeaths: String(countryDetail.TotalDeaths),
                                  newRecovered: String(countryDetail.NewRecovered),
                                  totalRecovered: String(countryDetail.TotalRecovered))
                }
            }
        }
        else{
            self.fillData(newConfirmed: String(data.Global.NewConfirmed),
                          totalConfirmed: String(data.Global.TotalConfirmed),
                          newDeaths: String(data.Global.NewDeaths),
                          totalDeaths: String(data.Global.TotalDeaths),
                          newRecovered: String(data.Global.NewRecovered),
                          totalRecovered: String(data.Global.TotalRecovered))
        }
    }
    
    func fillData(newConfirmed: String,
                  totalConfirmed: String,
                  newDeaths: String,
                  totalDeaths: String,
                  newRecovered: String,
                  totalRecovered: String)
    {
        self.newConfirmedLbl.text = newConfirmed
        self.totalConfirmedLbl.text = totalConfirmed
        self.newDethLbl.text = newDeaths
        self.totalDethLbl.text = totalDeaths
        self.newRecoveredLbl.text = newRecovered
        self.totalRecoveredLbl.text = totalRecovered
    }
}



