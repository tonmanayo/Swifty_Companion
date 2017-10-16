//
//  User.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import Foundation

struct User {
    let ID: int
    let email: String
    let login: String
    let firstName: String
    let lastName: String
    let url: URL?
    let location: String
    let profilePicture: Data
    let mobileNumber: Integer
    
    let profileLevel: Integer           //todo
    let Cursus: String = "WeThinkCode_"
    
    let wallet: Integer
    let correctionPoints: Integer
    let skills: [String:Integer]        // might need its own struct
    let projects: [String]              // might need its own struct
    
    init (data: NSDictionary?) {
        guard
            let login = data?.value(forKeyPath: IntraKey.login) as? String,
            let email = data?.value(forKeyPath: IntraKey.email) as? String
        else {
            return nil
            }
        
        let firstName = data?.value(forKeyPath: IntraKey.firstName) as? String ?? ""
        let lastName = data?.value(forKeyPath: IntraKey.lastName) as? String ?? ""
        let url = data?.value(forKeyPath: IntraKey.url) as? URL ?? ""
        let phone = data?.value(forKeyPath: IntraKey.mobileNumber) as? Integer ?? ""
        let location = data?.value(forKeyPath: IntraKey.location) as? String ?? ""
        let urlString = data?.value(forKeyPath: TwitterKey.ProfileImageURL) as? String ?? ""
        let profilePicture = (urlString.characters.count > 0) ? URL(string: urlString) : nil
        
        self.email = email
        self.login = login
        self.firstName = firstName
        self.lastName = lastName
        self.url = url
        self.location = location
        self.profilePicture = profilePicture
        self.mobileNumber = mobileNumber
        
        
           }
    
    struct IntraKey {
        static let ID = "id"
        static let login = "login"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let url = "url"
        static let email = "email"
        static let profilePicture = "image_url"
        static let profileLevel = ""                ///todo
        static let Cursus: String = "WeThinkCode_"
        static let mobileNumber = "phone"
        static let location = "location"
        static let wallet = ""
        static let correctionPoints = "correction_points"
        static let skills: [String:Integer]        // might need its own struct
        static let projects: [String]
    }
}
