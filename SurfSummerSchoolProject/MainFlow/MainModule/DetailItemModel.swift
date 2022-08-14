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
        formatter.dateFormat = "dd.mm.yyyy"
        
        self.dateCreation = formatter.string(from: dateCreation)
    }
    
    static func createDefault() -> DetailItemModel {
        .init(
            imageURLInString: "https://img2.akspic.ru/previews/5/8/2/8/6/168285/168285-astronavt-risovanie-kosmos-kosmicheskoe_prostranstvo-multfilm-500x.jpg",
            title: "Самый милый корги",
            isFavorite: false,
            content: "Для бариста и посетителей кофеен специальные кружки для кофе — это ещё один способ проконтролировать вкус напитка и приготовить его именно так, как нравится вам. \n \nТеперь, кроме регулировки экстракции, настройки помола, времени заваривания и многого что помогает выделять нужные характеристики кофе, вы сможете выбрать и кружку для кофе в зависимости от сорта.",
            dateCreation: Date()
        )
    }
}
