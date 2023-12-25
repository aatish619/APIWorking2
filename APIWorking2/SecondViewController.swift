//
//  SecondViewController.swift
//  APIWorking2
//
//  Created by Aatish Mehta on 12/22/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var FirstNameLbl: UILabel!
    @IBOutlet var LastNameLbl: UILabel!
    @IBOutlet var UserNameLbl: UILabel!
    @IBOutlet var PasswordLbl: UILabel!
    @IBOutlet var ConfirmPasswordLbl: UILabel!

    var receivedData: ResponseData?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Second View"

        // Display received data on labels
        if let data = receivedData {
            DispatchQueue.main.async {
                self.FirstNameLbl.text = "First Name: \(data.firstName)"
                self.LastNameLbl.text = "Last Name: \(data.lastName)"
                self.UserNameLbl.text = "User Name: \(data.userName)"
                self.PasswordLbl.text = "Password: \(data.passwordProperty)"
                self.ConfirmPasswordLbl.text = "Confirm Password: \(data.confirmPasswordProperty)"
            }

            // Print information to the debugger console
            print("Data received and displayed successfully!")
        }
    }

    @IBAction func showMoreBtnTapped(_ sender: UIButton) {
        // You can add more actions or navigation logic here
        // For example, navigate to the third view controller
        navigateToThirdViewController()
    }

    func navigateToThirdViewController() {
        // Assuming you have a navigation controller
        if let thirdViewController = storyboard?.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
            // Pass the received data to the third view controller
            thirdViewController.receivedData = receivedData
            navigationController?.pushViewController(thirdViewController, animated: true)

            // Print navigation information to the debugger
            print("Navigated to ThirdViewController")
        } else {
            // Print an error message if navigation fails
            print("Error: Unable to instantiate ThirdViewController from storyboard.")
        }
    }
}
