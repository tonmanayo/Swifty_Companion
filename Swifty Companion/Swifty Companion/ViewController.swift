//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Jan-Hendrik HOON on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UserControlDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{

	var apiController : APIController?
    
    var userNames:[SearchUsers]? = []
    var userData:User = User()
    var user:String = ""
    var shouldShowSearchResults:Bool = false
    
    @IBOutlet weak var tableView: UITableView!

    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        //searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchController
    }()
    
    func configureSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter Username"
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		apiController = APIController.init(delegate: self)
        configureSearchController()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        self.apiController?.getUserNames(searchText: searchController.searchBar.text!)  {responseObject, error in
            if (responseObject?.count == 0) {
                print("No Users Found")
                return
            }
            self.userNames = responseObject!
            if (responseObject?.count == 1) {
                self.user = responseObject![0].userLogin
            }
            for name in responseObject! {
                print(name.userLogin)
            }
            self.tableView.reloadData()
        }
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.userNames?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell     {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell
        if (userNames?.isEmpty == false) {
        cell?.lblUserName.text = self.userNames![indexPath.row].userLogin
    }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.apiController?.getUserData(loginID: self.userNames![indexPath.row].userID) {responseObject, error in
            if (responseObject?.count == 0) {
                print("No Users Found")
                return
            }
            self.userData = User(data: responseObject as NSDictionary?)!
            print(self.userData.campusName)
        }
        //self.userData = userNames![indexPath.row]
     
    }
    
    
    func displayUserInfo(user: User?, curriculum: Curriculum?) {
        
        let x:Double = (curriculum?.level)!.truncatingRemainder(dividingBy: 1)
        
        print(x)

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

