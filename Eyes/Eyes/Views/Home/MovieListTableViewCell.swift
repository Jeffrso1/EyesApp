//
//  MovieListTableViewCell.swift
//  Eyes
//
//  Created by Lucas Frazão on 26/01/21.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, DAORequester {
   
    let movieDetailsState = MovieDetailState()
    
    func updated() {

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    let movieListID = "movieList"
    
    var movies: [Movie]?
    
    var viewController = UIViewController()
    
    var indexPath: IndexPath = []
    
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
    
    
    func setupCell(endpoint: MovieListEndpoint, listTitle withTitle: String) {
    
        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        collectionView.register(MovieItemCollectionViewCell.self, forCellWithReuseIdentifier: movieListID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.backgroundColor()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 20.0, right: 20.0)
        
        if self.movies == nil {
        
            dao.loadMovies(from: endpoint) { movies in
                self.movies = movies
            }
            
        }
        
        titleLabel.text = withTitle

        setupConstraints()
 
    }
    

    func setupConstraints() {
        
        titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
        
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        collectionView.heightAnchor.constraint(equalToConstant: 170)
            
        ])
        
    }

}

extension MovieListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies?.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieListID, for: indexPath) as! MovieItemCollectionViewCell
        
        cell.setupCell(movie: movies![indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let nextScene = MovieDetailsViewController2()
        
        //Passa o filme para a variável "movie" da MovieDetailsViewController
        nextScene.movie = movies?[indexPath.row]
  
        self.viewController.navigationController?.pushViewController(nextScene, animated: true)
        
    }
    
    
}

extension MovieListTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

