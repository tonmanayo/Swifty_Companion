//
//  APIController.swift
//  Swifty Companion
//
//  Created by Jan-Hendrik HOON on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class APIController {
	
	var UID = "b5111590238005620faa8822ec94afebafe701b55e1732d429e1ce8cd774d158"
	var SECRET = "c59bd03db892b101ed77ce8e6f9b0668c8ff133d406d6c1fd60676afb9b46c28"
	var token: String?
	
	init() {
		self.getToken()
	}
	
	func getToken() {
		let tokenURL: URL = URL(string: "https://api.intra.42.fr/oauth/token")!

		let tokenParamater: Parameters = [
		"grant_type" : "client_credentials",
		"client_id" : UID,
		"client_secret" : SECRET
		]
		
		Alamofire.request(tokenURL, method: .post, parameters: tokenParamater).responseJSON(completionHandler: {
			response in
			
			let json = JSON(data: response.data!)
			self.token = json["access_token"].string
			print(self.token!)
			
		})
	}
	
}
