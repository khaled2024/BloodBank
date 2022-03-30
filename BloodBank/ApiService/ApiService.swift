//
//  ApiService.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 26/03/2022.
//

import Foundation
class ApiService  {
    static let sharedService = ApiService()
    let urlForCorona = "https://disease.sh/v3/covid-19/all"
    let urlForCountry = "https://disease.sh/v3/covid-19/countries"
    
    func getCoronaAnalysis(completion: @escaping(_ coronaAnalysis: CoronaAnalysis?,_ error: Error?)-> Void){
        guard let url = URL(string: urlForCorona )else{return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else{return}
            guard let data = data else {
                return
            }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(CoronaAnalysis.self, from: data)
                debugPrint(response)
                completion(response,nil)
            }catch{
//                debugPrint(error.localizedDescription)
                completion(nil,error)
            }
        }
        task.resume()
    }
    func getCountryInfo(completion: @escaping(_ repositories: [CountryStats]?,_ error: Error?)-> Void){
        guard let url = URL(string: urlForCountry)else{return}
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else{return}
            guard let data = data else {
                return
            }
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode([CountryStats].self, from: data)
//                debugPrint(response)
                completion(response,nil)
            }catch{
                debugPrint(error.localizedDescription)
                completion(nil,error)
            }
        }
        task.resume()
    }
}
