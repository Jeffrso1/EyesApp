//
//  PageViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 22/10/20.
//

import UIKit
import CloudKitMagicCRUD


class CarouselPageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, DAORequester {
    
    let favorites = UserDefaults.standard.stringArray(forKey: "FavoriteList")
    
    func updated() {
        //print("run function")
        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        self.reloadInputViews()
    }
    
    var items: [CarouselItemVC] = []
    
    var itemIndex = 0
    
    var imageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        decoratePageControl()
        dataSource = self
        delegate = self
        dao.loadMovies(to: self)
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController as! CarouselItemVC) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            itemIndex = viewControllerIndex - 1
        
            guard previousIndex >= 0 else {
                return items.last
            }
            
            guard items.count > previousIndex else {
                return nil
            }
             
            
            return items[previousIndex]
        }
        
        func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = items.firstIndex(of: viewController as! CarouselItemVC) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            itemIndex = viewControllerIndex + 1
            
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
        print("populating")
        for item in dao.movies {
            let c = createCarouselItemControler(movie: item.value)
            items.append(c)
        }
    }

    
    fileprivate func createCarouselItemControler(movie: Movie) -> CarouselItemVC {
        let c = CarouselItemVC(movie: movie)
        
        return c
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool){
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = self.items.firstIndex(of: currentViewController as! CarouselItemVC) {
                dao.currentMovie = index
                
            }
        }
    }
    
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController as! CarouselItemVC) else {
                return 0
        }
        return firstViewControllerIndex
    }
    
    
    fileprivate func decoratePageControl() {
            let pc = UIPageControl.appearance(whenContainedInInstancesOf: [CarouselPageVC.self])
            pc.currentPageIndicatorTintColor = UIColor(named: "AccentColor")
            pc.pageIndicatorTintColor = .gray
    }
}



