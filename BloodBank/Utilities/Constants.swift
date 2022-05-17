//
//  Constants.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import UIKit

struct URLS{
    static let myCode = "230422052801"
    static let urlSite = "https://amr-mohamed1.github.io/blood_bank/index.html"
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

struct LocationCoordinate {
    
    static let locations = [
        ["title":"المركز القومي لنقل الدم","latitude":30.049407,"longitude":31.210987,"description":"العجوزه ،حي العجوزه ،الجيزه مفتوح علي مدار ٢٤ ساعه"],
        ["title":"المركز الاقليمى لنقل الدم بدارالسلام","latitude":30.012583,"longitude":31.228353,"description":"987 كورنيش النيل، مصر القديمة، محافظة القاهرة‬ مفتوح ٢٤ ساعه"],
        ["title":"Cairo University Hospitals Blood bank","latitude":30.03144807543084,"longitude":31.229217088932852,"description":"26JH+HJH، قسم مصر القديمة، محافظة القاهرة‬ يفتح ف ٨ صباحا"],
        ["title":"بنك الدم المركزي - الهلال الاحمر المصري","latitude":30.06018825279941,"longitude":31.244554379548276,"description":"الجيارة، الأزبكية، محافظة القاهرة‬ مفتوح ٢٤ ساعه"],
        ["title":"بنك الدم الرئيسي - عين شمس","latitude":30.06812038116435,"longitude":31.275307443619365,"description":"ممر خاص مستشفى الدمرداش، العباسية القبلية، الوايلى، محافظة القاهرة‬ مفتوح علي مدار ٢٤ ساعه"],
        ["title":"المركز الاقليمي لنقل الدم بالعباسيه","latitude":30.06568172977871,"longitude":31.28479430395555,"description":"امام, مدرسة مفتوح ٢٤ ساعه 0226858645"]
        ,
        ["title":"بنك الدم معامل القوات المسلحة","latitude":30.08513944995048,"longitude":31.299469135449336,"description":"شارع الخليفة المأمون، منشية البكري، قسم مصر الجديدة، محافظة القاهرة‬ علي مدار ٢٤ ساعه"
        ],
        ["title":"معامل القوات المسلحة للبحوث الطبية وبنك الدم","latitude":30.086319063538127,"longitude":31.299728084540426,"description":"شارع الخليفة المأمون، منشية البكري، قسم مصر الجديدة، محافظة القاهرة‬ مفتوح من ٩ صباحا حتي ١٠ مساء"
        ],["title":"المركز الاقليمي لنقل الدم بطنطا","latitude":30.783541872054585,"longitude":30.988608433925773,"description":"Abou Heshmat, طنطا (قسم 2)، مركز طنطا، الغربية مفتوح علي مدار ٢٤ ساعه"
          ]
    ]
    
}
