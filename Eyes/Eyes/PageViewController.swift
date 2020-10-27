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
        print("run function")
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
        // Do any additional setup after loading the view.
        dataSource = self
        dao.loadMovies(to: self)
    
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
        return dao.movies.count
    }
    
    fileprivate func populateItems() {
        for item in dao.movies {
            let c = createCarouselItemControler(movie: item.value)
            items.append(c)
        }
        
    }

    
    fileprivate func createCarouselItemControler(movie: Movie) -> UIViewController {
            let c = UIViewController()
            c.view = CarouselItem(movie: movie)
            return c
        }
}



