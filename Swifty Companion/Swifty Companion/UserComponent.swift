//
//  UserComponent.swift
//  Swifty Companion
//
//  Created by Victor Verdun VAN DER WATT on 2017/10/19.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class UserComponent: UIStackView {

	init(values: [String: Any], container: UIStackView) {
		super.init(frame: CGRect.init())
		self.spacing = 20
		createUserComponent(values: values)
		container.addArrangedSubview(self)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func createUserComponent(values: [String: Any]) {
		let userImageView = UIImageView(image: UIImage(named: "profile"))
		let usernameLabel = UILabel()
		let progressBar = UIView()
		let infoStack = UIStackView()
		
		userImageView.translatesAutoresizingMaskIntoConstraints = false
		usernameLabel.translatesAutoresizingMaskIntoConstraints = false
		progressBar.translatesAutoresizingMaskIntoConstraints = false
		infoStack.translatesAutoresizingMaskIntoConstraints = false
		
		userImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
		userImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
		userImageView.layer.borderWidth = 8
		userImageView.layer.borderColor = UIColor(white: 1, alpha: 0).cgColor
		userImageView.layer.masksToBounds = false
		userImageView.layer.cornerRadius = 50
		userImageView.clipsToBounds = true
		
		usernameLabel.text = "\(values["name"]!) - \(values["loginName"]!)"
		usernameLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
		
		progressBar.backgroundColor = UIColor.lightGray
		progressBar.heightAnchor.constraint(equalToConstant: 35).isActive = true
		
		infoStack.axis = .vertical
		infoStack.addArrangedSubview(usernameLabel)
		infoStack.addArrangedSubview(progressBar)
		
		self.addArrangedSubview(userImageView)
		
		userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		self.addArrangedSubview(infoStack)
	}

}
