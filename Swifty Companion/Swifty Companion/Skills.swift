//
//  Skills.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

struct Skills {

    let cursusID: Double

    
    init? (data: NSArray?) {
        guard
            let cursusID = data?.value(forKeyPath: IntraSkillsKey.cursusID) as? Double
            
            else {
                return nil
        }
        
        self.cursusID = cursusID
    }
    
    struct IntraSkillsKey {

        static let cursusID = "cursus_id"

    }
}
