//
//  SettingsViewController.swift
//  CurrecyCourses
//
//  Created by Даниил Франк on 20.12.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var dataPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func pushShowCourses(_ sender: Any) {
        Model.shared.loadXMLFiles(date: dataPicker.date)
        dismiss(animated: true)
    }
    

}
