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
		
		scrollStackView.axis = .vertical
		scrollStackView.alignment = .fill
		scrollStackView.distribution = .fill
		
		scrollView.addSubview(scrollStackView)
		scrollStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
		scrollStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
		scrollStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
		scrollStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
		scrollStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		
		for x in 1...20 {
			let sectionView: UIStackView = SectionComponent(title: String(x))
			scrollStackView.addArrangedSubview(sectionView)
		}
	}

}

