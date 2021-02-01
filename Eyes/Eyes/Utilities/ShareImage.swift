//
//  ShareImageViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 16/11/20.
//

import UIKit

class ShareImage: UIViewController, DAORequester {
    
    let cellID = "tagCell"
    
    var movie : Movie
    
    var tags: [Tag] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tagsCV.register(CarouselTagCell.self, forCellWithReuseIdentifier: cellID)
        tagsCV.dataSource = self
        tagsCV.delegate = self
        tagsCV.backgroundColor = .clear
        tagsCV.contentInset.left = 15
        tagsCV.showsHorizontalScrollIndicator = false
        
        
        view.addSubview(movieBanner)
        view.addSubview(moviePoster)
        view.addSubview(movieName)
        view.addSubview(timeAndGenre)
        view.addSubview(header)
        view.addSubview(tagButton)
        view.addSubview(shareLogo)
        
        setupMoviePoster()
        setupMovieBanner()
        setupMovieName()
        setupTimeAndGenre()
        setupHeader()
        setupTagButton()
        setupShareLogo()
        
        
    }
    
    func updated() {
        
        tags = (dao.myMovies[Int(movie.id)]?.tags) ?? []
        
    }
    
    var movieName: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    var timeAndGenre: UILabel = {
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
    }()
    
    var tagsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    
    var moviePoster: UIImageView = {

        let image = UIImageView()
    
        image.clipsToBounds = true
        image.layer.cornerRadius = 7
        
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    var movieBanner: UIImageView = {
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    var header: UILabel = {
        
        let uiLabel = UILabel()
        uiLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return uiLabel
        
    }()
    
    var tagButton: UIButton = {
        
        let uiButton = UIButton()
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        
        uiButton.backgroundColor = UIColor(named: "AccentColor")
        uiButton.setTitleColor(.white, for: .normal)
        uiButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        uiButton.sizeToFit()
        
        uiButton.titleLabel?.numberOfLines = 2
        uiButton.titleLabel?.adjustsFontSizeToFitWidth = true
        uiButton.titleLabel?.lineBreakMode = .byClipping
        uiButton.titleLabel?.textAlignment = .center
         
        uiButton.contentEdgeInsets = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 15.0, right: 10.0)
        
        uiButton.layer.cornerRadius = 7
        
        return uiButton
        
    }()
    
    var shareLogo: UIImageView = {
        
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        
        image.image = UIImage(named: "shareLogo")
        
        return image
        
    }()
    
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        movieName.text = movie.title
        //movieDescription.text = movie.overview
        timeAndGenre.text = movie.durationText + " • " + movie.genreText
        
        moviePoster.image = UIImage(named: "wait")!
        movieBanner.image = UIImage(named: "wait")!
        
        loadAsyncImage(from: movie) { image in
            self.moviePoster.image = image
            self.movieBanner.image = image
        }
        
        tagButton.tintColor = moviePoster.image?.averageColor
        
        dao.loadMovieCK(with: String(movie.id), to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMoviePoster() {
        
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        
        moviePoster.heightAnchor.constraint(equalToConstant: 270).isActive = true
        moviePoster.widthAnchor.constraint(equalToConstant: 190).isActive = true
        moviePoster.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        moviePoster.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -140).isActive = true
        
        moviePoster.layer.zPosition = 1
        
    }
    
    private func setupMovieName() {
        
        movieName.font = UIFont.boldSystemFont(ofSize: 30)
        
        // Constraints tiradas do Storyboard...
        let height = movieName.heightAnchor.constraint(equalToConstant: 50)
        height.isActive = true
        height.priority = UILayoutPriority(250)
        movieName.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        movieName.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        movieName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        movieName.numberOfLines = 2
        movieName.textAlignment = .center
        movieName.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint(item: movieName, attribute: .top, relatedBy: .equal, toItem: moviePoster, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
        
    }
    
    private func setupTimeAndGenre() {
        
        timeAndGenre.font = UIFont.systemFont(ofSize: 17)
    
        timeAndGenre.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeAndGenre.numberOfLines = 2
        timeAndGenre.textAlignment = .center
        
        NSLayoutConstraint(item: timeAndGenre, attribute: .top, relatedBy: .equal, toItem: movieName, attribute: .bottom, multiplier: 1, constant: 3).isActive = true
    }
    
    private func setupHeader() {
        
        header.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        header.text = NSLocalizedString("Why Should You Watch It?", comment: "")
        
        header.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor ).isActive = true
        header.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        header.numberOfLines = 2
        header.textAlignment = .center
        
        NSLayoutConstraint(item: header, attribute: .top, relatedBy: .equal, toItem: timeAndGenre, attribute: .bottom, multiplier: 1, constant: 25).isActive = true
        
    }
    
    private func setupTagsCV() {
        
        let height =  tagsCV.heightAnchor.constraint(equalToConstant: 100)
        height.isActive = true
        height.priority = UILayoutPriority(250)
        
        tagsCV.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        tagsCV.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        NSLayoutConstraint(item: tagsCV, attribute: .top, relatedBy: .equal, toItem: header, attribute: .bottom, multiplier: 1, constant: 10).isActive = true
    }
    
    private func setupTagButton() {
    
        let langStr = Locale.current.languageCode
        
        if tags.count != 0 {
            
        let randomTagNumber = Int.random(in: 0..<tags.count)
        
            if langStr == "pt" {
                tagButton.setTitle(tags[randomTagNumber].displayName_ptBR, for: .normal)
            } else {
                tagButton.setTitle(tags[randomTagNumber].displayName_enUS, for: .normal)
            }
            
        } else {
            
            if langStr == "pt" {
                tagButton.setTitle("Baixe agora e avalie esse filme!", for: .normal)
            } else {
                tagButton.setTitle("Download now and review this movie!", for: .normal)
            }
            
            
        }
  
        tagButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 40).isActive = true
        tagButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -40).isActive = true
        
        NSLayoutConstraint(item: tagButton, attribute: .top, relatedBy: .equal, toItem: header, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        
        
    }
    

    private func setupMovieBanner() {
        
        movieBanner.translatesAutoresizingMaskIntoConstraints = false
        
        movieBanner.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
        movieBanner.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        
        movieBanner.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: movieBanner.bounds.height)
        movieBanner.addSubview(blurView)
        
        NSLayoutConstraint.activate([
          blurView.heightAnchor.constraint(equalTo: movieBanner.heightAnchor),
          blurView.widthAnchor.constraint(equalTo: movieBanner.widthAnchor),
        ])
        
    }
    
    private func setupShareLogo() {
        
        shareLogo.translatesAutoresizingMaskIntoConstraints = false
        
        shareLogo.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        shareLogo.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        //shareLogo.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 20).isActive = true
        shareLogo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        shareLogo.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        NSLayoutConstraint(item: shareLogo, attribute: .top, relatedBy: .equal, toItem: tagButton, attribute: .bottom, multiplier: 1, constant: 30).isActive = true
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ShareImage: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if tags.count != 0 {
            return 2
        } else {
            return 1
        }
  
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CarouselTagCell
        
        let langStr = Locale.current.languageCode
        
        if tags.count != 0 {
        
        if langStr == "pt" {
        //cell.setupTagCell(title: tags[indexPath.row].displayName_ptBR)
            
        } else {
        //cell.setupTagCell(title: tags[indexPath.row].displayName_enUS)
        
        }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        let heightValue = self.view.frame.height
        let widthValue = self.view.frame.width
        let cellSize = (heightValue < widthValue) ? bounds.height/2 : bounds.width/2
        
        return CGSize(width: cellSize, height: cellSize)
    }
}
