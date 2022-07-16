//
//  Constants.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import UIKit

struct URLS{
    static let myCode = "230422052801"
    static let urlSite = "https://blood-bank.life/index.php"
    static let urlCoronaStats = "https://disease.sh/v3/covid-19/"
    static let donate_Places = "https://blood-bank.life/api/api/v1/all_donate_places_info/\(myCode)"
    static let quick_Request = "https://blood-bank.life/api/api/v1/quick_request/\(myCode)"
    static let patient_Donor = "https://blood-bank.life/api/api/v1/patients_donors/\(myCode)"
    static let All_patient_Donor = "https://blood-bank.life/api/api/v1/all_patients_donners_info/\(myCode)"
    static let Allstories = "https://blood-bank.life/api/api/v1/all_stories_info/\(myCode)"
    static let addStory = "https://blood-bank.life/api/api/v1/stories/\(myCode)"
    static let governorate = "https://blood-bank.life/api/api/v1/governorate/\(myCode)"
    static let city = "https://blood-bank.life/api/api/v1/cities/\(myCode)"
    static let citiesById = "https://blood-bank.life/api/api/v1/cities_by_gov_id/\(myCode)/gov_id"
    static let vaccineInfo = "https://blood-bank.life/api/api/v1/all_vaccones_info/\(myCode)"
    static let order_vaccine = "https://blood-bank.life/api/api/v1/order_vaccine/\(myCode)"
    static let available_Vaccine = "https://blood-bank.life/api/api/v1/avilable_vaccines/\(myCode)"
    static let All_quick_Requests = "https://blood-bank.life/api/api/v1/all_quick_requests_info/\(myCode)"
    static let request_Blood_Type = "https://blood-bank.life/api/api/v1/request_blood_type/\(myCode)"
    static let donate_Reason = "https://blood-bank.life/api/api/v1/donate_reasons/\(myCode)"
    static let blood_Donation = "https://blood-bank.life/api/api/v1/blood_donation/\(myCode)"
    static let last_Donate = "https://blood-bank.life/api/api/v1/last_donate/\(myCode)"
    static let purchaseOrder = "https://blood-bank.life/api/api/v1/purchase_order/\(myCode)"
    static let savedBloodRequest = "https://blood-bank.life/api/api/v1/saved_blood_requests/\(myCode)"
    static let going_Donor = "https://blood-bank.life/api/api/v1/going_donners/\(myCode)"
    static let Blood_Info = "https://blood-bank.life/api/api/v1/all_blood_info/\(myCode)"
    static let AvailableBlood = "https://blood-bank.life/api/api/v1/avilable_blood/\(myCode)"
    static let buy_Blood = "https://blood-bank.life/api/api/v1/buy_blood/\(myCode)/all"
    static let buy_Vaccine = "https://blood-bank.life/api/api/v1/buy_vaccine/\(myCode)/all"
}
struct Identifier{
    static let CollectionCell = "OnboardingCollectionViewCell"
    static let HomeNC = "HomeNC"
    static let OnBoardingVC = "OnboardingViewController"
    static let hamburgerSegue = "hamburgerSegue"
}
struct SlidesArray{
    static let title1 = "FirstTitle".Localized()
    static let title2 = "SecondTitle".Localized()
    static let title3 = "ThirdTitle".Localized()
    
    static let description1 = "FirstOnboarding".Localized()
    static let description2 = "SecondOnboarding".Localized()
    static let description3 = "ThirdOnboarding".Localized()
    
    
    
}

struct Arrays{
    static let arrayOfBloodType = ["A+","A-","B+","B-","AB+","AB-","O+","O-"]
    static let dicOfBloodType: [String:String] = ["A+":"1","A-":"2","B+":"3","B-":"4","AB+":"5","AB-":"6","O+":"7","O-":"8","OH+":"9","Another":"10"]
    static let arrayOfGover = ["cairo","aswan","mnofia","gharbia"]
    static let arrayOfCities = ["tanta","zakazek","sheben","elsanta"]
    static let arrOfGender = ["Male","Female"]
    static let dicOfGender = ["Male":"1","Female":"2"]
    
    static let arrayOfTypesRequests = ["الصفائح","ABبلازما","Red Double cell","دم الحبل السري","لااعرف"]
    static let arrayReasonRequest = ["accident","surgery","prejnent","canser","زرع اعضاء","الثلاسيميا","الهيموجلوبين"]
    static let arrOfBags = ["1","2","3","4","5"]
    static let arrayOfHospitals = ["khaled","hussien","ahmed","hussien","khalifa"]
    static let arrOfNumber = ["1","2","3","4","5","6","7","8","9","10"]
}
struct EducateTabelArray {
    static let educateArray = ["Blood Needs".Localized(),
                               "Blood Type".Localized(),"Blood Donation".Localized(), "Health Assessment".Localized(),"Eligibility Requirements".Localized(),"FAQs".Localized()]
}
struct EducateCollectionArray {
    static let educateArrayImage = [UIImage(named: "unsplash1"),UIImage(named: "unsplash2"),UIImage(named: "unsplash3"),UIImage(named: "unsplash4"),UIImage(named: "logoImage")]
}
struct Notifications {
    static let detailNot = "detailNotification"
}
struct BloodArticels {
    static let bloodArray = ["firstCell".Localized(), "secondCell".Localized() ,"thirdCell".Localized(),"forthCell".Localized(),"fifthCell".Localized(),"sixCell".Localized()]
}
