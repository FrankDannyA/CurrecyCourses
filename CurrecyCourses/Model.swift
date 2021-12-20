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
    
    var pathForXML: URL? {
        return nil
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
