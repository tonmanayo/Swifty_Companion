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
	weak var delegate: UserControlDelegate?
	
	init(delegate: UserControlDelegate) {
		self.delegate = delegate
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
		})
	}
    
    func userNamesRequest(login: String, completionHandler: @escaping ([SearchUsers]?, Error?) -> ()) {
        let IdURL = URL(string: "https://api.intra.42.fr/v2/users?search[login]=\(login)")!
        var IdRequest = URLRequest(url: IdURL)
          if (self.token?.isEmpty == false) {
            IdRequest.addValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization")
            Alamofire.request(IdRequest).responseJSON(completionHandler: {
                response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value).arrayObject
                    var users: [SearchUsers] = []
                    for new in json! {
                        users.append(SearchUsers(data: (new as! NSDictionary))!)
                    }
                    completionHandler(users, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
            })
        }
    }
    
    func getUserNames(searchText:String, completionHandler: @escaping ([SearchUsers]?, Error?) -> ()) {
        userNamesRequest(login: searchText, completionHandler: completionHandler)
    }
	
    func userDataRequest(loginID: Double, completionHandler: @escaping ([String : Any]?, Error?) -> ()) {

        let DataURL = URL(string: "https://api.intra.42.fr/v2/users/\(String(format: "%.0f", loginID))")!
        var DataRequest = URLRequest(url: DataURL)
        DataRequest.addValue("Bearer \(self.token!)", forHTTPHeaderField: "Authorization")

        Alamofire.request(DataRequest).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).dictionaryObject
                //let user = User(data: json as NSDictionary?)
                completionHandler(json, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
           // let curriculum = Curriculum(data: user!.cursesUsers[0] as? NSDictionary)
        })
    }
    
    func getUserData(loginID:Double, completionHandler: @escaping ([String : Any]?, Error?) -> ()) {
        userDataRequest(loginID: loginID, completionHandler: completionHandler)
    }
	
}
