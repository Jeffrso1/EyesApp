//
//  MovieDetailsViewController2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class MovieDetailsViewController2: UIViewController {
    
    var favoriteButton = UIBarButtonItem()
    
    var lastOffsetY : CGFloat = 0
    
    let headerID = "header"
    let overviewID = "overview"
    let tagsID = "tags"
    let castID = "cast"
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    var movie: Movie?
    //var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    let detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    @objc func favoriteButtonWasPressed(sender: UIButton!) {
        favorites.movieFavoriteBarAction(movieID: movie!.id, barItem: navigationItem.rightBarButtonItems![1])
        haptic.setupImpactHaptic(style: .light)
        
        favorites.isNewMovieAdded = true
        
    }
    
    @objc func movieOptionsButtonWasPressed(sender: UIButton!) {
        let shareViewController = ShareImage(movie: movie!)
        let renderer = UIGraphicsImageRenderer(size: shareViewController.view.bounds.size)
        
        let image = renderer.image { ctx in
            shareViewController.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        Alert.showMovieOptions(vc: self, image: image.jpegData(compressionQuality: 0.8), url: movie?.youtubeTrailers?.first?.youtubeURL, movie: movie!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteButton = UIBarButtonItem(image: SFSymbols.heart, style: .plain, target: self, action: #selector(favoriteButtonWasPressed))
        let movieOptions = UIBarButtonItem(image: SFSymbols.ellipsisCircleFill, style: .plain, target: self, action: #selector(movieOptionsButtonWasPressed))
        
        navigationItem.rightBarButtonItems = [movieOptions, favoriteButton]
        
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        navigationBar.configNavBar(view: self)
        
        // Configurações referentes à UITableView
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        detailsTableView.allowsSelection = false
        detailsTableView.estimatedRowHeight = 100
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.tableFooterView = UIView()
        detailsTableView.separatorStyle = .none
        detailsTableView.backgroundColor = UIColor.backgroundColor()
        
        view.addSubview(detailsTableView)
        
        detailsTableView.register(HeaderTableViewCell2.self, forCellReuseIdentifier: headerID)
        detailsTableView.register(OverviewTableViewCell2.self, forCellReuseIdentifier: overviewID)
        detailsTableView.register(TagsTableViewCell2.self, forCellReuseIdentifier: tagsID)
        detailsTableView.register(CastListTableViewCell2.self, forCellReuseIdentifier: castID)
        
        setupDetailsTableView()
        
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        favorites.checkMovieFavoriteBar(movieID:movie!.id, barItem: favoriteButton)
        navigationBar.configNavBar(view: self)
        
    }
    
    func setupDetailsTableView() {
        
        sharedConstraints.append(contentsOf: [
            
            detailsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        regularConstraints.append(contentsOf: [
            detailsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          
            ])

        compactConstraints.append(contentsOf: [
            detailsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
       
        
    }
    
}

extension MovieDetailsViewController2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dao.selectedMovie == nil {
            //dao.selectedMovie = currentMovie
        }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerID) as! HeaderTableViewCell2
            
            cell.setupCell(movie: movie!)
            cell.mainViewController = self
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: overviewID) as! OverviewTableViewCell2
            
            cell.setupCell(movie: movie!)
            
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: tagsID) as! TagsTableViewCell2
            
            cell.setupCell(movie: movie!)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: castID) as! CastListTableViewCell2
            cell.setupCell()
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerID) as! HeaderTableViewCell2
            return cell
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
           // activating shared constraints
           NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)

        layoutTrait(traitCollection: traitCollection)
        
    }
    
    
}

extension MovieDetailsViewController2: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
                
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        transition.type = CATransitionType.fade
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        lastOffsetY = scrollView.contentOffset.y
        
        if lastOffsetY > 60 {
        
            UIView.animate(withDuration: 0.5, animations: {
               
                self.navigationController?.navigationBar.alpha = 1.0
                self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
                self.navigationController?.navigationBar.shadowImage = nil
                self.navigationController?.navigationBar.isTranslucent = true
                self.navigationController?.view.backgroundColor = UIColor.black
                
            }, completion: nil)
            
        } else {
          
            
            UIView.animate(withDuration: 0.5, animations: {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
           // self.navigationController?.navigationBar.alpha = 0.8
                
            }, completion: nil)
        }
        
        
    }
}
