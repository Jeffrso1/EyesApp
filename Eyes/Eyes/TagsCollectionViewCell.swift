//
//  TagsCollectionViewCell.swift
//  Eyes
//
//  Created by Jefferson Silva on 28/10/20.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tags : [TagSelected] = []
    
    var names = ["Tag1", ""]
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let loadMovie = dao.loadMovieCK(with: String(currentMovie!.id))

        let loadedTags = loadMovie?.tagsSelected
        
        if loadedTags != nil {
            tags.append(loadedTags![0])
            tags.append(loadedTags![1])
        }
        
        print(self.tags.count)
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath as IndexPath) as! InsideTagsCollectionViewCell
        
        let langStr = Locale.current.languageCode
        
        if langStr == "en" {
        
        cell.tagButton.setTitle(tags[indexPath.row].displayName_enUS, for: .normal)
        
        } else {
            
        cell.tagButton.setTitle(tags[indexPath.row].displayName_ptBR, for: .normal)
            
        }
        
        //cell.tagButton.setTitle("Tags Not Available", for: .normal)
            
        
        
        return cell
    
    }
    
    
    
    
    
    
    
    
    
    
    
}
