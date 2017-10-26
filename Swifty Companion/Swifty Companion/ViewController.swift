//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Jan-Hendrik HOON on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UserControlDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISplitViewControllerDelegate{
    

	var apiController : APIController?
    
    var userNames:[SearchUsers]? = []
    var userData:User? = User()
    var shouldShowSearchResults:Bool = false
    var userIndex:Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool
    {
        if primaryViewController.contents == self,
            let ivc = secondaryViewController.contents as? ProfileViewController
        {
            return ivc.profilePicURL == nil
        }
        return false
    }

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
        if let searchText = searchController.searchBar.text {
            self.apiController?.getUserNames(searchText: searchController.searchBar.text!)  {[weak self] responseObject, error in
                if (searchText == searchController.searchBar.text) {
                    if (responseObject?.count == 0) {
                        print("No Users Found")
                        return
                    }
                    self?.userNames = responseObject!
                    for name in responseObject! {
                        print(name.userLogin)
                    }
                    DispatchQueue.main.async {
                         self?.tableView.reloadData()
                    }
                }
            }
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
        userIndex = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        userIndex = (tableView.indexPathForSelectedRow?.row)!
        if let profileViewController = segue.destination.contents as? ProfileViewController {
            self.apiController?.getUserData(loginID: self.userNames![userIndex].userID) {[weak self] responseObject, error in
                    if (responseObject?.count == 0) {
                        print("No Users Found")
                        return
                    }
                self?.userData = User(data: responseObject as NSDictionary?)!
                profileViewController.userData = self?.userData
                if (self?.userData?.profilePicture?.absoluteString == "https://cdn.intra.42.fr/images/default.png") {
                    profileViewController.profilePicURL =  URL(string: "http://clipart-library.com/image_gallery/267356.png")
                } else {
                    profileViewController.profilePicURL = self?.userData?.profilePicture
                }
            }
        }
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

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}

