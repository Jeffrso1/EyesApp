//
//  FavoritesViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 02/12/20.
//

import UIKit

let favoritesViewController = FavoritesViewController()

class FavoritesViewController: UIViewController, DAORequester {
    
    func updated() {
        DispatchQueue.main.async {
            self.favoritesCollectionView.reloadData()
        }
    }
    
    let favoritesID = "favorite"
    
    var favoriteList: [String] { UserDefaults.standard.stringArray(forKey: "FavoriteList") ?? [String]() }
    
    var intFavoriteList : [Int] = []
    
    var favoritesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.backgroundColor()
        
        return collectionView
    }()
    
    var pageName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intFavoriteList = favoriteList.map { Int($0)! }
        dao.loadFavoritesMovies(IDs: intFavoriteList, to: self)
        
        view.backgroundColor = UIColor.backgroundColor()
        
        favoritesCollectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: favoritesID)
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        
        view.addSubview(favoritesCollectionView)
        
        setupFavoriteCV()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        favoritesCollectionView.reloadData()
        
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(favoriteList)
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
            favoritesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            favoritesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            favoritesCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            favoritesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        favoritesCollectionView.contentInset.left = 20
        favoritesCollectionView.contentInset.right = 20
        favoritesCollectionView.contentInset.top = 20
        favoritesCollectionView.contentInset.bottom = 30
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
