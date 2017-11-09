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
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 178 / 255, green: 193 / 255, blue: 193 / 255, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let horizontalSlider: UIView = {
        let bar = UIView()
        bar.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    var profileViewController:ProfileViewController?
    let imageNames = ["home","account","stats"]
    let cellID = "Cell"
    var sliderPosition: NSLayoutConstraint?
    
    override init (frame: CGRect) {
        super.init(frame: frame)        
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: cellID)
        setupLayout()
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MenuBarCell
        cell?.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell?.tintColor = UIColor(red: 106 / 255, green: 119 / 255, blue: 119 / 255, alpha: 1)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileViewController?.scrollToMenuIndex(menuIndex: indexPath.item)
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        addSubview(horizontalSlider)
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        sliderPosition = horizontalSlider.leftAnchor.constraint(equalTo: self.leftAnchor)
        sliderPosition?.isActive = true
        horizontalSlider.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalSlider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        horizontalSlider.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
}
    func setupViews() {}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuBarCell: BaseCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(red: 106 / 255, green: 119 / 255, blue: 119 / 255, alpha: 1)
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor(red: 106 / 255, green: 119 / 255, blue: 119 / 255, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.white : UIColor(red: 106 / 255, green: 119 / 255, blue: 119 / 255, alpha: 1)
        }
    }

    override func setupViews() {
        super.setupViews()
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
