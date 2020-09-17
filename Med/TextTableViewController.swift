//
//  TextTableViewController.swift
//  Med
//
//  Created by DEN Sakadel on 06.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit
var myIndex2 = 0

class TextTableViewController: UIViewController {
    @IBOutlet var textTV: UITableView!
    @IBOutlet weak var titleText: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.synchronize()
        textTV.reloadData()
        textTV.dataSource = self
        textTV.delegate = self
        titleText.title = titles[myIndex]
        textTV.isScrollEnabled = false
        //textTV.scrollDirection = .horizontal
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.textTV.setEditing(editing, animated: animated)
    }
}
    // MARK: - Table view data source

    extension TextTableViewController: UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            textTV.deselectRow(at: indexPath, animated: true)
            if let cell = textTV.cellForRow(at: indexPath) {
                print(cell.textLabel?.text ?? "")
                
                myIndex2 = indexPath.row
                performSegue(withIdentifier: "segueText", sender: myIndex2)
            }
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete{
                texts[titles[myIndex]]!.remove(at: indexPath.row)
                textTV.reloadData()
                saveData()
            }
        }
    }

    extension TextTableViewController: UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return texts[titles[myIndex]]?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cellT")
            cell.textLabel?.text = texts[titles[myIndex]]![indexPath.row]
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
