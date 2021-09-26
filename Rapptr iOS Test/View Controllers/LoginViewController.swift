//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    private var client: LoginClient?
    
    // for timer
    private var timer: Timer?
    private var startTime: Double = 0
    private var time: Double = 0
    private var timerValue: Double = 0
    
    let dispatchGroup = DispatchGroup()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            .foregroundColor: UIColor(hexString: "#5F6063"),
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ])
        
        emailTextField.textColor = UIColor(hexString: "#1B1E1F")
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            .foregroundColor: UIColor(hexString: "#5F6063"),
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ])
        
        passwordTextField.textColor = UIColor(hexString: "#1B1E1F")
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        loginButton.backgroundColor = UIColor(hexString: "#0E5C89")
        loginButton.titleLabel?.tintColor = UIColor(hexString: "#FFFFFF")
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        // use LoginClient to login, but URL not working
        
        client = LoginClient()
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        var requestSuccess = true
        var alertTitle = ""
        var alertMessage = ""
        
        dispatchGroup.enter()
        
        let startDate = Date()
        self.client?.login(email: email, password: password, completion: { response in
            let executionTimeInMiliseconds = Date().timeIntervalSince(startDate) * 1000
            let executionTimeFormatted = String(format: "%.2f", executionTimeInMiliseconds)
            alertTitle = "Request Successful"
            alertMessage = "\(response)\nTime to execute: \(executionTimeFormatted)ms"
            requestSuccess = true
            self.dispatchGroup.leave()
            
        }, error: { error in
            alertTitle = "Request Failed"
            alertMessage = error ?? "Unknown Error"
            requestSuccess = false
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                self.alertActionHandler(requestSuccess: requestSuccess)
            }))
            
            
            self.present(alert, animated: true)
        }
    }
    
    private func alertActionHandler(requestSuccess: Bool){
        if(requestSuccess){
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
