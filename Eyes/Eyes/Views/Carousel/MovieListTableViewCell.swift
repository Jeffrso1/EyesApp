//
//  MovieListTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 26/01/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, DAORequester {
   
    func updated() {
        
        collectionView.reloadData()
        
    }
    
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
        
        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
        
        collectionView.register(MovieItemCollectionViewCell.self, forCellWithReuseIdentifier: movieListID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.backgroundColor()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 20.0, right: 20.0)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        titleLabel.text = withTitle
        
        self.movies = movies
        
        setupConstraints()
        
    }
    
    
    func setupConstraints() {
        
        titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
        
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        //collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        collectionView.heightAnchor.constraint(equalToConstant: 180)
            
        ])
        
    }

}

extension MovieListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieListID, for: indexPath) as! MovieItemCollectionViewCell

        cell.setupCell(movie: movies[indexPath.row])
        
        return cell
    }
    
    
}

extension MovieListTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

