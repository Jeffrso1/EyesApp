//
//  FavoritesViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 02/12/20.
//

import UIKit

let favoritesViewController = FavoritesViewController()

class FavoritesViewController: UIViewController, DAORequester, FavoritesDelegate {
    
    let favoritesID = "favorite"
    
    var favoriteList: [String] { UserDefaults.standard.stringArray(forKey: "FavoriteList") ?? [String]() }
    
    var intFavoriteList : [Int] = []
    
    var favoritesCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.backgroundColor()
        
        return collectionView
    }()
    
    var noFavoritesView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiView
    }()
    
    var pageName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var noFavoritesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = NSLocalizedString("No Movies Favorited", comment: "")
        label.textAlignment = .center
        label.numberOfLines = 2
        
        
        return label
    }()
    
    var noFavoritesMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = NSLocalizedString("Find movies on Trending or on Search", comment: "")
        label.textAlignment = .center
        label.numberOfLines = 2
        
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
        
        noFavoritesView.addSubview(noFavoritesLabel)
        noFavoritesView.addSubview(noFavoritesMessageLabel)
        
        view.addSubview(favoritesCollectionView)
        
        setupFavoriteCV()
        
        UIView.transition(with: favoritesCollectionView,
        duration: 0.5,
        options: .transitionCrossDissolve,
        animations: {})
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Favoritos"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
        self.favoritesCollectionView.reloadData()
        
    }
    
    func updateCell() {
        
        favoritesCollectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationBar.configNavBar(view: self)
        
    }
    
    
    func updated() {
        DispatchQueue.main.async {
            self.favoritesCollectionView.reloadData()
        }
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        var numOfSections: Int = 0
        
        if dao.favoriteMovies.count != 0
        {
            numOfSections            = 1
            favoritesCollectionView.backgroundView = nil
            
        }
       
        else
        
        {
            setupNoFavoritesView()
        }
        
        return numOfSections
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoritesID, for: indexPath) as! FavoritesCell
        
        if dao.favoriteMovies.count < favoriteList.count {
            cell.setupCell(movie: Movie.stubbedMovie, check: false)
        } else {
            cell.setupCell(movie: dao.favoriteMovies[Int(favoriteList[indexPath.row])!]!, check: true)
        }
        
        cell.delegate = self
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        dao.selectedMovie = dao.favoriteMovies[Int(favoriteList[indexPath.row])!]!
        
        performSegue(withIdentifier: "toDetails", sender: self)
        
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
    
    private func setupNoFavoritesView() {
        
        noFavoritesView.frame = CGRect(x: 0, y: 0, width: favoritesCollectionView.bounds.width, height: favoritesCollectionView.bounds.height)
    
        favoritesCollectionView.backgroundView = noFavoritesView
 
        NSLayoutConstraint.activate([
            noFavoritesLabel.leadingAnchor.constraint(equalTo: favoritesCollectionView.layoutMarginsGuide.leadingAnchor, constant: 20),
            noFavoritesLabel.trailingAnchor.constraint(equalTo: favoritesCollectionView.layoutMarginsGuide.trailingAnchor, constant: 20),
            noFavoritesLabel.centerYAnchor.constraint(equalTo: favoritesCollectionView.centerYAnchor),
            
            noFavoritesMessageLabel.leadingAnchor.constraint(equalTo: favoritesCollectionView.layoutMarginsGuide.leadingAnchor, constant: 20),
            noFavoritesMessageLabel.trailingAnchor.constraint(equalTo: favoritesCollectionView.layoutMarginsGuide.trailingAnchor, constant: 20),
            noFavoritesMessageLabel.topAnchor.constraint(equalTo: noFavoritesLabel.bottomAnchor, constant: 20)
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
