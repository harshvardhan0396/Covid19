import Foundation


protocol CovidManagerDelegate{
    func didUpdateData(_ covidData: CovidManager, data: CovidData, countryName: String?)
}





struct CovidManager{
    
    var delegate: CovidManagerDelegate?
    
    func performSummaryRequest(countryName: String?){
        let covidAPIURL = URL(string: "https://api.covid19api.com/summary")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: covidAPIURL! ) { (data, response, error) in
            if error != nil{
                print(error!)
            }
            if let safeData = data{
                if let data = self.parseJSON(safeData){
                    self.delegate?.didUpdateData(self, data: data, countryName: countryName)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(_ covidData: Data) -> CovidData?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CovidData.self, from: covidData)
            return decodedData
        }
        catch{
            print(error)
            return nil
        }
        
    }
}
