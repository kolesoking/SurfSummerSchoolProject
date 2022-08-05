//
//  TabBarModel.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 03.08.2022.
//

import Foundation
import UIKit

enum TabBarModel {
    case main
    case favorites
    case profile
    
    var title: String {
        switch self {
        case .main:
            return "Главная"
        case .favorites:
            return "Избраное"
        case .profile:
            return "Профиль"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .main:
            return UIImage(named: "mainTab")
        case .favorites:
            return UIImage(named: "favoritesTab")
        case .profile:
            return UIImage(named: "profileTab")
        }
    }
    
    var selectedImage: UIImage? {
        return image
    }
    
}
