//
//  ProjectCell.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/11/06.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProjectCell: BaseCell {
    var lblLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    var lblDetail: UILabel = {
        let detail = UILabel()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.textAlignment = .right
        detail.textColor = .gray
        detail.backgroundColor = .red
        return detail
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    override func setupViews() {
        addSubview(lblLabel)
        addSubview(separatorView)
        addSubview(lblDetail)
        
        lblLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        lblLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        lblLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        lblDetail.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lblDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        lblDetail.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.topAnchor.constraint(equalTo: lblLabel.bottomAnchor, constant: 20).isActive = true
    }

}
