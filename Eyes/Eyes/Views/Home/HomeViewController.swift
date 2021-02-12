//
//  HomeViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 26/01/21.
//

import UIKit

class HomeViewController: UIViewController, DAORequester {
  
    let imageLoader = ImageLoader()
    
    let movieListTVC = MovieListTableViewCell()
    
    var lastOffsetY : CGFloat = 0
    
    let headerID = "header"
    let listsID = "list"
    
    func updated() {
        
        tableView.reloadData()
  
    }

    @objc func configButtonWasPressed(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextScene = storyboard.instantiateViewController(withIdentifier: "about") as! AboutAppViewController
        
        self.navigationController?.pushViewController(nextScene, animated: true)
    }
    
    private var compactConstraints: [NSLayoutConstraint] = []
    private var regularConstraints: [NSLayoutConstraint] = []
    private var sharedConstraints: [NSLayoutConstraint] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = false
        let appConfig = UIBarButtonItem(image: SFSymbols.gearshape, style: .plain, target: self, action: #selector(configButtonWasPressed))
        navigationItem.leftBarButtonItem = appConfig
        
        self.navigationController?.navigationBar.tintColor = .white
        navigationBar.configNavBar(view: self)
        
        setupTableView()
        
        loadingMovieList()
        loadHeaderMovie()

        setupConstraints()
        NSLayoutConstraint.activate(sharedConstraints)
        layoutTrait(traitCollection: UIScreen.main.traitCollection)
        
    }

    func loadingMovieList() {
        
        for i in 0..<sections.count {
            
            let collectionView = tableView.cellForRow(at: IndexPath.init(row: i, section: 1)) as? DAORequester
        
            dao.loadMovies(to: collectionView, from: sections[i].sectionType)
            
        }

    }
    
    func loadHeaderMovie() {
        
        dao.loadMovie(movie: 464052, to: self)
        
    }
    
    
    func setupTableView() {
        
        // TableView Configuration
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.backgroundColor()
        tableView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(tableView)

        tableView.register(HeaderHomeTableViewCell.self, forCellReuseIdentifier: headerID)
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: listsID)
        
    }
    
    
    // MARK: - Constraints
    func setupConstraints() {
    
        sharedConstraints.append(contentsOf: [
        
            //TableView
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
        
        ])
        
        regularConstraints.append(contentsOf: [
        
            //TableView
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        
        ])
        
        compactConstraints.append(contentsOf: [
        
            //TableView
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
    
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
    
    //Checks whether trait collection (layout) has changed.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)
        layoutTrait(traitCollection: traitCollection)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //super.init(true)
        
        
        
        
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return sections.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerID) as! HeaderHomeTableViewCell
            
            cell.mainViewController = self
            
            if dao.movie != nil {
                
            cell.movie = dao.movie!
            cell.setupCell(movie: dao.movie!)
                
            }

            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: listsID) as! MovieListTableViewCell
            
            cell.viewController = self
            
            cell.backgroundColor = .backgroundColor()
            
            var movies = [Movie]()
            
            switch indexPath.row {
            case 0:
                movies = dao.popular
            case 1:
                movies = dao.nowPlaying
            case 2:
                movies = dao.upComing
            case 3:
                movies = dao.topRated
            default:
                movies = dao.nowPlaying
            }
            
            cell.setupCell(movies: movies, listTitle: sections[indexPath.row].sectionName)
  
            cell.updated()

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


extension HomeViewController: UIScrollViewDelegate {
    
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
                
            }, completion: nil)
        }
        
        
    }
}
