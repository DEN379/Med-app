//
//  ImageViewController.swift
//  Med
//
//  Created by DEN Sakadel on 11.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit
var selectedRow2:Int = 0
var random: String = ""
enum StorageType {
    case userDefaults
    case fileSystem
}

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePickerView: UIPickerView!
    @IBOutlet weak var imgView: UIImageView!
    @IBAction func saveImageButton(_ sender: Any?){
        save()
        saveImage()
        
        let alert = UIAlertController(title: "Збережено", message: "Ваше зображення збережено.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
     }

    
    let imagePicker = UIImagePickerController()
    @IBAction func imagePikerButton(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerView.dataSource = self
        imagePickerView.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imgView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
 
    
    private func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType){
        if let pngRepresentation = image.jpegData(compressionQuality: 0.8) {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving results in error: ", err)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation, forKey: key)
            }
        }
    }
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentURL.appendingPathComponent(key + ".jpg")
    }
    
    @objc
    private func save() {
        if let buildingImage = imgView.image{
            random = self.randomString(length: 5)
            DispatchQueue.global(qos: .background).async {
                self.store(image: buildingImage, forKey: random, withStorageType: .fileSystem)
            }
            images[titles[selectedRow2]]?.append(random)
            saveImage()
        }
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()!})
    }
  
}

extension ImageViewController:UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titles.count
    }
    
    
}
extension ImageViewController:UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return titles[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedRow2 = row
            print(selectedRow2)
    }
}
