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
    // get all users
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
    // update userData
    func updateUserData(p_ssn: String , p_first_name:String , p_last_name: String,email: String,gov:String,city:String,mopilePhone:String,secondPhone:String,birthDay:String,bloodType:String,password:String,gender:String){
            guard let url = URL(string: "\(URLS.patient_Donor)/update")else{return}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let body : [String:AnyHashable] = [
                "id": p_ssn,
                   "data":[
                    "p_first_name": p_first_name,
                    "p_last_name": p_last_name,
                    "email": email,
                    "mobile_phone": mopilePhone,
                    "home_phone": secondPhone,
                    "password": password,
                    "blood_type": bloodType,
                    "birthday": birthDay,
                    "gender_id": gender,
                    "city_id": city,
                   ]
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
    //MARK: - get all hospital by is of city
    func getHospitalsById(id: String,completion: @escaping (_ error: Error? , _ places: [placesData]?) -> Void){
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
    //MARK: - requestBloodType
    func getRequestBloodType(completion: @escaping (_ error: Error? , _ requestType: [RequestBloodTypeData]?) -> Void){
        AF.request("\(URLS.request_Blood_Type)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let requestType = try JSONDecoder().decode(RequestBloodType.self, from: data).data
                    completion(nil,requestType)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    
    //MARK: - donate reason
    func getDonateReason(completion: @escaping (_ error: Error? , _ donateReason: [DonateReasonData]?) -> Void){
        AF.request("\(URLS.donate_Reason)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let donateReason = try JSONDecoder().decode(DonateReason.self, from: data).data
                    completion(nil,donateReason)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    
    //MARK: -for blood types
    func getBloodType(completion: @escaping (_ error: Error? , _ blood: [BloodData]?) -> Void){
        let url = "https://blood-bank.life/api/api/v1/blood_type/230422052801/all"
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
    //delete story
    func deleteStoryData(id: String){
        guard let url = URL(string: "\(URLS.addStory)/delete")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "id": id
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
    //updateStory
    func updateData(id: String , content: String){
        guard let url = URL(string: "\(URLS.addStory)/update")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "id": id,
               "data":[
                "content": content,
               ]
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
    // add order vaccine
    func addOrderVaccine(vaccineID: String, delivered_place: String, amount: String, p_ssn: String){
        guard let url = URL(string: "\(URLS.order_vaccine)/add")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "vaccine_id": vaccineID,
            "delivered_place": delivered_place,
            "amount": amount,
            "p_ssn": p_ssn
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("success : \(response)")
            }catch{
                print(error)
        
            }
        }
        task.resume()
    }
    // available Vaccine
    func availableVaccine(completion: @escaping (_ error: Error? , _ availablevaccine: [AvailableVaccineData]?) -> Void){
        let url = "\(URLS.available_Vaccine)/all"
        AF.request("\(url)", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let availablevaccine = try JSONDecoder().decode(AvailableVaccines.self, from: data).data
                    completion(nil, availablevaccine)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //all order vaccines
    func allOrderVaccines(completion: @escaping (_ error: Error? , _ orderVaccine: [OrderVaccineData]?) -> Void){
        let url = "\(URLS.order_vaccine)/all"
        AF.request("\(url)", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let orderVaccine = try JSONDecoder().decode(OrderVaccine.self, from: data).data
                    completion(nil, orderVaccine)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //MARK: - quickRequests
    //all quick request
    func allQuickRequests(completion: @escaping (_ error: Error? , _ request: [QuickRequestData]?) -> Void){
        AF.request("\(URLS.All_quick_Requests)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let request = try JSONDecoder().decode(QuickRequest.self, from: data).data
                    completion(nil,request)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    // add order vaccine
    func sendQuickBloodRequest(p_ssn: String , message:String,donateReason: String,bloodType: String,requestType: String,bloodBagNum:String , placeId: String){
        guard let url = URL(string: "\(URLS.quick_Request)/add")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "place_id": placeId,
            "blood_bags_number": bloodBagNum,
            "blood_type": bloodType,
            "request_type": requestType,
            "donate_reason": donateReason,
            "message": message,
            "p_ssn": p_ssn,
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("success : \(response)")
            }catch{
                print(error)
        
            }
        }
        task.resume()
    }
    
//MARK: - blood_Donation
    //add blood donation
    func addBloodDonation(p_ssn: String , city_id:String,donate_place_id: String,time: String){
        guard let url = URL(string: "\(URLS.blood_Donation)/add")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "p_ssn": p_ssn,
            "city_id": city_id,
            "donate_place_id": donate_place_id,
            "time": time
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("success : \(response)")
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    //MARK: - Last donate
    func myLastDonate(completion: @escaping (_ error: Error? , _ lastDonate: [LastDonateData]?) -> Void){
        AF.request("\(URLS.last_Donate)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let lastDonate = try JSONDecoder().decode(LastDonate.self, from: data).data
                    completion(nil,lastDonate)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //add last donate
    func addLastDonate(p_ssn: String , donate_place_id:String,time: String){
        guard let url = URL(string: "\(URLS.last_Donate)/add")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "donate_place_id": donate_place_id,
            "time": time,
            "p_ssn": p_ssn
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("success : \(response)")
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    //MARK: - purchase_order
    func myPurchaseOrder(completion: @escaping (_ error: Error? , _ purchaseOrder: [PurchaseOrderData]?) -> Void){
        AF.request("\(URLS.purchaseOrder)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let purchaseOrder = try JSONDecoder().decode(PurchaseOrder.self, from: data).data
                    completion(nil,purchaseOrder)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    //MARK: - saved Blood Request
    func allSavedBloodRequests(completion: @escaping (_ error: Error? , _ savedRequest: [SavedBloodRequestData]?) -> Void){
        AF.request("\(URLS.savedBloodRequest)/all", method: .get, encoding: URLEncoding.default , headers: nil).response {
            response in
            if let error = response.error {
                completion(error , nil)
            }
            if let data = response.data {
                do{
                    let savedRequest = try JSONDecoder().decode(SavedBloodRequest.self, from: data).data
                    completion(nil,savedRequest)
                } catch let error {
                    completion(error , nil)
                }
            }
        }
    }
    func savedBloodRequest(p_ssn: String , request_id:String){
        guard let url = URL(string: "\(URLS.savedBloodRequest)/add")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "p_ssn": p_ssn,
            "request_id": request_id
        ]
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {return}
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("success : \(response)")
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    //delete request from favorite
    func deleteFavoriteRequest(id: String){
        guard let url = URL(string: "\(URLS.savedBloodRequest)/delete")else{return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body : [String:AnyHashable] = [
            "id": id
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

