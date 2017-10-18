//
//  User.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

struct User {
    
    struct Projects {
        var name: String
        var parentID: Double
        var ID: Double
        var curriculumID: Double
        var mark: Double
        var status: String
        var validated: Double
    }
    
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
    let campusName: String
    
    var project: [Projects] = []
    
    let cursesUsers: NSArray
   // let userProjects: NSArray

    
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
        
        let campus = data?.arrayForKeyPath("campus")
        let campusName = (campus![0] as? NSDictionary ?? nil)?.value(forKey: "name") as? String ?? ""
        
        
        let cursesUsers = data?.arrayForKeyPath(IntraKey.cursusUsers)
        let userProjects = data?.value(forKeyPath: IntraKey.userProjects) as! [NSDictionary]
        
        for var i in 0..<userProjects.count {
            let tmpProject:Projects = Projects(name: (userProjects[i].value(forKeyPath: "project") as? NSDictionary ?? nil)?.value(forKeyPath: "name") as? String ?? "",
                                               parentID: (userProjects[i].value(forKeyPath: "project") as? NSDictionary ?? nil)?.value(forKeyPath: "parent_id") as? Double ?? 0,
                                               ID: (userProjects[i].value(forKeyPath: "project") as? NSDictionary ?? nil)?.value(forKeyPath: "id") as? Double ?? 0,
                                               curriculumID: userProjects[i].value(forKeyPath: "cursus_ids") as? Double ?? 0,
                                               mark: userProjects[i].value(forKeyPath: "final_mark") as? Double ?? 0,
                                               status: userProjects[i].value(forKeyPath: "status") as? String ?? "",
                                               validated: userProjects[i].value(forKeyPath: "validated?") as? Double ?? 0)
            self.project.append(tmpProject)
            i += 1
        }
        
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
        self.campusName = campusName
        
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
        static let userProjects = "projects_users"
    }
}

extension NSDictionary {
    func arrayForKeyPath(_ keypath: String) -> NSArray? {
        return self.value(forKeyPath: keypath) as? NSArray ?? nil
    }
}
