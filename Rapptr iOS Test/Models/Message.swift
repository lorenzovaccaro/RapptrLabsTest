//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct Message {
    var userID: Int
    var username: String
    var avatarURL: URL?
    var text: String
    
    init(name: String, userID: Int, avatarURL: String, withMessage message: String) {
        self.userID = userID
        self.username = name
        self.avatarURL = URL(string: avatarURL)
        self.text = message
    }
}
