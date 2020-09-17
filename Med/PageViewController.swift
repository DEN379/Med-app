//
//  PageViewController.swift
//  Med
//
//  Created by DEN Sakadel on 06.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController , UIPageViewControllerDataSource{
    @IBOutlet weak var titleOnTop: UINavigationItem!
    
    lazy var VCList: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "collectionVC")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "textVC")
        return [vc1,vc2]
    }()
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = VCList.firstIndex(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard VCList.count > previousIndex else {return nil}
        return VCList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = VCList.firstIndex(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard VCList.count != nextIndex else {return nil}
        guard VCList.count > nextIndex else {return nil}
        return VCList[nextIndex]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstVC = VCList.first{
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        self.view.backgroundColor = UIColor(red: 230, green: 30, blue: 40, alpha: 1)
        titleOnTop.title = titles[myIndex]
        
        if #available(iOS 11.0, *) {
            setupNavigationBar()
        }
    }
    
    @available(iOS 11.0, *)
    func setupNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
    }
    
}

