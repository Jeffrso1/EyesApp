//
//  TagsCollectionViewCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 28/10/20.
//

import UIKit



class TagsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, DAORequester {
    
    var isLoaded: Bool = false
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tags : [Tag] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
        
        dao.loadMovieCK(with: String(currentMovie!.id), to: self)
 
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dao.movieCK?.tags.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath as IndexPath) as! InsideTagsCollectionViewCell
 
        let langStr = Locale.current.languageCode
        
        if langStr == "en" {
            cell.tagButton.setTitle(dao.movieCK?.tags[indexPath.row].displayName_enUS, for: .normal)
        } else {
            cell.tagButton.setTitle(dao.movieCK?.tags[indexPath.row].displayName_ptBR, for: .normal)
        }

        return cell
    
    }
    
    func updated() {
        DispatchQueue.main.async {
        self.collectionView.reloadData()
        }
    }
}
