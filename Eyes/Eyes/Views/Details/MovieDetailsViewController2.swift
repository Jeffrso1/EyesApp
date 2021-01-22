//
//  MovieDetailsViewController2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class MovieDetailsViewController2: UIViewController {

    var lastOffsetY : CGFloat = 0
    
    let headerID = "header"
    let overviewID = "overview"
    let tagsID = "tags"
    let castID = "cast"
    
    var movie: Movie?
    var currentMovie = dao.movies[Array(dao.movies)[dao.currentMovie].key]
    
    let detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        view.addSubview(detailsTableView)
        
        detailsTableView.register(HeaderTableViewCell2.self, forCellReuseIdentifier: headerID)
        detailsTableView.register(OverviewTableViewCell2.self, forCellReuseIdentifier: overviewID)
        detailsTableView.register(TagsTableViewCell2.self, forCellReuseIdentifier: tagsID)
        detailsTableView.register(CastListTableViewCell2.self, forCellReuseIdentifier: castID)
        
        setupDetailsTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        favorites.checkMovieFavoriteBar(movieID:dao.selectedMovie!.id, barItem: favoriteButton)
        navigationBar.configNavBar(view: self)
    }
    
    func setupDetailsTableView() {
        NSLayoutConstraint.activate([
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
            dao.selectedMovie = currentMovie
        }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerID) as! HeaderTableViewCell2
            
            cell.setupCell(movie: movie!)
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: overviewID) as! OverviewTableViewCell2
            
            cell.setupCell(movie: movie!)
            
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: tagsID) as! TagsTableViewCell2
            
            cell.setupCell(movie: movie!)
            cell.contentView.setNeedsLayout()
            cell.contentView.layoutIfNeeded()
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: castID) as! CastListTableViewCell2
            cell.backgroundColor = .systemPink
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerID) as! HeaderTableViewCell2
            cell.backgroundColor = .yellow
            return cell
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
