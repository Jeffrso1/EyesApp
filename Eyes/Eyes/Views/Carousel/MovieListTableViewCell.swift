//
//  MovieListTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 26/01/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    let movieListID = "movieList"
    
    var movies: [Movie] = []
    
    var mainViewController = UIViewController()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(movies: [Movie], listTitle withTitle: String) {
        
        contentView.addSubview(titleLabel)
        
        
        collectionView.register(MovieItemCollectionViewCell.self, forCellWithReuseIdentifier: movieListID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.backgroundColor()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 20.0, right: 20.0)
        
        titleLabel.text = withTitle
        
        self.movies = movies
        
        setupConstraints()
        
    }
    
    
    func setupConstraints() {
        
        titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 70).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        
        
    }

}

extension MovieListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if movies.count != 0 {
            return movies.count
        } else {
            return 1
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieListID, for: indexPath) as! MovieItemCollectionViewCell

        return cell
    }
    
    
}

extension MovieListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: 55)
    }
}

