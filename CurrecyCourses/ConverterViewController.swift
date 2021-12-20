//
//  ConverterViewController.swift
//  CurrecyCourses
//
//  Created by Даниил Франк on 20.12.2021.
//

import UIKit

class ConverterViewController: UIViewController {
    
    
    @IBOutlet weak var labelForDate: UILabel!
    @IBOutlet weak var fromTF: UITextField!
    @IBOutlet weak var toTF: UITextField!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshButton()
    }
    
    @IBAction func textEditingChange(_ sender: Any) {
        let amount = Double(fromTF.text!)
        toTF.text = Model.shared.convert(amount: amount)
    }
    
    
    @IBAction func fromButtonPress() {
    }
    
    @IBAction func toButtonPress() {
    }
    
    func refreshButton() {
        fromButton.setTitle(Model.shared.fromCurrency?.charCode, for: .normal)
        toButton.setTitle(Model.shared.toCurrency?.charCode, for: .normal)
    }
    
}
