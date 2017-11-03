//
//  FeedCell.swift
//  Swifty Companion
//
//  Created by tony mack on 11/3/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 178 / 255, green: 193 / 255, blue: 193 / 255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "cell"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return  basicInfo.count
    }

    var basicInfo:[(name: String, value: String)] = []
    var check:Bool = false
    
    var profileViewController:ProfileViewController? {
        didSet {
            if (profileViewController?.userData?.login != nil && check == false){
                basicInfo.append((name: "Username", value: profileViewController?.userData?.login ?? ""))
                basicInfo.append((name: "Name", value: profileViewController?.userData?.firstName ?? ""))
                basicInfo.append((name: "SurName", value: profileViewController?.userData?.lastName ?? ""))
                basicInfo.append((name: "Email", value: profileViewController?.userData?.email ?? ""))
                basicInfo.append((name: "Phone Number", value: profileViewController?.userData?.mobileNumber ?? ""))
                basicInfo.append((name: "Campus", value: profileViewController?.userData?.campusName ?? ""))
                check = true
                collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeCell
        cell.lblLabel.text =  basicInfo[indexPath.row].name
        cell.lblDetail.text = basicInfo[indexPath.row].value
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height:CGFloat = 50
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellID)
        
    }
}


