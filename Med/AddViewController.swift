//
//  AddViewController.swift
//  Med
//
//  Created by DEN Sakadel on 10.05.2020.
//  Copyright © 2020 DEN Sakadel. All rights reserved.
//

import UIKit
var selectedRow: Int = 0

class AddViewController: UIViewController {
    @IBOutlet var addView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textField: UITextField!
    @IBAction func submitAction(_ sender: Any) {
        doneClicked()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // Done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked(){
        texts[titles[selectedRow]]?.append(textField.text ?? "Помилка")
        saveData()
        addView.endEditing(true)
        textField.text = nil
    }
    
}
extension AddViewController:UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titles.count
    }
    
}

extension AddViewController:UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return titles[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectedRow = row
            print(selectedRow)
    }
}
