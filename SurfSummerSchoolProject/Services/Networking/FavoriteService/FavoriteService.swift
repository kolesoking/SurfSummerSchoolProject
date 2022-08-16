//
//  FavoriteService.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 16.08.2022.
//

import Foundation

final class FavoriteService {
    
    private enum Keys: String {
        case favoriteModel
    }
    
    static var favoriteModel: FavoriteModel! {
        get {
            guard let savedData = UserDefaults.standard.object(forKey: Keys.favoriteModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? FavoriteModel else { return nil }
            return decodedModel
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = Keys.favoriteModel.rawValue
            
            if let favoriteModel = newValue {
                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: favoriteModel, requiringSecureCoding: false) {
                    defaults.set(savedData, forKey: key)
                }
            }
        }
    }
    
    func getCacheFavorite() -> FavoriteModel {
        guard let savedData = UserDefaults.standard.object(forKey: Keys.favoriteModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? FavoriteModel else { return FavoriteModel.init(imageURLInString: "", title: "", isFavorite: false, content: "", dateCreation: "") }
        return decodedModel
    }
    
    func cacheFavorite(value: FavoriteModel) {
        let defaults = UserDefaults.standard
        let key = Keys.favoriteModel.rawValue
        
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) {
            defaults.set(savedData, forKey: key)
        }
    }
    
}
