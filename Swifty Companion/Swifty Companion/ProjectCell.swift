//
//  ProjectCell.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/11/06.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProjectCell: BaseCell {
    var lblProjectName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    var lblStatus: UILabel = {
        let detail = UILabel()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.textAlignment = .right
        detail.textColor = .gray
        return detail
    }()
    
    var lblmark: UILabel = {
        let detail = UILabel()
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.textAlignment = .center
        detail.textColor = .gray
        return detail
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    var imgValidated: CustomUIImageView = {
        let imageView = CustomUIImageView(image: #imageLiteral(resourceName: "redCircle"))

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
   
    override func setupViews() {
      
        
        let stackView = UIStackView(arrangedSubviews: [lblProjectName, lblmark, lblStatus])
        
        addSubview(imgValidated)
        addSubview(stackView)
        addSubview(separatorView)
        
        imgValidated.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgValidated.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        imgValidated.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        imgValidated.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        stackView.leadingAnchor.constraint(equalTo: imgValidated.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }

}
