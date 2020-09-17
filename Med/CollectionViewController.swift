//
//  CollectionViewController.swift
//  Med
//
//  Created by DEN Sakadel on 04.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit

//var cVC: UICollectionView = UICollectionView()
class CollectionViewController: UIViewController{
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var layoutCV: UICollectionViewFlowLayout!
    @IBOutlet weak var topTitle: UINavigationItem!

    let cellID = "PhotoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        topTitle.title = titles[myIndex]
        collectionView.isPagingEnabled = true
    }
}

extension CollectionViewController: UICollectionViewDelegate{
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete{
//            texts[titles[myIndex]]!.remove(at: indexPath.row)
//            textTV.reloadData()
//            saveData()
//        }
//    }
}

extension CollectionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (images[titles[myIndex]]?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoCell else {return UICollectionViewCell()}
        cell.setup(k: indexPath.row)
        cell.indexOfCell = indexPath
        cell.delegateData = self
        return cell
    }
    
    
}
extension CollectionViewController: DataCollectionProtocol{
    func deleteData(indexOfData: Int) {
        images[titles[myIndex]]?.remove(at: indexOfData)
        collectionView.reloadData()
        print(images)
    }
    
    
}
extension CollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 20
        let width = collectionView.frame.width - 15
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
