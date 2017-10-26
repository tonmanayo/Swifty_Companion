//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by tony mack on 10/22/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet var lblNameSurname: UILabel!
    
    //var loading: UIActivityIndicatorView!
  
    //@IBOutlet var lblCorrrectionPoints: UILabel!
    //@IBOutlet var lblWallet: UILabel!
    
    var collectionView: UICollectionView!
    
    var profilePicView = UIImageView(image: #imageLiteral(resourceName: "loading"))
    
    let coverImage: UIImageView = {
        let coverView = UIImageView(image: #imageLiteral(resourceName: "code-guide-callout"))
        coverView.translatesAutoresizingMaskIntoConstraints = false
        return coverView
    }()
    
    private var profilePic: UIImage? {
        get {
            return profilePicView.image
        }
        set {
            // loading?.stopAnimating()
            profilePicView.image = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        
        
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.white
       // self.view.addSubview(collectionView)
        view.addSubview(coverImage)
        view.addSubview(profilePicView)
        
        
        profilePicView.translatesAutoresizingMaskIntoConstraints = false

        setupLayout()
        
    }
    
    private func setupLayout(){
        
        
        
        coverImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        coverImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        coverImage.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        coverImage.heightAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        
        profilePicView.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: -coverImage.frame.height).isActive = true
        profilePicView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePicView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        profilePicView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSizeMake(view.frame.width, 200)
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    // MARK - IMAGE
 
    
  
    
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
            navigationItem.title = userData?.login
         //   self.lblNameSurname.text = (userData?.firstName)! + " " + (userData?.lastName)!
          //  self.lblWallet.text = "Wallet: " + String(format: "%.0f", (userData?.wallet)!)
          //  self.lblCorrrectionPoints.text = "Correction points: " + String(format: "%.0f", (userData?.correctionPoints)!)

        }
    }
    
    
    private func fetchProfilePic() {
        if let url = profilePicURL {
         //   loading.startAnimating()
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
