//
//  ProjectsComponent.swift
//  Swifty Companion
//
//  Created by Victor Verdun VAN DER WATT on 2017/10/18.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProjectsComponent: UIStackView {

	init(values: [String: Any], container: UIStackView) {
		super.init(frame: CGRect.init())
		self.heightAnchor.constraint(equalToConstant: 30).isActive = true
		createProjectComponent(values: values)
		container.addArrangedSubview(self)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func createProjectComponent(values: [String: Any]) {
		let name = UILabel()
		let	date = UILabel()
		let mark = UILabel()
		let innerStack = UIStackView()
		
		name.text = values["name"] as? String
		date.text = values["date"] as? String
		mark.text = values["mark"] as? String
		
		mark.textAlignment = NSTextAlignment.right
		
		innerStack.distribution = .fillProportionally
		
		innerStack.addArrangedSubview(name)
		innerStack.addArrangedSubview(date)
		self.addArrangedSubview(innerStack)
		self.addArrangedSubview(mark)
	}

}
