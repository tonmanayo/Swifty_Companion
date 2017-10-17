//
//  User.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

struct User {
    let ID: Double
    let email: String
    let login: String
    let firstName: String
    let lastName: String
    let url: URL?
    let profilePicture: URL? //not done
    let mobileNumber: String
    let wallet: Double
    let correctionPoints: Double
    
    let cursesUsers: NSArray

    
    init? (data: NSDictionary?) {
        guard
            let ID = data?.value(forKeyPath: IntraKey.ID) as? Double,
            let login = data?.value(forKeyPath: IntraKey.login) as? String,
            let email = data?.value(forKeyPath: IntraKey.email) as? String
        else {
            return nil
            }
        
        let firstName = data?.value(forKeyPath: IntraKey.firstName) as? String ?? ""
        let lastName = data?.value(forKeyPath: IntraKey.lastName) as? String ?? ""
        let userurl = data?.value(forKeyPath: IntraKey.url) as? String ?? ""
        let url = (userurl.characters.count > 0) ? URL(string: userurl) : nil
 
        let urlString = data?.value(forKeyPath: IntraKey.profilePicture) as? String ?? ""
        let profilePicture = (urlString.characters.count > 0) ? URL(string: urlString) : nil
        let mobileNumber = data?.value(forKeyPath: IntraKey.mobileNumber) as? String ?? ""
        let wallet =  data?.value(forKeyPath: IntraKey.wallet) as? Double ?? 0
        let correctionPoints =  data?.value(forKeyPath: IntraKey.correctionPoints) as? Double ?? 0
        
        let cursesUsers = data?.arrayForKeyPath(IntraKey.cursusUsers)
        
        self.ID = ID
        self.email = email
        self.login = login
        self.firstName = firstName
        self.lastName = lastName
        self.url = url
        self.mobileNumber = mobileNumber
        self.wallet = wallet
        self.correctionPoints = correctionPoints
        self.cursesUsers = cursesUsers!
        
        self.profilePicture = profilePicture

           }
    
    struct IntraKey {
        static let ID = "id"
        static let login = "login"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let url = "url"
        static let email = "email"
        static let profilePicture = "image_url"
        static let mobileNumber = "phone"
        static let wallet = "wallet"
        static let cursusUsers = "cursus_users"
        static let correctionPoints = "correction_point"
    }
}

extension NSDictionary {
    func arrayForKeyPath(_ keypath: String) -> NSArray? {
        return self.value(forKeyPath: keypath) as? NSArray ?? nil
    }
}
