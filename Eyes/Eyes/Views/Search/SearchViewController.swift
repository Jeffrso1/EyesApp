//
//  SearchViewController.swift
//  Eyes
//
//  Created by Lucas Frazão on 30/11/20.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DAORequester {
    
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
        searchController.searchBar.placeholder = "Search for Movies or Tags"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true

        searchController.searchBar.delegate = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "results", for: indexPath) as! SearchTableViewCell
    
        cell.movieTitle.text = sortedDictionary[indexPath.row].title
        cell.movieReleaseDate.text = sortedDictionary[indexPath.row].releaseDate
        //cell.movieGenre.text = dao.searchedMovies[Array(dao.searchedMovies.keys)[indexPath.row]]?.genres?.first?.name
    
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
        
        performSegue(withIdentifier: "searchSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if(segue.identifier == "searchSegue") {
                let vc = segue.destination as! MovieDetailsViewController
                dao.selectedMovie = selectedMovie
            }
        }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationBar.configNavBar(view: self)
    }
    
    
    func updated() {
        
        //print("Euuu")
        sortedDictionary = Array(dao.searchedMovies.values).sorted(by: {$0.voteCount > $1.voteCount})
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
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


extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
   
    func updateSearchResults(for searchController: UISearchController) {

        searchController.showsSearchResultsController = true
        
        //tableView.reloadData()
        
        
    return
    
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        let text = searchBar.text
        
        dao.searchedMovies.removeAll()
        
        dao.searchMovies(to: self, query: text!)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        dao.searchedMovies.removeAll()
        
        UIView.transition(with: tableView,
        duration: 0.2,
        options: .transitionCrossDissolve,
        animations: { self.tableView.reloadData() })
        
    }
    
}
