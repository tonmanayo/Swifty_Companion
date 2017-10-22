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
		let mark = UILabel()
		
		name.translatesAutoresizingMaskIntoConstraints = false
		mark.translatesAutoresizingMaskIntoConstraints = false
		
		name.text = String(describing: values["name"]!)
		mark.text = String(describing: values["mark"]!) + "%"
		
		mark.textAlignment = NSTextAlignment.right

		self.addSubview(name)
		self.addSubview(mark)
		
		name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
		name.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
		name.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
		mark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
		mark.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
		mark.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
	}

}
