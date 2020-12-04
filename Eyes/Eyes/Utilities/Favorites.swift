//
//  Favorites.swift
//  Eyes
//
//  Created by Lucas Frazão on 04/12/20.
//

import UIKit

let favorites = Favorites()

class Favorites: DAORequester {
    
    func updated() {
        
    }
    
    let defaults = UserDefaults.standard
    lazy var favoriteList = defaults.stringArray(forKey: "FavoriteList") ?? [String]()
    
    func checkFavoriteMovies(collectionView: UICollectionView) {
        
        let intFavoriteList = favoriteList.map { Int($0)! }
        dao.loadFavoritesMovies(IDs: intFavoriteList, to: self)
    }
    
}
