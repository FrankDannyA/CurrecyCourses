//
//  CustomTableViewCell.swift
//  CurrecyCourses
//
//  Created by Даниил Франк on 21.12.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameCoursesInCell: UILabel!
    @IBOutlet weak var courseInCell: UILabel!
    
    func initCell(currency: Currency){
        
        imageCell.image = currency.imageFlag
        nameCoursesInCell.text = currency.name
        courseInCell.text = currency.value
        
    }
}
