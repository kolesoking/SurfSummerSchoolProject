//
//  ProfileModel.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 21.08.2022.
//

import Foundation

struct UserInfo {
    
    let phone: String
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    let city: String
    let about: String
    
    var fullName: String {
        "\(firstName) \n\(lastName)"
    }
    
    static func getUserInfo() -> UserInfo {
        UserInfo(
            phone: "89601395323",
            email: "kolesnikov.serey.al@gmail.com",
            firstName: "Sergey",
            lastName: "Kolesnikov",
            avatar: "https://sun9-31.userapi.com/impg/Otr1JYvsErOlc3vWV9Xp4xCEmef8Jzq8lr_iXA/iOrYdl73-Hk.jpg?size=1619x2160&quality=96&sign=3995e795376b007597539fde3c2ebfef&type=album",
            city: "Voronezh",
            about: "I Love Kate"
        )
    }
}
