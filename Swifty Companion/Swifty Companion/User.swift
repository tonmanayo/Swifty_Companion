//
//  User.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import Foundation

struct User {
    let intraName: String
    let name: String
    let surname: String
    let email: String
    let profilePicture: Data
    let profileLevel: Integer
    let Cursus: String = "WeThinkCode_"
    let mobile: Integer
    let location: String
    let wallet: Integer
    let correctionPoints: Integer
    let skills: [String:Integer]        // might need its own struct
    let projects: [String]              // might need its own struct
}
