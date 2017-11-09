//
//  Skills.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit



struct Curriculum {
    
    struct eSkills {
        var level: Float
        var name: String
    }

    let curriculumID: Double
    let curriculumName: String
    private let skills: [NSDictionary]
    var skill: [eSkills] = []
    let level: Double
    
    init? (data: NSDictionary?) {
        guard
            let curriculumID = data?.value(forKeyPath: IntraSkillsKey.curriculumID) as? Double
            else {
                return nil
        }
        let level = data?.value(forKey: IntraSkillsKey.level) as? Double ?? 0
        let curriculumName = (data?.value(forKeyPath: "cursus") as? NSDictionary ?? nil)?.value(forKeyPath: IntraSkillsKey.curriculumName) as? String ?? ""
        let skills = data?.value(forKeyPath: IntraSkillsKey.skills) as! [NSDictionary]
        
        for lSkill in skills{
            let new:eSkills = eSkills(level: lSkill.value(forKey: "level") as? Float ?? 0, name: lSkill.value(forKey: "name") as? String ?? "")
            self.skill.append(new)
        }
        
        self.level = level
        self.curriculumName = curriculumName
        self.skills = skills
        self.curriculumID = curriculumID
    }
    
    struct IntraSkillsKey {
        static let curriculumID = "cursus_id"
        static let curriculumName = "name"
        static let skills = "skills"
        static let level = "level"
    }
}
