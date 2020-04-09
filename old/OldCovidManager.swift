////
////  CovidManager.swift
////  Covid19
////
////  Created by Harshvardhan Patidar on 07/04/20.
////  Copyright © 2020 Harshvardhan Patidar. All rights reserved.
////
//
//import Foundation
//
//
//protocol CovidManagerDelegate{
//    func didUpdateData(_ covidData: CovidManager, data: CovidModel)
//}
//
//
//struct CovidManager{
//    
//    var delegate: CovidManagerDelegate?
//    
//    func performSummaryRequest(){
//        let covidAPIURL = URL(string: "https://api.covid19api.com/summary")
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: covidAPIURL! ) { (data, response, error) in
//            if error != nil{
//                print(error!)
//            }
//            if let safeData = data{
//                if let data = self.parseJSON(safeData){
//                    self.delegate?.didUpdateData(self, data: data)
//                }
//            }
//        }
//        task.resume()
//    }
//    
//    func parseJSON(_ covidData: Data) -> CovidModel?{
//        let decoder = JSONDecoder()
//        do{
//            let covidData = try decoder.decode(CovidData.self, from: covidData)
//            var covidModel: CovidModel
//            
//            covidModel.Global.NewConfirmed = covidData.Global.NewConfirmed
//            covidModel.Global.NewRecovered = covidData.Global.NewRecovered
//            covidModel.Global.NewDeaths = covidData.Global.NewDeaths
//            covidModel.Global.TotalConfirmed = covidData.Global.TotalConfirmed
//            covidModel.Global.TotalRecovered = covidData.Global.TotalRecovered
//            covidModel.Global.TotalDeaths = covidData.Global.TotalDeaths
//            
//            return covidModel
//            
//        }
//        catch{
//            print(error)
//            return nil
//        }
//        
//    }
//}
