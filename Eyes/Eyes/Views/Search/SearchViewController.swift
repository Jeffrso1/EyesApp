//
//  SearchViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 30/11/20.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DAORequester, DAOSearch {
    
    var selectedMovie: Movie?
    
    var sortedDictionary : [Movie] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var indicator = UIActivityIndicatorView()
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
    var noFavoritesView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiView
    }()
    
    
    var noFavoritesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = NSLocalizedString("No Movies Favorited", comment: "")
        label.textAlignment = .center
        label.numberOfLines = 2
        
        
        return label
    }()
    
    var noFavoritesMessageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = NSLocalizedString("Find movies on Trending or on Search", comment: "")
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    var noResultsView: UIView = {
        let uiView = UIView()
        
        return uiView
    }()
    
    
    let movieSearch = MovieSearchState()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var searchText: String = "Carros"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = NSLocalizedString("Movies", comment: "")
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true

        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as! SearchTableViewCell
        
        cell.movieTitle.text = sortedDictionary[indexPath.row].title
    
        cell.movieImage.image = UIImage(named:"wait")
        
        imageLoader.loadAsyncImage(from: sortedDictionary[indexPath.row]) { image in
            cell.movieImage.image = image
        }
        
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dao.searchedMovies.count != 0 {
            return dao.searchedMovies.count
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedMovie = sortedDictionary[indexPath.row]
        
        dao.searchMovieLocalized(movie: [selectedMovie!], to: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if(segue.identifier == "searchSegue") {
                
                
                
            }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationBar.configNavBar(view: self)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        var numOfSections: Int = 0
        
        if searchController.isActive {
        
        if dao.searchedMovies.count != 0
       
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
            tableView.backgroundView = nil
        }
        
        else
        
        {
            
            setupNoResultsView()
            
            indicator.stopAnimating()
            indicator.hidesWhenStopped = true
            
        }
            
        }
        
        return numOfSections
    }
    
    
    func updated() {

        sortedDictionary = Array(dao.searchedMovies.values).sorted(by: {$0.voteCount > $1.voteCount})

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func search() {
        
        performSegue(withIdentifier: "searchSegue", sender: self)
        
    }
    
    func setupNoResultsView() {
        
        let noResultsFound: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: tableView.bounds.size.height))
        noResultsFound.textColor = .white
        noResultsFound.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        noResultsFound.text = NSLocalizedString("No Movies Found", comment: "")
        noResultsFound.textAlignment = .center
        noResultsFound.numberOfLines = 2
        
        let noResultsMessage: UILabel     = UILabel(frame: CGRect(x: 0, y: 40, width: self.tableView.bounds.size.width, height: tableView.bounds.size.height))
        
        noResultsMessage.textColor = .white
        noResultsMessage.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        noResultsMessage.text = NSLocalizedString("No Movies Favorited", comment: "")
        noResultsMessage.textAlignment = .center
        noResultsMessage.numberOfLines = 2
        
        
        tableView.backgroundView  = noResultsFound
        tableView.separatorStyle  = .none
        
        
        
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


extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {

        searchController.showsSearchResultsController = true
 
    return
    
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let text = searchBar.text
        
        dao.searchedMovies.removeAll()
        
        dao.searchMovies(to: self, query: text!)
        
        activityIndicator()
        indicator.startAnimating()
     
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        dao.searchedMovies.removeAll()
        
        UIView.transition(with: tableView,
        duration: 0.3,
        options: .transitionCrossDissolve,
        animations: { self.tableView.reloadData() })
        
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
        
        tableView.backgroundView = nil
    }
    
}
