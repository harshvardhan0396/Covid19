//
//  CovidData.swift
//  Covid19
//
//  Created by Harshvardhan Patidar on 07/04/20.
//  Copyright © 2020 Harshvardhan Patidar. All rights reserved.
//

import Foundation

struct CovidData: Decodable{
    var Global : GlobalModel
    //var Countries = [CountryModel]
}


struct GlobalModel: Decodable{
    var NewConfirmed: Int64
    var TotalConfirmed: Int64
    var NewDeaths: Int64
    var TotalDeaths: Int64
    var TotalRecovered: Int64
    var NewRecovered: Int64
}

struct CountryModel: Decodable{
    var Country: String
    var CountryCode: String
    var NewConfirmed: Int64
    var TotalConfirmed: Int64
    var NewDeaths: Int64
    var TotalDeaths: Int64
    var NewRecovered: Int64
    var TotalRecovered: Int64
    var Date: String
}


