//
//  ProjectsCollectionViewCell.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/11/06.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProjectCells:BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var check:Bool = false
    let projectCellID = "projectCell"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return  basicInfo.count
        return projects!.count
    }
    
    var projects:[User.Projects]? {
        didSet {
            if (projects?.isEmpty == false && check == false){
//                basicInfo.append((name: "Username", value: profileViewController?.userData?.login ?? ""))
//                basicInfo.append((name: "Name", value: profileViewController?.userData?.firstName ?? ""))
//                basicInfo.append((name: "Surname", value: profileViewController?.userData?.lastName ?? ""))
//                basicInfo.append((name: "Email", value: profileViewController?.userData?.email ?? ""))
//                basicInfo.append((name: "Phone number", value: profileViewController?.userData?.mobileNumber ?? ""))
//                basicInfo.append((name: "Campus", value: profileViewController?.userData?.campusName ?? ""))
//                basicInfo.append((name: "", value: ""))
                
                check = true
                
                collectionView.reloadData()
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectCellID, for: indexPath) as! ProjectCell
        if (projects?.isEmpty == false && (projects != nil)) {
            cell.lblProjectName.text = projects![indexPath.row].name
            cell.lblStatus.text = projects![indexPath.row].status
            cell.lblmark.text = String(format: "%.0f",projects![indexPath.row].mark) + "%"
            if (projects![indexPath.row].validated == 0){
                cell.imgValidated.image = #imageLiteral(resourceName: "redCircle")
            } else {
                cell.imgValidated.image = #imageLiteral(resourceName: "greenCircle")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height:CGFloat = 50
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    override func setupViews() {
        super.setupViews()
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: projectCellID)

        
        addSubview(collectionView)
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
    }

}
