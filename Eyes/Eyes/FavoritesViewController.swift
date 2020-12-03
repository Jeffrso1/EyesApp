//
//  FavoritesViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 02/12/20.
//

import UIKit

class FavoritesViewController: UIViewController, DAORequester {
    func updated() {
        DispatchQueue.main.async {
            self.favoritesCollectionView.reloadData()
        }
    }
    
    let favoritesID = "favorite"
    
    let defaults = UserDefaults.standard
    lazy var favoriteList = defaults.stringArray(forKey: "FavoriteList") ?? [String]()
    
    var favoritesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        
        return collectionView
    }()
    
    var pageName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intFavoriteList = favoriteList.map { Int($0)! }
        dao.loadFavoritesMovies(IDs: intFavoriteList, to: self)
        
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        favoritesCollectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: favoritesID)
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        
        view.addSubview(favoritesCollectionView)
        
        setupFavoriteCV()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        let intFavoriteList = favoriteList.map { Int($0)! }
//        dao.loadFavoritesMovies(IDs: intFavoriteList, to: self)
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(favoriteList)
        return dao.favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoritesID, for: indexPath) as! FavoritesCell
        
        if dao.favoriteMovies.count < favoriteList.count {
            cell.setupCell(movie: Movie.stubbedMovie, check: false)
        } else {
            cell.setupCell(movie: dao.favoriteMovies[Int(favoriteList[indexPath.row])!]!, check: true)
        }
        
        return cell
    }
    
    private func setupFavoriteCV() {
        NSLayoutConstraint.activate([
            favoritesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            favoritesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            favoritesCollectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 20),
            favoritesCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
        ])
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fullWidth = UIScreen.main.bounds.width - (40)
        let horizontalSpacing: CGFloat = 20
        let availableWidth = fullWidth - horizontalSpacing
        let itemWidth = availableWidth / 3
        
        return CGSize(width: itemWidth, height: itemWidth / 0.71830986)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
