//
//  Skills.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit



struct Skills {
    
    struct eSkills {
        var level: Double
        var name: String
    }

    let cursusID: Double
    let curriculum: String
    let skills: [NSDictionary]
    var skill: Array<eSkills> = []

    
    init? (data: NSDictionary?) {
        guard
            let cursusID = data?.value(forKeyPath: IntraSkillsKey.cursusID) as? Double
            else {
                return nil
        }
        let curriculum = (data?.value(forKeyPath: "cursus") as! NSDictionary).value(forKeyPath: IntraSkillsKey.curriculum) as! String
        let skills = data?.value(forKeyPath: IntraSkillsKey.skills) as! [NSDictionary]
        
        for var i in 0..<skills.count{
            let new:eSkills = eSkills(level: skills[i].value(forKey: "level") as! Double, name: skills[i].value(forKey: "name") as! String)
            self.skill.append(new)
         i += 1
        }
        
        self.curriculum = curriculum
        self.skills = skills
        
        self.cursusID = cursusID
    }
    
    struct IntraSkillsKey {

        static let cursusID = "cursus_id"
        static let curriculum = "name"
        static let skills = "skills"

    }
}
