//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by tony mack on 10/22/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    
    //var loading: UIActivityIndicatorView!
    
    var collectionView: UICollectionView!
    
    let lblWallet: UILabel = {
        let wallet = UILabel(frame: CGRect.zero)
        wallet.textAlignment = .center
        wallet.text = "Wallet"
        wallet.font = UIFont.systemFont(ofSize: 12)
        wallet.textColor = UIColor.gray
        wallet.translatesAutoresizingMaskIntoConstraints = false
        return wallet
    }()
    
    let lblCorrectionPoints: UILabel = {
        let correctionPoints = UILabel(frame: CGRect.zero)
        correctionPoints.textAlignment = .center
        correctionPoints.text = "Correction Points: "
        correctionPoints.font = UIFont.boldSystemFont(ofSize: 12)
        correctionPoints.adjustsFontSizeToFitWidth = true
        correctionPoints.textColor = UIColor.gray
        correctionPoints.translatesAutoresizingMaskIntoConstraints = false
        return correctionPoints
    }()
    
    let profilePicView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "loading"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let coverImage: UIImageView = {
        let coverView = UIImageView(image: #imageLiteral(resourceName: "code-guide-callout"))
        coverView.translatesAutoresizingMaskIntoConstraints = false
        return coverView
    }()
    
    let lblNameSurname: UILabel = {
        let nameSurname = UILabel(frame: CGRect.zero)
        nameSurname.textAlignment = .center
        nameSurname.text = "userName"
        nameSurname.font = UIFont.boldSystemFont(ofSize: 20)
        nameSurname.translatesAutoresizingMaskIntoConstraints = false
        return nameSurname
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
     


        //setupLayout()
     
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setupLayout()
    }
    
    private func setupLayout(){
        
        let topContainter = UIView()
        view.addSubview(topContainter)

        topContainter.backgroundColor = .blue
        
        topContainter.translatesAutoresizingMaskIntoConstraints = false
        topContainter.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        topContainter.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        //instead of left and right
        topContainter.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainter.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topContainter.addSubview(coverImage)
        topContainter.addSubview(profilePicView)
        topContainter.addSubview(lblNameSurname)
        topContainter.addSubview(lblCorrectionPoints)
        topContainter.addSubview(lblWallet)


        coverImage.topAnchor.constraint(equalTo: topContainter.topAnchor).isActive = true
        coverImage.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        coverImage.trailingAnchor.constraint(equalTo: topContainter.trailingAnchor).isActive = true
        coverImage.heightAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true
        
        profilePicView.centerXAnchor.constraint(equalTo: topContainter.centerXAnchor).isActive = true
        profilePicView.centerYAnchor.constraint(equalTo: topContainter.centerYAnchor).isActive = true
        profilePicView.heightAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true
        profilePicView.widthAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true


        lblNameSurname.topAnchor.constraint(equalTo: profilePicView.bottomAnchor, constant: 5).isActive = true
        lblNameSurname.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        lblNameSurname.trailingAnchor.constraint(equalTo: topContainter.trailingAnchor).isActive = true
        lblNameSurname.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //top
        NSLayoutConstraint(item: lblCorrectionPoints, attribute: .top, relatedBy: .equal, toItem: coverImage, attribute: .bottom, multiplier: 1, constant: profilePicView.frame.height / 8).isActive = true
//        //left constraint
        NSLayoutConstraint(item: lblCorrectionPoints, attribute: .left, relatedBy: .equal, toItem: coverImage, attribute: .left, multiplier: 1, constant: 8).isActive = true
//        //right constraint
        NSLayoutConstraint(item: lblCorrectionPoints, attribute: .centerX, relatedBy: .equal, toItem: coverImage, attribute: .centerX, multiplier: 1, constant: self.view.frame.width / 3).isActive = true
        //height constraint
        NSLayoutConstraint(item: lblCorrectionPoints, attribute: .height, relatedBy: .equal, toItem: lblCorrectionPoints, attribute: .height, multiplier: 0, constant: 20).isActive = true
        //wallet
        NSLayoutConstraint(item: lblWallet, attribute: .top, relatedBy: .equal, toItem: coverImage, attribute: .bottom, multiplier: 1, constant: profilePicView.frame.height / 8).isActive = true
        //        //left constraint
        NSLayoutConstraint(item: lblWallet, attribute: .left, relatedBy: .equal, toItem: coverImage, attribute: .left, multiplier: 1, constant: 8).isActive = true
        //        //right constraint
        NSLayoutConstraint(item: lblWallet, attribute: .centerX, relatedBy: .equal, toItem: coverImage, attribute: .centerX, multiplier: 1, constant: -self.view.frame.width / 3).isActive = true
        //height constraint
        NSLayoutConstraint(item: lblWallet, attribute: .height, relatedBy: .equal, toItem: lblCorrectionPoints, attribute: .height, multiplier: 0, constant: 20).isActive = true
        
        
        
//        lblCorrectionPoints.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        lblCorrectionPoints.topAnchor.constraint(equalTo: profilePicView.bottomAnchor, constant: -(profilePicView.frame.height / 8)).isActive = true
//        lblCorrectionPoints.centerXAnchor.constraint(equalTo: topContainter.centerXAnchor, constant: topContainter.frame.height).isActive = true
//        //lblCorrectionPoints.trailingAnchor.constraint(equalTo: profilePicView.trailingAnchor).isActive = true
//        lblCorrectionPoints.widthAnchor.constraint(equalToConstant: profilePicView.frame.width).isActive = true
        
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
            profilePicURL = userData?.url
            lblNameSurname.text = (userData?.firstName)! + " " + (userData?.lastName)!
            lblWallet.text = "Wallet: " + String(format: "%.0f", (userData?.wallet)!)
            lblCorrectionPoints.text = "Correction points: " + String(format: "%.0f", (userData?.correctionPoints)!)
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

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
