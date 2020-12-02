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
    }
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if dao.selectedMovie == nil {
            dao.selectedMovie = currentMovie
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        dao.loadMovieCK(with: String(dao.selectedMovie!.id), to: self)
        
        collectionView.reloadData()
 
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if tags.count != 0 {
            return tags.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath as IndexPath) as! InsideTagsCollectionViewCell
 
        let langStr = Locale.current.languageCode
        
        if tags.count != 0 {
            
            if langStr == "pt" {
                cell.tagButton.setTitle(tags[indexPath.row].displayName_ptBR, for: .normal)
            } else {
                cell.tagButton.setTitle(tags[indexPath.row].displayName_enUS, for: .normal)
            }
            
        } else {
            
            if langStr == "pt" {
                cell.tagButton.setTitle("Seja a primeira a analisar esse filme!", for: .normal)
            } else {
                cell.tagButton.setTitle("Be the first to review this movie!", for: .normal)
            }
        }

        return cell
    
    }
    
    func updated() {
        
        tags = (dao.myMovies[Int(dao.selectedMovie!.id)]?.tags) ?? []
        
        DispatchQueue.main.async {
        
            self.collectionView.reloadData()
        
        }
    }
    
    
    
    
}
