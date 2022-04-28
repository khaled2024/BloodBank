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
    
    //MARK: - Api for global Corona Statistic.
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
    //MARK: -Api for Country Corona Statistic.
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
    //MARK: - api for donate places lan & lng
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
    //MARK: - For Registeration.
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
            "mobile_phone": fPhone,
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
    //MARK: - For SignIn.
    func checkSignIn(completion: @escaping (_ error: Error? , _ user: [userData]?) -> Void){
        AF.request("\(URLS.All_patient_Donor)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let user = try JSONDecoder().decode(User.self, from: data).data
                    completion(nil,user)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //MARK: - For Governrate
    func getGovData(completion: @escaping (_ error: Error? , _ gov: [GovData]?) -> Void){
        AF.request("\(URLS.governorate)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let gov = try JSONDecoder().decode(Governorate.self, from: data).data
                    completion(nil,gov)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //MARK: -For Cities
    func getCityData(completion: @escaping (_ error: Error? , _ city: [CityData]?) -> Void){
        AF.request("\(URLS.city)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let city = try JSONDecoder().decode(City.self, from: data).data
                    completion(nil,city)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //MARK: -get all cities by id of governrate
    func getCitiesById(id: String ,completion: @escaping (_ error: Error? , _ city: [DataCities]?) -> Void){
        let url = "\(URLS.citiesById)/\(id)"
        AF.request("\(url)", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let city = try JSONDecoder().decode(FinalCities.self, from: data).data
                    completion(nil,city)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //MARK: -for blood types
    func getBloodType(completion: @escaping (_ error: Error? , _ blood: [BloodData]?) -> Void){
        let url = "https://blood-bank.life/api/api/v1/blood_type/424212219/all"
        AF.request("\(url)", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let blood = try JSONDecoder().decode(BloodType.self, from: data).data
                    completion(nil,blood)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    
    //MARK: -  for stories
    //all stories
    func getStories(completion: @escaping (_ error: Error? , _ story: [StoryData]?) -> Void){
        let url = "\(URLS.Allstories)/all"
        AF.request("\(url)", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let story = try JSONDecoder().decode(UserStories.self, from: data).data
                    completion(nil, story)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    // add story
    func addStory(content: String , p_ssn: String){
        guard let url = URL(string: "\(URLS.addStory)/add")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "p_ssn": p_ssn,
            "content": content
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
//MARK: - Vaccine All
    func getAllVaccines(completion: @escaping (_ error: Error? , _ vaccine: [VaccineData]?) -> Void){
        let url = "\(URLS.vaccineInfo)/all"
        AF.request("\(url)", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let vaccine = try JSONDecoder().decode(Vaccine.self, from: data).data
                    completion(nil, vaccine)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
}

