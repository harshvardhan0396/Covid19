//
//  CovidModel.swift
//  Covid19
//
//  Created by Harshvardhan Patidar on 07/04/20.
//  Copyright © 2020 Harshvardhan Patidar. All rights reserved.
//

import Foundation


protocol CovidManagerDelegate{
    func didUpdateData(_ covidData: CovidManager, data: CovidModel)
}


struct CovidManager{
    
    var delegate: CovidManagerDelegate?
    
    func performSummaryRequest(){
        let covidAPIURL = URL(string: "https://api.covid19api.com/summary")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: covidAPIURL! ) { (data, response, error) in
            if error != nil{
                print(error!)
            }
            if let safeData = data{
                if let data = self.parseJSON(safeData){
                    self.delegate?.didUpdateData(self, data: data)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ covidData: Data) -> CovidModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CovidData.self, from: covidData)
            let nC = decodedData.Global.NewConfirmed
            let tC = decodedData.Global.TotalConfirmed
            let nD = decodedData.Global.NewDeaths
            let tD = decodedData.Global.TotalDeaths
            let nR = decodedData.Global.NewRecovered
            let tR = decodedData.Global.TotalRecovered
            
            let data = CovidModel(newConfirmed: nC, totalConfirmed: tC, newDeaths: nD, totalDeaths: tD, newRecovered: nR, totalRecovered: tR)
            return data
        
        }
        catch{
            print(error)
            return nil
        }
        
    }
}
