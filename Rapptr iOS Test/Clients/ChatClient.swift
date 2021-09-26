//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    
    var session: URLSession?
    var onFinishRequest: (([Message]) -> Void)?
    
    func fetchChatData(completion: @escaping ([Message]) -> Void, error errorHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php") else{
            fatalError("Error getting chat data")
        }
        
        onFinishRequest = completion
        var messages = [Message]()
        
        session = URLSession.shared
        session?.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dictionary = json as? [String: Any]{
                        
                        // the JSON is an array of dictionaries
                        if let arrayDictionaries = dictionary["data"] as? [Dictionary<String, Any>]{
                            
                            // These are the dictionaries we want
                            for nestedDictionary in arrayDictionaries{
                                
                                // name
                                guard let name = nestedDictionary["name"] as? String else{
                                    fatalError("Could not find name")
                                }
                                
                                // user id
                                guard let userIDString = nestedDictionary["user_id"] as? String else{
                                    fatalError("Could not find userID")
                                }
                                let userID = Int(userIDString)!
                                
                                // avatarURL
                                guard let avatarURL = nestedDictionary["avatar_url"] as? String else{
                                    fatalError("Could not find Avatar URL")
                                }
                                
                                // message
                                guard let messageString = nestedDictionary["message"] as? String else{
                                    fatalError("Could not find message")
                                }
                                
                                let message = Message(name: name, userID: userID, avatarURL: avatarURL, withMessage: messageString)
                                messages.append(message)
                            }
                        }

                    }
                    self.finishRequest(messages: messages)
                }catch{
                    
                }
            }
        }).resume()
        

    }
    
    func finishRequest(messages: [Message]){
        onFinishRequest?(messages)
    }

}
