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
	
	@IBOutlet weak var button: UIButton!
	
	
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
		self.apiController?.getUserData("adippena")
	}
    
    
	
    func displayUserInfo(user: User?, curriculum: Curriculum?) {
        
//        let x:Double = (curriculum?.level)!.truncatingRemainder(dividingBy: 1)
//        
//        print(x)
//        progressBar.progress = Float(x)
//		progressBar.isHidden = true
//		button.isHidden = true
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
		
		progressBar.isHidden = true
		button.isHidden = true
		
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

//		let data = [["title": "Info", "infoLabels": [["type": "Wallet", "value": "20"], ["type": "email", "value": "derp@derp.com"]]], ["title": "Projects", "projectLabels": [["name": "Project1", "date": "20-06-2017", "mark": "100%"], ["name": "Project2", "date": "12-09-2017", "mark": "99%"]]]]
		
		let userProfile = ["name": user!.firstName + user!.lastName, "loginName": user!.login]
		let userInfo = [["type": "Wallet", "value": user!.wallet], ["type": "Mobile", "value": user!.mobileNumber], ["type": "Email", "value": user!.email], ["type": "Correction Points", "value": user!.correctionPoints], ["type": "Campus", "value": user!.campusName]]
		var userProjects = [Dictionary<String, Any>]()
		
		for project in user!.project {
			if (project.parentID == 0.0 && !project.name.contains("Day") && !project.name.contains("Colle")) {
				userProjects.append(["name": project.name, "mark": project.mark])
				print(project)
			}
		}
		
		let sectionComp = [["title": "Info", "infoLabels": userInfo], ["title": "Projects", "projectLabels": userProjects]]

		
		let _ = UserComponent(values: userProfile, container: scrollStackView)

		for element in sectionComp {
			let _ = SectionComponent(values: element, container: scrollStackView)
		}
		
	}
}
