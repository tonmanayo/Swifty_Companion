//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by tony mack on 10/22/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    var userData:User? {
        didSet {
            navigationItem.title = userData?.login
            profilePicURL = userData?.url
            lblNameSurname.text = (userData?.firstName)! + " " + (userData?.lastName)!
            lblWallet.text = "Wallet: " + String(format: "%.0f", (userData?.wallet)!)
            lblCorrectionPoints.text = "Correction points: " + String(format: "%.0f", (userData?.correctionPoints)!)
        }
    }
    
    let loading :UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.blue
        return activityIndicator
    }()
    
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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let coverImage: UIImageView = {
        let coverView = UIImageView(image: #imageLiteral(resourceName: "code-guide-callout"))
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.contentMode = .scaleAspectFill
        coverView.layer.masksToBounds = true
        
        return coverView
    }()
    
    let lblNameSurname: UILabel = {
        let nameSurname = UILabel(frame: CGRect.zero)
        nameSurname.textAlignment = .center
        nameSurname.text = "userName"
        nameSurname.font = UIFont.boldSystemFont(ofSize: 20)
        nameSurname.adjustsFontSizeToFitWidth = true
        nameSurname.minimumScaleFactor = 0.5
        nameSurname.translatesAutoresizingMaskIntoConstraints = false
        return nameSurname
    }()
    
    private var profilePic: UIImage? {
        get {
            return profilePicView.image
        }
        set {
            loading.stopAnimating()
            profilePicView.image = newValue
        }
    }
    
    let topContainter: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    
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
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        setupLayout()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profilePicView.layer.cornerRadius = profilePicView.frame.height / 2.0
    }
    
    private func setupLayout(){
        
        view.addSubview(topContainter)
        
        topContainter.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        topContainter.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        topContainter.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainter.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topContainter.addSubview(coverImage)
        topContainter.addSubview(profilePicView)
        profilePicView.addSubview(loading)
        
        coverImage.topAnchor.constraint(equalTo: topContainter.topAnchor).isActive = true
        coverImage.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        coverImage.trailingAnchor.constraint(equalTo: topContainter.trailingAnchor).isActive = true
        coverImage.heightAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true
        
        profilePicView.centerXAnchor.constraint(equalTo: topContainter.centerXAnchor).isActive = true
        profilePicView.centerYAnchor.constraint(equalTo: topContainter.centerYAnchor).isActive = true
        profilePicView.heightAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true
        profilePicView.widthAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true

        let stackViewNameWalletCorrection = UIStackView(arrangedSubviews: [lblWallet, lblNameSurname, lblCorrectionPoints])
       
        loading.center = profilePicView.center
        
        stackViewNameWalletCorrection.translatesAutoresizingMaskIntoConstraints = false
        stackViewNameWalletCorrection.distribution = .fillEqually
        stackViewNameWalletCorrection.spacing = 10
        
        topContainter.addSubview(stackViewNameWalletCorrection)
        
        stackViewNameWalletCorrection.heightAnchor.constraint(equalToConstant: 20).isActive = true
        stackViewNameWalletCorrection.topAnchor.constraint(equalTo: profilePicView.bottomAnchor).isActive = true
        stackViewNameWalletCorrection.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        stackViewNameWalletCorrection.trailingAnchor.constraint(equalTo: topContainter.trailingAnchor).isActive = true
        topContainter.addSubview(menuBar)
        
        menuBar.topAnchor.constraint(equalTo: stackViewNameWalletCorrection.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        menuBar.addSubview(menuBar.collectionView)
        
        menuBar.collectionView.topAnchor.constraint(equalTo: menuBar.topAnchor)
        menuBar.collectionView.leadingAnchor.constraint(equalTo: menuBar.leadingAnchor).isActive = true
        menuBar.collectionView.trailingAnchor.constraint(equalTo: menuBar.trailingAnchor).isActive = true
        menuBar.collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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

    // MARK - fetch image
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
}
