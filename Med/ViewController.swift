//
//  ViewController.swift
//  Med
//
//  Created by DEN Sakadel on 01.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit

var titles: [String] = ["1. Кардіологія","2. Гастроентерологія","3. Пульмонологія","4. Нефрологія","5. Неврологія","6. Коронавірус","7. Інше"]
var images: [String: [String]] = [titles[0]:[],
                                  titles[1]:[],
                                  titles[2]:[],
                                  titles[3]:[],
                                  titles[4]:[],
                                  titles[5]:[],
                                  titles[6]:[]
]
var texts: [String: [String]] = [titles[0]:[],
                                titles[1]:[],
                                titles[2]:[],
                                titles[3]:[],
                                titles[4]:[],
                                titles[5]:[],
                                titles[6]:[]
]
var myIndex = 0

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 11.0, *) {
            setupNavigationBar()
        }
    }
    
    @available(iOS 11.0, *)
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor(red: 230.0/255.0, green: 40.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.backgroundColor = UIColor(red: 230.0/255.0, green: 40.0/255.0, blue: 30.0/255.0, alpha: 1.0)
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        } else{
            navigationController?.navigationBar.barStyle = .black

        }
//        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

func saveData(){
    UserDefaults.standard.set(texts, forKey: "Texts")
    UserDefaults.standard.synchronize()
}

func saveImage(){
    UserDefaults.standard.set(images, forKey: "Images")
    UserDefaults.standard.synchronize()
}

func loadData(){
    if let array = UserDefaults.standard.dictionary(forKey: "Texts") as? [String:[String]]{
        texts = array
    } else { texts = [titles[0]:[],
                      titles[1]:[],
                      titles[2]:[],
                      titles[3]:[],
                      titles[4]:[],
                      titles[5]:[],
                      titles[6]:[]]
    }
}

func loadImage(){
    if let array = UserDefaults.standard.dictionary(forKey: "Images") as? [String:[String]]{
        images = array
        print(images)
    } else { images = [titles[0]:[],
                      titles[1]:[],
                      titles[2]:[],
                      titles[3]:[],
                      titles[4]:[],
                      titles[5]:[],
                      titles[6]:[]]
    }
}



extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) {
            print(cell.textLabel?.text ?? "")
            myIndex = indexPath.row
            performSegue(withIdentifier: "segue", sender: self)
        }
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete{
//            titles.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
}

extension ViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = titles[indexPath.row]
        cell.tintColor = UIColor(red: 230.0/255.0, green: 40.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        cell.accessoryType = .disclosureIndicator
        let image = UIImage(named:"disclosure.png")?.withRenderingMode(.alwaysTemplate)
        if let width = image?.size.width, let height = image?.size.height {
            let disclosureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width / 2, height: height / 2))
            disclosureImageView.image = image
            cell.accessoryView = disclosureImageView
        }
        return cell
    }
    
}
