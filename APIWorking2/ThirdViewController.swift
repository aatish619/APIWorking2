//
//  ThirdViewController.swift
//  APIWorking2
//
//  Created by Aatish Mehta on 12/22/23.
//

// ThirdViewController.swift

import UIKit

class ThirdViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    // Add a property to store the received data
    var receivedData: ResponseData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Third View"
        
        // Register the table view cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Set the table view data source
        tableView.dataSource = self
        
        // Print information to the debugger console
        if let data = receivedData {
            print("Received Data in ThirdViewController: \(data)")
        } else {
            print("No data received in ThirdViewController.")
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // Assuming you want one section for the user data
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Assuming you want one row for the user data
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell with the user data
        if let data = receivedData {
            cell.textLabel?.numberOfLines = 0  // Set the number of lines to 0 for multiline support
            cell.textLabel?.text = """
                First Name: \(data.firstName)
                Last Name: \(data.lastName)
                User Name: \(data.userName)
                Password: \(data.passwordProperty)
                Confirm Password: \(data.confirmPasswordProperty)
                """
        } else {
            cell.textLabel?.text = "No data available."
        }
        
        return cell
    }
}
