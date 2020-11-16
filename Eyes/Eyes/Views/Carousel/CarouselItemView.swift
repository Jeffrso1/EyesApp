//
//  CaroulselViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 22/10/20.
//
import UIKit

@IBDesignable
class CarouselItemView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, DAORequester {
    
    var tags: [TagSelected] = []
    
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    static let CAROUSEL_ITEM_NIB = "CarouselItem"
    
    @IBOutlet weak var tagsCV: UICollectionView!
    
    @IBOutlet weak var movieBanner: UIImageView!
    @IBOutlet weak var movieBlurBanner: UIImageView!
    @IBOutlet var vwContent: UIView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var timeAndGenre: UILabel!
    
    private func initCollectionView() {
      let nib = UINib(nibName: "TagCell", bundle: nil)
      tagsCV.register(nib, forCellWithReuseIdentifier: "TagCell")
      tagsCV.dataSource = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(movie: Movie) {
        self.init()
        movieName.text = movie.title
        movieDescription.text = movie.overview
        timeAndGenre.text = movie.durationText + " • " + movie.genreText
       
        movieBanner.image = UIImage(named: "wait")!
        movieBlurBanner.image = UIImage(named: "wait")!
        
        loadAsyncImage(from: movie) { image in
            self.movieBanner.image = image
            self.movieBlurBanner.image = image
        }

        movieBanner.layer.cornerRadius = 7
        movieBanner.clipsToBounds = true
        movieBanner.layer.masksToBounds = true
        movieBanner.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        movieBanner.layer.shadowOffset = CGSize(width: 0, height: 0)
        movieBanner.layer.shadowRadius = 10
        
        //Config Blur View Background
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: movieBlurBanner.bounds.width + 30, height: movieBlurBanner.bounds.height + 30)
        movieBlurBanner.contentMode = .scaleAspectFill
        movieBlurBanner.addSubview(blurView)
        
        //let loadMovie = dao.loadMovieCK(with: String(movie.id), to: self)
        
//        if loadedTags != nil {
//            tags.append(loadedTags![0])
//            tags.append(loadedTags![1])
//        } else {
//            tags.append(TagSelected(displayName_enUS: "No Reviews Available", displayName_ptBR: "Sem Análises Disponíveis"))
//        }
        
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItemView.CAROUSEL_ITEM_NIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
        initCollectionView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! CarouselTagCell
        
        let langStr = Locale.current.languageCode
        
        if langStr == "en" {
        cell.tagsName.setTitle(tags[indexPath.row].displayName_enUS, for: .normal)
        } else {
        cell.tagsName.setTitle(tags[indexPath.row].displayName_ptBR, for: .normal)
        }
        
        return cell
    }
    
    func updated() {
        //tagsCV.reloadData()
    }
    
    
    fileprivate func loadAsyncImage(from movie: Movie, then completion: @escaping (UIImage)->Void) {
        if let data = movie.imageData {
            if let currentImage = UIImage(data: data) {
                completion(currentImage)
            }
        }
        else if let url = movie.posterURL {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    movie.imageData = data
                    DispatchQueue.main.async {
                        if let currentImage = UIImage(data: data) {
                            completion(currentImage)
                        }
                    }
                }
            }
        }
    }
    
}

