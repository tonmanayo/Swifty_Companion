//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Jan-Hendrik HOON on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UserControlDelegate {
	
	var apiController : APIController?
	override func viewDidLoad() {
		super.viewDidLoad()
		
		apiController = APIController.init(delegate: self)
		// Do any additional setup after loading the view, typically from a nib.
		
		//apiController.getToken()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func Go(_ sender: Any) {
		self.apiController?.getUserData("janhoon")
	}
	
	func displayUserInfo(user: User?) {
		print(user!.login)
	}

}
