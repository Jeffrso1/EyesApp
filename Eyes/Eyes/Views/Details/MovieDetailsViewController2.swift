//
//  MovieDetailsViewController2.swift
//  Eyes
//
//  Created by Jefferson Silva on 19/01/21.
//

import UIKit

class MovieDetailsViewController2: UIViewController {

    let headerID = "header"
    let overviewID = "overview"
    let tagsID = "tags"
    let castID = "cast"
    
    let detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        // Configurações referentes à UITableView
        detailsTableView.dataSource = self
        detailsTableView.delegate = self
        detailsTableView.estimatedRowHeight = 100
        detailsTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(detailsTableView)
        
        detailsTableView.register(HeaderTableViewCell2.self, forCellReuseIdentifier: headerID)
        detailsTableView.register(OverviewTableViewCell2.self, forCellReuseIdentifier: overviewID)
        detailsTableView.register(TagsTableViewCell2.self, forCellReuseIdentifier: tagsID)
        detailsTableView.register(CastListTableViewCell2.self, forCellReuseIdentifier: castID)
        
        setupDetailsTableView()
        
    }
    
    func setupDetailsTableView() {
        NSLayoutConstraint.activate([
            detailsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: headerID) as! HeaderTableViewCell2
            cell.setupCell()
            cell.backgroundColor = .blue
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: overviewID) as! OverviewTableViewCell2
            cell.backgroundColor = .green
            return cell
        
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: tagsID) as! TagsTableViewCell2
            cell.backgroundColor = .cyan
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
}
