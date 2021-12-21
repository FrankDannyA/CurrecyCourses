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
    
    @IBOutlet weak var buttonFrom: UIButton!
    @IBOutlet weak var buttonTo: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshButton()
        textEditingChange(self)
    }
    
    @IBAction func textEditingChange(_ sender: Any) {
        let amount = Double(fromTF.text!)
        toTF.text = Model.shared.convert(amount: amount)
    }
    
    
    @IBAction func buttonFromPush(_ sender: Any) {
        let selectCurrency = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (selectCurrency.viewControllers[0] as! SelectCurrencyTableViewController).flagCurrency = .from
        present(selectCurrency, animated: true)
        
    }
    
    @IBAction func buttonToPushed(_ sender: Any) {
        let selectCurrency = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (selectCurrency.viewControllers[0] as! SelectCurrencyTableViewController).flagCurrency = .to
        present(selectCurrency, animated: true)
        
    }
    
    func refreshButton() {
        buttonFrom.setTitle(Model.shared.fromCurrency?.charCode, for: .normal)
        buttonTo.setTitle(Model.shared.toCurrency?.charCode, for: .normal)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fromTF.endEditing(true)
        refreshButton()
        textEditingChange(self)
    }
    
}
