//
//  User.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit
//import SwiftyJSON

struct User {
    let ID: Double
    let email: String
    let login: String
    let firstName: String
    let lastName: String
    let url: URL?
    let location: String
    let profilePicture: URL?
    let mobileNumber: Double
    let wallet: Double
    
    //let profileLevel: Double           //todo
    //let Cursus: String = "WeThinkCode_"
    

    //let correctionPoints: Double
    //let skills: [String:Double]        // might need its own struct
    //let projects: [String]              // might need its own struct
    
    init? (data: NSDictionary?) {
        guard
            let ID = data?.value(forKeyPath: IntraKey.ID) as? Double,
            let login = data?.value(forKeyPath: IntraKey.login) as? String,
            let email = data?.value(forKeyPath: IntraKey.email) as? String
        else {
            return nil
            }
        
     //   let urlString = data?.value(forKeyPath: IntraKey.url) as? String ?? ""
       // self.profileImageURL = (urlString.characters.count > 0) ? URL(string: urlString) : nil
        
        let firstName = data?.value(forKeyPath: IntraKey.firstName) as? String ?? ""
        let lastName = data?.value(forKeyPath: IntraKey.lastName) as? String ?? ""
        let userurl = data?.value(forKeyPath: IntraKey.url) as? String ?? ""
        let url = (userurl.characters.count > 0) ? URL(string: userurl) : nil
        let location = data?.value(forKeyPath: IntraKey.location) as? String ?? ""
        let urlString = data?.value(forKeyPath: IntraKey.profilePicture) as? String ?? ""
        let profilePicture = (urlString.characters.count > 0) ? URL(string: urlString) : nil
        let mobilePhone = data?.value(forKeyPath: IntraKey.mobileNumber) as? Double ?? 0
        let wallet =  data?.value(forKeyPath: IntraKey.wallet) as? Double ?? 0
        
        self.ID = ID
        self.email = email
        self.login = login
        self.firstName = firstName
        self.lastName = lastName
        self.url = url
        self.location = location
        self.profilePicture = profilePicture
        self.mobileNumber = mobilePhone
        self.wallet = wallet
        
        
           }
    
    struct IntraKey {
        static let ID = "id"
        static let login = "login"
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let url = "url"
        static let email = "email"
        static let profilePicture = "image_url"
        //static let profileLevel = ""                ///todo
        //static let Cursus: String = "WeThinkCode_"
        static let mobileNumber = "phone"
        static let location = "location"
        static let wallet = "wallet"
        //static let correctionPoints = "correction_points"
        //static let skills: [String:Double]        // might need its own struct
        //static let projects: [String]
    }
}
