//
//  AddDataPageViewController.swift
//  Med
//
//  Created by DEN Sakadel on 13.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit

class AddDataPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    lazy var AddVCList: [UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "addImageVC")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "addTextVC")
        return [vc1,vc2]
    }()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
           guard let vcIndex = AddVCList.firstIndex(of: viewController) else {return nil}
           let previousIndex = vcIndex - 1
           guard previousIndex >= 0 else {return nil}
           guard AddVCList.count > previousIndex else {return nil}
           return AddVCList[previousIndex]
       }
       
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
       guard let vcIndex = AddVCList.firstIndex(of: viewController) else {return nil}
       let nextIndex = vcIndex + 1
       guard AddVCList.count != nextIndex else {return nil}
       guard AddVCList.count > nextIndex else {return nil}
       return AddVCList[nextIndex]
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstVC = AddVCList.first{
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        self.view.backgroundColor = UIColor(red: 230, green: 30, blue: 40, alpha: 1)
    }

}
