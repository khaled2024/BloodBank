//
//  ApiService.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 26/03/2022.
//

import Foundation
import Alamofire

class ApiService{
    //MARK: - Variables.
    static let sharedService = ApiService()
    //MARK: - Private Functions.
    
    // Api for global Corona Statistic.
    func getCoronaAnalysis(completion: @escaping(_ coronaAnalysis: CoronaAnalysis?,_ error: Error?)-> Void){
        guard let url = URL(string: "\(URLS.urlCoronaStats)all" )else{return}
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
                //                debugPrint(response)
                completion(response,nil)
            }catch{
                debugPrint(error.localizedDescription)
                completion(nil,error)
            }
        }
        task.resume()
    }
    //Api for Country Corona Statistic.
    func getCountryInfo(completion: @escaping(_ repositories: [CountryStats]?,_ error: Error?)-> Void){
        guard let url = URL(string: "\(URLS.urlCoronaStats)countries")else{return}
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
                //         debugPrint(response)
                completion(response,nil)
            }catch{
                debugPrint(error.localizedDescription)
                completion(nil,error)
            }
        }
        task.resume()
    }
    // api for donate places lan & lng
    func getDonatePlace(completion: @escaping (_ error: Error? , _ places: [placesData]?) -> Void){
        AF.request("\(URLS.donate_Places)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let place = try JSONDecoder().decode(DonatePlaces.self, from: data).data
                    completion(nil,place)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    // for registeration
    
    func addUserData(email: String , fName: String , lName: String, id: String , password: String , fPhone: String, sPhone: String ,bloodType: String , governrate: String, city: String , birthDay:String, gender: String){
        guard let url = URL(string: "\(URLS.patient_Donor)/add")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "p_ssn": id,
            "p_first_name": fName,
            "p_last_name": lName,
            "email": email,
            "mobile_phone": fName,
            "home_phone": sPhone,
            "password": password,
            "blood_type": bloodType,
            "birthday": birthDay,
            "gender_id": gender,
            "city_id": city
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("success : \(response)")
            } catch  {
                print(error)
                
            }
        }
        task.resume()
    }
}

