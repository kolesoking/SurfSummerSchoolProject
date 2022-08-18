//
//  FavoriteService.swift
//  SurfSummerSchoolProject
//
//  Created by катя on 16.08.2022.
//

import Foundation

class FavoriteService {
    
    static let shared = FavoriteService()
    
    let defaults = UserDefaults.standard
    
    private enum Keys: String {
        case favoritePosts
    }
    
    var favoritePosts: [DetailItemModel] {
        get {
            
            if let data = defaults.value(forKey: Keys.favoritePosts.rawValue) as? Data {
                return try! PropertyListDecoder().decode([DetailItemModel].self, from: data)
            } else {
                return [DetailItemModel]()
            }

        }
        
        set {
            
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: Keys.favoritePosts.rawValue)
            }
        }
    }
    
    func saveInFavorites(post: DetailItemModel) {
        
        favoritePosts.append(post)
    }
    
    func deliteFromFavorite(indexPath: Int) {
        
        favoritePosts.remove(at: indexPath)
    }
    
    
}
