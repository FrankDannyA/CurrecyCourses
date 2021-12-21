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
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadingXML" ),
                                               object: nil,
                                               queue: nil) { notification in
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
                activityIndicator.startAnimating()
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed" ),
                                               object: nil,
                                               queue: nil) { notification in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.navigationItem.title = "Курсы за: \(Model.shared.currentDate)"
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                    target: self,
                                                    action: #selector(self.pushRefresh(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loadingXMLerror" ),
                                               object: nil,
                                               queue: nil) { notification in
            _ = notification.userInfo?["ErrorName"]
            
            DispatchQueue.main.async {
                self.showAlert(title: nil, message: "Error Network")
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                    target: self,
                                                    action: #selector(self.pushRefresh(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem
            }
        }
        
        Model.shared.loadXMLFiles(date: nil)
        
        navigationItem.title = "Курсы за: \(Model.shared.currentDate)"
    }
    
    @IBAction func pushRefresh(_ sender: Any) {
        Model.shared.loadXMLFiles(date: nil)
    }
    
    func showAlert (title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let courseForCell = Model.shared.currencies[indexPath.row]
        
        cell.initCell(currency: courseForCell)
        cell.imageCell.layer.cornerRadius = 15
        cell.imageCell.clipsToBounds = true
        
        return cell
    }
}
