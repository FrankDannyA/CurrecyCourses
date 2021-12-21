//
//  Model.swift
//  CurrecyCourses
//
//  Created by Даниил Франк on 20.12.2021.
//

import UIKit

class Currency {
    var numCode: String?
    var charCode: String?
    var nominal: String?
    var nominalDouble: Double?
    
    var name: String?
    
    var value: String?
    var valueDouble: Double?
    
    var imageFlag: UIImage? {
        if let charCode = charCode {
            return UIImage(named: charCode)
        } else {
            return UIImage(named: "XDR")
        }
    }
    
    class func rouble() -> Currency {
        let r = Currency()
        r.charCode = "RUR"
        r.name = "Российский рубль"
        r.nominal = "1"
        r.nominalDouble = 1
        r.value = "1"
        r.valueDouble = 1
        return r
    }
    
}

class Model: NSObject, XMLParserDelegate {
    
    static let shared = Model()

    var currencies: [ Currency] = []
    var currentCurrency: Currency?
    var currentCharacters: String = ""
    var currentDate: String = ""
    
    var fromCurrency: Currency? = Currency.rouble()
    var toCurrency: Currency? = Currency.rouble()
    
    func convert(amount: Double?) -> String {
        if amount == nil{
            return ""
        }
        
        let result = ((fromCurrency!.nominalDouble! * fromCurrency!.valueDouble!) / (toCurrency!.nominalDouble! * toCurrency!.valueDouble!)) * amount!
        
        return String(result)
    }
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                       FileManager.SearchPathDomainMask.userDomainMask,
                                                       true)[0] + "/data.xml"
        
        if FileManager.default.fileExists(atPath: path) {
            return path
        } else {
            return Bundle.main.path(forResource: "data", ofType: "xml")!
        }
    }
    
    var urlForXML: URL { return URL(fileURLWithPath: pathForXML) }
    
    //загрузка XML с cbr.ru и сохранение его в каталоге приложени
    //http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002
    func loadXMLFiles(date: Date?) {
        
        var strUrl = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
        
        if date != nil {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            strUrl = strUrl + dateFormater.string(from: date!)
        }
        
        let url = URL(string: strUrl)
        
        let task = URLSession.shared.dataTask(with: url!) { data, responce, error in
            
            var globalError: String?
            
            if error == nil {
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory,
                                                               FileManager.SearchPathDomainMask.userDomainMask,
                                                               true)[0] + "/data.xml"
                
                let urlForSave = URL(fileURLWithPath: path)
                
                do {
                    try data?.write(to: urlForSave)
                    print("Файл загружен")
                    self.parseXML()
                } catch {
                    globalError = error.localizedDescription
                    print("Error when save data: " + error.localizedDescription)
                }
            } else {
                globalError = error?.localizedDescription
                print("Error when loadXMLFile: " + error!.localizedDescription)
            }
            
            if let globalError = globalError { NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadingXMLerror" ) ,
                                                                               object: self,
                                                                               userInfo: ["ErrorName" : globalError])

            }
        }
        
       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startLoadingXML" ) , object: self)

        task.resume()
    }
    
    //распарсть XML и положить его в currencies: [Currency], отправить уведомление приложению о том что данные обновились
    func parseXML(){
        currencies = [Currency.rouble()]
        
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self
        parser?.parse()
        
        print("Данные обновлены")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed" ) , object: self)
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "ValCurs"{
            if let currentDateString = attributeDict["Date"]{
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd.MM.yyyy"
            currentDate = currentDateString
            }
        }
        
        if elementName == "Valute" { currentCurrency = Currency() }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) { currentCharacters = string }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "NumCode" { currentCurrency?.numCode = currentCharacters }
        if elementName == "CharCode" { currentCurrency?.charCode = currentCharacters }
        if elementName == "Nominal" {
            currentCurrency?.nominal = currentCharacters
            currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        if elementName == "Name" { currentCurrency?.name = currentCharacters }
        if elementName == "Value" {
            currentCurrency?.value = currentCharacters
            currentCurrency?.valueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
        }
        if elementName == "Valute" { currencies.append(currentCurrency!) }
    }
}
