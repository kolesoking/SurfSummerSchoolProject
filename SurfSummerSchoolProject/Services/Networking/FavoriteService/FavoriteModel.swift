//
//  FavoriteModel.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 16.08.2022.
//

import Foundation

class FavoriteModel: NSObject, NSCoding {
    
    let imageURLInString: String
    let title: String
    var isFavorite: Bool
    let content: String
    let dateCreation: String
    
    init(imageURLInString: String, title: String, isFavorite: Bool, content: String, dateCreation: String) {
        self.imageURLInString = imageURLInString
        self.title = title
        self.isFavorite = isFavorite
        self.content = content
        self.dateCreation = dateCreation
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(imageURLInString, forKey: "imageURLInString")
        coder.encode(title, forKey: "title")
        coder.encode(isFavorite, forKey: "isFavorite")
        coder.encode(content, forKey: "content")
        coder.encode(dateCreation, forKey: "dateCreation")
    }
    
    required init?(coder: NSCoder) {
        imageURLInString = coder.decodeObject(forKey: "imageURLInString") as? String ?? ""
        title = coder.decodeObject(forKey: "title") as? String ?? ""
        isFavorite = coder.decodeBool(forKey: "isFavorite")
        content = coder.decodeObject(forKey: "content") as? String ?? ""
        dateCreation = coder.decodeObject(forKey: "dateCreation") as? String ?? ""
    }
    
    
}
