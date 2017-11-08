//
//  StatsCells.swift
//  Swifty Companion
//
//  Created by tony mack on 11/7/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

import DDSpiderChart

class StatsCells:BaseCell {
    var check:Bool = false
    var skills:[Curriculum.eSkills]? {
        didSet {
            if (skills?.isEmpty == false && check == false){
                var names:[String] = []
                var level:[Float] = []
                
                for skill in skills! {
                    names.append(skill.name)
                    level.append(Float(String(format: "%.1f", skill.level))! / 30)
                }
                spiderChartView.axes = names
                spiderChartView.addDataSet(values: level, color: .red)
                check = true
            }
        }
    }
    
    lazy var spiderChartView:DDSpiderChartView = {
        let chart = DDSpiderChartView(frame: self.frame)
        chart.circleCount = 4
        chart.circleGap = 30
        chart.backgroundColor = .white
        
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = .white
        addSubview(spiderChartView)
        
        spiderChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        spiderChartView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        spiderChartView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        spiderChartView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0).isActive = true
        
    }
}
