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

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func Go(_ sender: Any) {
		self.apiController?.getUserData("tmack")
	}
    
    
	
    func displayUserInfo(user: User?, curriculum: Curriculum?) {
        
        let x:Double = (curriculum?.level)!.truncatingRemainder(dividingBy: 1)
        
        print(x)
        progressBar.progress = Float(x)
//		print(user!.login)
//        print(user!.firstName)
//        print(user!.lastName)
//        print(user!.wallet)
//        print(user!.mobileNumber)
//        print(user!.email)
//        print(user!.correctionPoints)
//       // print((user!.cursesUsers[1]))
//        print(user!.campusName)
//        print(curriculum!.skill[0].name)
//         print(curriculum!.skill[0].level)
//        print(curriculum!.curriculumName)
//        print(curriculum!.level)
//  
//        for project in user!.project {
//            if (project.ID == 48.0) {
//                print(project.name)
//            }
//            if (project.parentID == Double(48.0)) {
//                print(project.name)
//                print(project.mark)
//            }
//        }
       // print((user!.cursesUsers[0] as! NSDictionary).value(forKey: "cursus_id")!)
        // print(((user!.cursesUsers[1] as! NSDictionary).value(forKey: "cursus")! as! NSDictionary).value(forKey: "name")! as! String)
        //print(user!.)
        ///todo ill finish the api tomorrow
        
	}

}
