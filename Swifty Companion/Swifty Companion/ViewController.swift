//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Jan-Hendrik HOON on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

	let apiController = APIController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		let scrollView = UIScrollView()
		let scrollStackView = UIStackView()
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollStackView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(scrollView)
		view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0.0).isActive = true
		scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
		scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0).isActive = true
		bottomLayoutGuide.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0.0).isActive = true
		
		self.automaticallyAdjustsScrollViewInsets = false //Very important for scroll view auto adjust breaks bounds.
		
		scrollStackView.axis = .vertical
		scrollStackView.alignment = .fill
		scrollStackView.distribution = .fill
		
		scrollView.addSubview(scrollStackView)
		scrollStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
		scrollStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
		scrollStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
		scrollStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
		scrollStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		
		let data = [["title": "Info", "infoLabels": [["type": "Wallet", "value": "20"], ["type": "email", "value": "derp@derp.com"]]], ["title": "Projects", "projectLabels": [["name": "Project1", "date": "20-06-2017", "mark": "100%"], ["name": "Project2", "date": "12-09-2017", "mark": "99%"]]]]
		for _ in 1...20 {
			for element in data {
				let _ = SectionComponent(values: element, container: scrollStackView)
			}
		}
	}

}

