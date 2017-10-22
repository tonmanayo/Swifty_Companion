//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by tony mack on 10/22/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var profilePicView: UIImageView!
    
    private var profilePic: UIImage? {
        get {
            return profilePicView.image
        }
        set {
            loading?.stopAnimating()
            profilePicView.image = newValue
            profilePicView.sizeToFit()
        }
    }
    
    var profilePicURL:URL? {
        didSet {
            profilePic = nil
            if view.window != nil {
                fetchProfilePic()
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
