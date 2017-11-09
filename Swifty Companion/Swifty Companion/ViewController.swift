//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Jan-Hendrik HOON on 2017/10/16.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController,
UITableViewDelegate,
UITableViewDataSource,
UISearchResultsUpdating,
UISearchBarDelegate,
UISplitViewControllerDelegate
{
    
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
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barTintColor = UIColor(red: 95 / 255, green: 111 / 255, blue: 111 / 255, alpha: 1)
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
        navigationItem.title = "Search for username"
        navigationController?.navigationBar.barTintColor = UIColor(red: 176 / 255, green: 192 / 255, blue: 207 / 255, alpha: 1)

		apiController = APIController.init()
        configureSearchController()

        navigationController?.hidesBarsOnSwipe = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.apiController?.getUserNames(searchText: searchController.searchBar.text!)  {[weak self] responseObject, error in
                if (searchText == searchController.searchBar.text) {
                    if (responseObject?.count == 0 || (responseObject == nil)) {
                        print("No Users Found")
                        return
                    }
                    self?.userNames = responseObject!
                    DispatchQueue.main.async {
                         self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    // MARK: - searchBar
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
        searchController.isActive = false
    }
    
    // MARK: - Segway
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
                DispatchQueue.main.async {
                    profileViewController.collectionView.reloadData()
                }
                if (self?.userData?.profilePicture?.absoluteString == "https://cdn.intra.42.fr/images/default.png") {
                    profileViewController.profilePicURL =  URL(string: "http://clipart-library.com/image_gallery/267356.png")
                } else {
                    profileViewController.profilePicURL = self?.userData?.profilePicture
                }
            }
        }
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

