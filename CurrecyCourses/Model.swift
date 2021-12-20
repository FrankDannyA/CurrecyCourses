//
//  Model.swift
//  CurrecyCourses
//
//  Created by Даниил Франк on 20.12.2021.
//

import UIKit
/*
<Valute ID="R01010">
    <NumCode>036</NumCode>
    <CharCode>AUD</CharCode>
    <Nominal>1</Nominal>
    <Name>¿‚ÒÚ‡ÎËÈÒÍËÈ ‰ÓÎÎ‡</Name>
    <Value>16,0102</Value>
</Valute>
*/
class Currency {
    var numCode: String?
    var charCode: String?
    var nominal: String?
    var nominalDouble: Double?
    
    var name: String?
    
    var value: String?
    var valueDouble: Double?
    
}

class Model: NSObject {
    
    static let shared = Model()
    
    var carrencies: [ Currency] = []
    
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
    
    var urlForXML: URL? {
        return nil
    }
    
    //загрузка XML с cbr.ru и сохранение его в каталоге приложени
    func loadXMLFiles(data: Data) {
        
    }
    
    //распарсть XML и положить его в currencies: [Currency], отправить уведомление приложению о том что данные обновились
    func parseXML(){
        
    }
}
