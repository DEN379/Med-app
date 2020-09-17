//
//  DescriptionViewController.swift
//  Med
//
//  Created by DEN Sakadel on 08.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var desciptionLabel: UILabel!
    @IBAction func deleteAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Видалити", message: "Ви дійсно хочете видалити?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Так", style: .destructive, handler: { action in
            texts[titles[myIndex]]?.remove(at: myIndex2)
            saveData()
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let superRootVC = storyboard.instantiateViewController(withIdentifier: "superRootVC")
            self.present(superRootVC, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Відмінити", style: .cancel, handler: { action in
            //return
        }))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        desciptionLabel.text = texts[titles[myIndex]]![myIndex2]
    }

}
