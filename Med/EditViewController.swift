//
//  EditViewController.swift
//  Med
//
//  Created by DEN Sakadel on 11.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var textEdit: UITextView!
    @IBAction func saveEditAction(_ sender: Any) {
        texts[titles[selectedRow]]?[myIndex2] = textEdit.text
        saveData()
        editView.endEditing(true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let superRootVC = storyboard.instantiateViewController(withIdentifier: "superRootVC")
        self.present(superRootVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textEdit.text = texts[titles[selectedRow]]?[myIndex2]
    }

}
