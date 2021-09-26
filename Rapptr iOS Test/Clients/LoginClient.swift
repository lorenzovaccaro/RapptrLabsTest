//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
 */

class LoginClient {
    
    var session: URLSession?
    //    private var url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")
    let stringURL = "http://dev.rapptrlabs.com/Tests/scripts/login.php"
    
    func login(email: String, password: String, completion: @escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void) {
        var components = URLComponents(string: stringURL)!
        
        let parameters = ["email" : email, "password": password]
        
        
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        print(components.percentEncodedQuery)
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        let request = URLRequest(url: components.url!)
        print(request)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // is there data
            guard let data = data else{
                errorHandler("No data.")
                return
            }
            
            // is there HTTP Response
            guard let response = response as? HTTPURLResponse else{
                errorHandler("No HTTP response.")
                return
            }
            
            // status code
            guard 200..<300 ~= response.statusCode else{
                
                // Could not get the URL to work, so I am just displaying this message
                var errorMessage = "Request failed. Status code \(response.statusCode). \nError message: "
                let json = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
                
                if let dictionary = json as? [String: Any]{
                    if let message = dictionary["message"] as? String {
                        errorMessage = errorMessage + message
                    }
                }
                
                errorHandler(errorMessage)
                return
            }
            
            guard error == nil else{
                errorHandler(error.debugDescription)
                return
            }
            
            // since i am not able to get the URL to work and see what the JSON would look like because
            // all i get is an "Invalid Parameters" message, there's nothing else i can do for this section
            let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            completion(responseObject?.description ?? "No response object")
            
        }
        task.resume()
    }
}
