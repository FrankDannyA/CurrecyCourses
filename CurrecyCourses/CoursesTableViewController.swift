//
//  CoursesTableViewController.swift
//  CurrecyCourses
//
//  Created by Даниил Франк on 20.12.2021.
//

import UIKit

class CoursesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed" ),
                                               object: nil,
                                               queue: nil) { notification in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "Курсы за: \(Model.shared.currentDate)"
            }
        }
        
        navigationItem.title = "Курсы за: \(Model.shared.currentDate)"
    }
    
    @IBAction func pushRefresh(_ sender: Any) {
        Model.shared.loadXMLFiles(date: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Model.shared.currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let courseForCell = Model.shared.currencies[indexPath.row]
        
        cell.textLabel?.text = courseForCell.name
        cell.detailTextLabel?.text = courseForCell.value
        
        return cell
    }
}
