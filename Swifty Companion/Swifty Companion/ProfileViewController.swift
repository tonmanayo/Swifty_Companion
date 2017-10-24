//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by tony mack on 10/22/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var lblNameSurname: UILabel!
    
    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var profilePicView: UIImageView!
    
    private var profilePic: UIImage? {
        get {
            return profilePicView.image
        }
        set {
            loading?.stopAnimating()
            profilePicView.image = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var profilePicURL:URL? {
        didSet {
            profilePic = nil
            if view.window != nil {
                fetchProfilePic()
            }
        }
    }
    
  
    
    var userData:User? {
        didSet {
            self.lblNameSurname.text = (userData?.firstName)! + " " + (userData?.lastName)!
        }
    }
    
    
    private func fetchProfilePic() {
        if let url = profilePicURL {
            loading.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {  [weak self] in
                let urlContent = try? Data(contentsOf: url)
                if let imageData = urlContent, self?.profilePicURL == url {
                    DispatchQueue.main.async {
                        self?.profilePic = UIImage(data: imageData)
                    }
                }
            }
            
        }
    }
}
