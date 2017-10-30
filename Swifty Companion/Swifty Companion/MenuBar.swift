//
//  MenuBar.swift
//  Swifty Companion
//
//  Created by Tony MACK on 2017/10/30.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class MenuBar : UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.yellow
        cv.translatesAutoresizingMaskIntoConstraints = false

        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    let cellID = "Cell"
    
    override init (frame: CGRect) {
        super.init(frame: frame)        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.green
        return cell
    }
}
