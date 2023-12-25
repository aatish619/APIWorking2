//
//  FirstViewController.swift
//  APIWorking2
//
//  Created by Aatish Mehta on 12/22/23.
//

import UIKit

struct User: Codable {
    let firstName: String
    let lastName: String
    let userName: String
    let password: String
    let confirmPassword: String
}

class FirstViewController: UIViewController {

    @IBOutlet var FirstNameTxt: UITextField!
    @IBOutlet var LastNameTxt: UITextField!
    @IBOutlet var UserNameTxt: UITextField!
    @IBOutlet var PasswordTxt: UITextField!
    @IBOutlet var ConfirmPasswordTxt: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "First View"
    }

    @IBAction func submitBtnTapped(_ sender: UIButton) {
        // Check if all required fields are filled
        guard let firstName = FirstNameTxt.text,
              let lastName = LastNameTxt.text,
              let userName = UserNameTxt.text,
              let password = PasswordTxt.text,
              let confirmPassword = ConfirmPasswordTxt.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !userName.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }

        // Check if passwords match
        guard password == confirmPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }

        // Create a User object
        let user = User(firstName: firstName, lastName: lastName, userName: userName, password: password, confirmPassword: confirmPassword)

        // Call a function to send data to the API
        sendDataToAPI(user: user)
    }

    func sendDataToAPI(user: User) {
        // Replace this URL with the actual API endpoint you want to use
        let apiUrl = "https://jsonplaceholder.typicode.com/posts"

        // Create a URLSession
        let session = URLSession.shared

        // Create a URL object
        if let url = URL(string: apiUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                // Use JSONEncoder to encode the User object
                request.httpBody = try JSONEncoder().encode(user)
            } catch {
                showAlert(message: "Error encoding JSON data: \(error)")
                return
            }

            // Create a data task
            let task = session.dataTask(with: request) { [self] (data, response, error) in
                // Handle the response as needed
                if let error = error {
                    showAlert(message: "Error: \(error)")
                    return
                }

                if let data = data {
                    // Parse the response JSON using the ResponseData struct
                    do {
                        let jsonResponse = try JSONDecoder().decode(ResponseData.self, from: data)
                        print("Response JSON: \(jsonResponse)")

                        // Assuming you want to navigate to the SecondViewController
                        DispatchQueue.main.async {
                            self.navigateToSecondView(with: jsonResponse)
                        }
                    } catch {
                        showAlert(message: "Error parsing response JSON: \(error)")
                    }
                }
            }

            // Resume the task
            task.resume()
        }
    }

    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func navigateToSecondView(with data: ResponseData) {
        // Assuming you have a navigation controller
        if let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            secondViewController.receivedData = data
            navigationController?.pushViewController(secondViewController, animated: true)

            // Print a success message to the debugger
            print("Navigated to SecondViewController with data.")
        }

    }
}
