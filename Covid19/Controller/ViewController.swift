//
//  ViewController.swift
//  Covid19
//
//  Created by Harshvardhan Patidar on 07/04/20.
//  Copyright © 2020 Harshvardhan Patidar. All rights reserved.
//

//https://github.com/appbrewery/Clima-iOS13-Completed/blob/master/Clima/Controller/WeatherViewController.swift
//https://github.com/appbrewery/Todoey-Realm-iOS13-Completed/blob/master/Todoey/Controllers/TodoListViewController.swift
//https://www.udemy.com/course/ios-13-app-development-bootcamp/learn/lecture/10929418#overview

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var newConfirmedLbl: UILabel!
    @IBOutlet weak var totalConfirmedLbl: UILabel!
    
    @IBOutlet weak var newDeathsLbl: UILabel!
    
    @IBOutlet weak var totalDeathsLbl: UILabel!
    @IBOutlet weak var newRecoveredLbl: UILabel!
    @IBOutlet weak var totalRecoveredLbl: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    
    var covidManager = CovidManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidManager.delegate = self
        notificationCenter.delegate = self
        covidManager.performSummaryRequest(countryName: nil)
        
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
        
        }
        userNotification()
    }
    
    func userNotification(){
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "Covid Notification"
        content.title = "Covid-19"
        content.body = "Stay Home Stay Safe"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        //Attaching Image
        
        let url = Bundle.main.url(forResource: "AppBackground3", withExtension: "jpg")
        let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])
        content.attachments = [attachment]
        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 12
//        dateComponents.minute = 50
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = "Notification Identifier"
        let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    
    @IBAction func refereshButton(_ sender: UIButton) {
        covidManager.performSummaryRequest(countryName: nil)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!

    @IBAction func searchButton(_ sender: Any) {
        covidManager.performSummaryRequest(countryName: self.searchBar.text)
    }
}

extension ViewController: CovidManagerDelegate{
    
    func didUpdateData(_ covidManager: CovidManager, data : CovidData, countryName: String?) {
        DispatchQueue.main.async {
            self.showCountryData(data: data, countryName: countryName)
        }
    }
    
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
        self.newDeathsLbl.text = newDeaths
        self.totalDeathsLbl.text = totalDeaths
        self.newRecoveredLbl.text = newRecovered
        self.totalRecoveredLbl.text = totalRecovered
    }
}



