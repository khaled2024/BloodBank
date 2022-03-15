//
//  Constants.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import Foundation

struct Identifier{
    static let CollectionCell = "OnboardingCollectionViewCell"
    static let HomeNC = "HomeNC"
    static let OnBoardingVC = "OnboardingViewController"
}

struct SlidesArray{
    static let title1 = "Search Blood"
    static let title2 = "Become a Donor"
    static let title3 = "Blood Bank"
    
    static let description1 = "If the accessibility of blood transfusions decreases, the voluntary blood donor might turn away, endangering blood safety much more."
    static let description2 = "he most serious effect could be an undermining of the voluntary blood donor system in this country."
    static let description3 = "The voluntary and altruistic basis of blood donation is both precious and essential to our system of collection."
    
}
struct Arrays{
    static let arrayOfBloodType = ["A+","A-","B+","B-","AB+","AB-","O+","O-","OH+","Dont-Know"]
    static let arrayOfGender = ["","Male","Female"]
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
//cairo
//30.06812038116435, 31.275307443619365
//30.06568172977871, 31.28479430395555
//30.08513944995048, 31.299469135449336
//30.086319063538127, 31.299728084540426
//tanta
//30.783541872054585, 30.988608433925773
