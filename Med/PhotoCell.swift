//
//  PhotoCell.swift
//  Med
//
//  Created by DEN Sakadel on 04.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit
var imageIndex: Int = 0
protocol DataCollectionProtocol{
    func deleteData(indexOfData: Int)
}


class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var delegateData: DataCollectionProtocol?
    var indexOfCell: IndexPath?
   
    @IBAction func deleteImageAction(_ sender: UIButton!) {
        let thisButton = sender!
        let i = indexOfCell?.row ?? 0
        DispatchQueue.global(qos: .background).async {
            guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            do{
                let filePath = documentURL.appendingPathComponent(String(images[titles[myIndex]]?[i] ?? "1") + ".jpg")
                //let fileData = FileManager.default.contents(atPath: filePath.path)
                    //DispatchQueue.main.async {
                try FileManager.default.removeItem(atPath: filePath.path)
                self.delegateData?.deleteData(indexOfData: (self.indexOfCell?.row)!)
                print("zaiwov v delete")
                saveImage()
                print(images)
                thisButton.isEnabled = false

            } catch { print("Kavo: \(error)")}
        }
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
    }
    
    func setup(k: Int){
        //imageView.image = UIImage(named: String(images[titles[myIndex]]?[k] ?? "9")  + ".jpg")
        display(k: k)
    }
    
    private func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage? {
          switch storageType {
              case .fileSystem:
                  if let filePath = self.filePath(forKey: key),
                      let fileData = FileManager.default.contents(atPath: filePath.path),
                      let image = UIImage(data: fileData) {
                      return image
                  }
              case .userDefaults:
                  if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                      let image = UIImage(data: imageData) {
                      return image
                  }
          }
          return nil
      }
          
      @objc
    private func display(k: Int) {
        imageIndex = k
        DispatchQueue.global(qos: .background).async {
            if let savedImage = self.retrieveImage(forKey: String(images[titles[myIndex]]?[k] ?? "0"), inStorageType: .fileSystem) {
                  DispatchQueue.main.async {
                      self.imageView.image = savedImage
                  }
              }
          }
      }
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentURL.appendingPathComponent(key + ".jpg")
    }

    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()!})
    }
    
}

extension PhotoCell:UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
