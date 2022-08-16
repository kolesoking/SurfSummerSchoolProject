//
//  DetailItemModel.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 06.08.2022.
//

import Foundation
import UIKit

struct DetailItemModel {
    
    // MARK: - Internal Properties
    
    let imageURLInString: String
    let title: String
    var isFavorite: Bool
    let content: String
    let dateCreation: String
    
    // MARK: - Intialization
    
    internal init(imageURLInString: String, title: String, isFavorite: Bool, content: String, dateCreation: Date) {
        self.imageURLInString = imageURLInString
        self.title = title
        self.isFavorite = isFavorite
        self.content = content
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        self.dateCreation = formatter.string(from: dateCreation)
    }
}
