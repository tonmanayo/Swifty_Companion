//
//  SearchUsers.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/20.
//  Copyright © 2017 janhoon. All rights reserved.
//

import Foundation

struct SearchUsers {
    let userID: Double
    let userLogin: String
    let userURL: URL
    
    init?(data: NSDictionary?) {
        guard
            let userID = data?.value(forKeyPath: "id") as? Double,
            let login = data?.value(forKeyPath: "login") as? String
            else {
                return nil
        }
        let userurl = data?.value(forKeyPath: "url") as? String ?? ""
        let url = (userurl.characters.count > 0) ? URL(string: userurl) : nil
        self.userID = userID
        self.userLogin = login
        self.userURL = url!
    }
}
