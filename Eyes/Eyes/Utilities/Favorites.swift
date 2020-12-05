//
//  Favorites.swift
//  Eyes
//
//  Created by Lucas Frazão on 04/12/20.
//

import UIKit

let favorites = Favorites()

class Favorites {
    
    let defaults = UserDefaults.standard
    lazy var favoriteList = defaults.stringArray(forKey: "FavoriteList") ?? [String]()
    var intFavoriteList : [Int] = []
    
    func checkFavoriteMovies(collectionView: UICollectionView) {
        
        //dao.loadFavoritesMovies(IDs: intFavoriteList, to: self)
    }
    
    func checkIfMovieFavoriteButton(movieID:Int, button: UIButton) {
        
        intFavoriteList = favoriteList.map { Int($0)! }
        
        let buttonSC = UIImage.SymbolConfiguration(pointSize: 19, weight: .medium, scale: .large)
        
        let movieAdd = String(movieID)
        
        if favorites.favoriteList.contains(movieAdd) {
            
            favorites.favoriteList.remove(at: favorites.favoriteList.firstIndex(of: movieAdd)!)
            favorites.defaults.set(favorites.favoriteList, forKey: "FavoriteList")
            let heart = SFSymbols.heart?.applyingSymbolConfiguration(buttonSC)
            button.setImage(heart, for: .normal)
            
        } else {
            
            favorites.favoriteList.append(movieAdd)
            dao.loadFavoritesMovies(IDs: [movieID], to: nil)
            
            favorites.defaults.set(favorites.favoriteList, forKey: "FavoriteList")
            let heart = SFSymbols.heartFill?.applyingSymbolConfiguration(buttonSC)
            button.setImage(heart, for: .normal)
     
        }

    }
    
    func checkMovieFavoriteButton(movieID:Int, button: UIButton) {
        
        let movieAdd = String(movieID)
        
        if favorites.favoriteList.contains(movieAdd) {
            
            let heart = SFSymbols.heartFill
            button.setImage(heart, for: .normal)
            
        } else {

            let heart = SFSymbols.heart
            button.setImage(heart, for: .normal)
     
        }

        
    }
    
    
    func movieFavoriteBarAction(movieID:Int, barItem: UIBarItem) {
        
        let movieAdd = String(movieID)
        
        intFavoriteList = favoriteList.map { Int($0)! }
        
        if favorites.favoriteList.contains(movieAdd) {
        
            favorites.favoriteList.remove(at: favorites.favoriteList.firstIndex(of: movieAdd)!)
            favorites.defaults.set(favorites.favoriteList, forKey: "FavoriteList")
            let heart = SFSymbols.heart
            barItem.image = heart
            
        } else {
            
            //favorites.favoriteList.append(movieAdd)
            favorites.favoriteList.append(movieAdd)
            dao.loadFavoritesMovies(IDs: [movieID], to: nil)
            
            favorites.defaults.set(favorites.favoriteList, forKey: "FavoriteList")
            let heart = SFSymbols.heartFill
            barItem.image = heart
     
        }

    }
    
    func checkMovieFavoriteBar(movieID:Int, barItem: UIBarItem) {
        
        let movieAdd = String(movieID)
        
        if favorites.favoriteList.contains(movieAdd) {
            
            let heart = SFSymbols.heartFill
            barItem.image = heart
            
        } else {

            let heart = SFSymbols.heart
            barItem.image = heart
     
        }

        
    }
    
    func removeFavoriteMovie(movie: Movie) {
        
        let movieAdd = String(movie.id)
        
        favorites.favoriteList.remove(at: favorites.favoriteList.firstIndex(of: movieAdd)!)
        favorites.defaults.set(favorites.favoriteList, forKey: "FavoriteList")
        
    }
   
    

    
}
