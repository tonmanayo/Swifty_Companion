//
//  ProjectsComponent.swift
//  Swifty Companion
//
//  Created by Victor Verdun VAN DER WATT on 2017/10/18.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProjectsComponent: UIView {

	init(values: [String: Any], container: UIStackView) {
		super.init(frame: CGRect.init())
		self.heightAnchor.constraint(equalToConstant: 30).isActive = true
		createProjectComponent(values: values)
		container.addArrangedSubview(self)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func createProjectComponent(values: [String: Any]) {
		let name = UILabel()
		let	date = UILabel()
		let mark = UILabel()
		let innerStack = UIStackView()
		
		name.translatesAutoresizingMaskIntoConstraints = false
		date.translatesAutoresizingMaskIntoConstraints = false
		mark.translatesAutoresizingMaskIntoConstraints = false
		innerStack.translatesAutoresizingMaskIntoConstraints = false
		
		name.text = values["name"] as? String
		date.text = values["date"] as? String
		mark.text = values["mark"] as? String
		
		mark.textAlignment = NSTextAlignment.right
		
		innerStack.distribution = .fillProportionally
		innerStack.spacing = 5
		
		innerStack.addArrangedSubview(name)
		innerStack.addArrangedSubview(date)
		self.addSubview(innerStack)
		self.addSubview(mark)
		
		innerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
		innerStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
		innerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
		mark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
		mark.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
		mark.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
	}

}
