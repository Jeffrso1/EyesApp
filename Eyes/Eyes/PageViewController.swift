//
//  PageViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 22/10/20.
//

import UIKit
import CloudKitMagicCRUD

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, DAORequester {
    
    func updated() {
        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        self.reloadInputViews()
    }
    
    fileprivate var items: [UIViewController] = []
    
    var itemIndex = 0
    
    var imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        dao.loadMovies(to: self)
        
        
        // Do any additional setup after loading the view.
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

    }
    
    
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            guard previousIndex >= 0 else {
                return items.last
            }
            
            guard items.count > previousIndex else {
                return nil
            }
        
            return items[previousIndex]
        }
        
        func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = items.firstIndex(of: viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            guard items.count != nextIndex else {
                return items.first
            }
            
            guard items.count > nextIndex else {
                return nil
            }
            
            return items[nextIndex]
        }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dao.moviesLocalized.count
    }

//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return itemIndex
//    }

    
    fileprivate func populateItems() {
        dao.loadMovieLocalized(to: self)
        for movie in dao.moviesLocalized {
            imageLoader.loadImage(with: (movie?.posterURL)!)
            var image = imageLoader.image
            
            let t = movie?.title
            let d = movie?.overview
            let g = movie?.genreText
            let dt = movie?.runtime
            
            let c = createCarouselItemControler(title: t, overview: d, time: String(dt!), genre: g, image: image)
            if dao.moviesLocalized.count == dao.movieList.count {
                items.append(c)
            }
        }
    }
    
    fileprivate func createCarouselItemControler(title titleText: String?, overview movieDesc: String?, time movieTime: String?, genre movieGenre: String?, image movieBanner: UIImage?) -> UIViewController {
            let c = UIViewController()
        c.view = CarouselItem(titleText: titleText, movieDesc: movieDesc, movieTime: movieTime!, movieGenre: movieGenre!, image: movieBanner)
            
            return c
        }
}


