//
//  OBPageViewController.swift
//  Eyes
//
//  Created by Jefferson Silva on 04/11/20.
//

import UIKit

class OBPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var items: [UIViewController] = []
    var obArray: [OnBoarding] = []
    
    var titles: [String] = ["Frucas", "Lazão", "MIBR"]
    var subtitles: [String] = ["Billie Joe muito bolado", "Bilolado muito Joe", "Bolilly lado joito mui"]
    
    var itemIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        populateItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            itemIndex = viewControllerIndex - 1
        
//            print(String(itemIndex) + " ALEGRIAAAAAAAA")
            guard previousIndex >= 0 else {
                return items.last
            }
            
            guard items.count > previousIndex else {
                return nil
            }
             
            
            return items[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
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
        return 3
    }
    
    fileprivate func populateItems() {
        obArray = structArrayCreation(titles: titles, subtitles: subtitles)
        
        for item in obArray {
            
            let c = createCarouselItemControler(current: item)
            items.append(c)
        }
        
        print(obArray)
    }

    fileprivate func createCarouselItemControler(current: OnBoarding) -> UIViewController {
        
        let c = UIViewController()
        c.view = OBItem(title: current.title!, subtitle: current.subtitle!, image: current.image!)
        return c
    }
    
    fileprivate func structArrayCreation(titles: [String], subtitles: [String]) -> [OnBoarding] {
        
        var structArray: [OnBoarding] = []
        
        for i in 0..<titles.count {
            let ob = OnBoarding(title: titles[i], subtitle: subtitles[i], image: UIImage(named: "wait")!)
            structArray.append(ob)
        }
        
        return structArray
    }
    
}
extension OBPageViewController {
    
    class OnBoarding {
        var title: String?
        var subtitle: String?
        var image: UIImage?
        
        init(title: String, subtitle: String, image: UIImage) {
            self.title = title
            self.subtitle = subtitle
            self.image = image
        }
    }
}
