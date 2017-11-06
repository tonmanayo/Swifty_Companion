//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by tony mack on 10/22/17.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,
    UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
    UIPickerViewDelegate,UIPickerViewDataSource{

    var curriculemNames:[String] = []
    var selectedCurriculem: Int = 0
    var userData:User? {
        didSet {
            navigationItem.title = userData?.login
            profilePicURL = userData?.url
            lblNameSurname.text = (userData?.firstName)! + " " + (userData?.lastName)!
            lblWallet.text = "Wallet: " + String(format: "%.0f", (userData?.wallet)!)
            lblCorrectionPoints.text = "Correction points: " + String(format: "%.0f", (userData?.correctionPoints)!)
            collectionView.reloadData()
            
            var basicInfo:[(key: Int,projectName: String, validated: Double, mark: Double)] = []

            for project in (userData?.project)! {
                if (project.parentID == Double(0)) {
                    
                    let index = project.curriculumID![0] as! Int
                    basicInfo.append((key: index, projectName: project.name, validated: project.validated, mark: project.mark))
                    //test[project.curriculumID[0]] =
                }
            }
            let curr = Curriculum(data: userData?.cursesUsers[0] as! NSDictionary?)
            for curriculem in (userData?.cursesUsers)! {
                let currentCurric = Curriculum(data: curriculem as? NSDictionary)
                curriculemNames.append((currentCurric?.curriculumName)!)
                
            }
            
            curriculumPickerText.text = curriculemNames[0]
            progressBar.progress = Float((curr?.level)!.truncatingRemainder(dividingBy: 1))
            self.curriculumPicker.reloadAllComponents()
            self.curriculumPickerText.reloadInputViews()
            lblLevel.text = "Level \(floor((curr?.level)!))"
            
        }
    }
    
    let cellID = "cell"
    let projectCellID = "projectCellID"
    let titles = ["Home", "Projects", "Skills"]

    let loading :UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.blue
        return activityIndicator
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(FeedCell.self, forCellWithReuseIdentifier: self.cellID)
        cv.register(ProjectCells.self, forCellWithReuseIdentifier: self.projectCellID)

        cv.isPagingEnabled = true
        
        return cv
    }()
    
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
    
    let lblCurriculum: UILabel = {
        let curriculum = UILabel(frame: CGRect.zero)
        curriculum.textAlignment = .center
        curriculum.text = "Curriculum"
        curriculum.font = UIFont.boldSystemFont(ofSize: 12)
        curriculum.adjustsFontSizeToFitWidth = true
        curriculum.textColor = UIColor.black
        curriculum.translatesAutoresizingMaskIntoConstraints = false
        return curriculum
    }()
    
    let profilePicView: CustomUIImageView = {
        let imageView = CustomUIImageView(image: #imageLiteral(resourceName: "loading"))
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
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.profileViewController = self
        return mb
    }()
    
    lazy var curriculumPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = .white
        return picker
    }()
    
    lazy var curriculumPickerText: UITextField = {
        let text = UITextField()
        
        text.textAlignment = .center
        text.font = UIFont.boldSystemFont(ofSize: 12)
        text.adjustsFontSizeToFitWidth = true
        text.textColor = UIColor.gray

        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var progressBar: CustomProgressView = {
        let bar = CustomProgressView()
        bar.height = 10.0
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.progress = 0.0
        return bar
    }()
    
    let lblLevel: UILabel = {
        let level = UILabel(frame: CGRect.zero)
        level.textAlignment = .center
        level.text = "Level: "
        level.font = UIFont.boldSystemFont(ofSize: 10)
        level.adjustsFontSizeToFitWidth = true
        level.minimumScaleFactor = 0.5
        level.translatesAutoresizingMaskIntoConstraints = false
        return level
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curriculumPickerText.inputView = curriculumPicker
        setupLayout()

    }
    // MARK Collection View stuff
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectCellID, for: indexPath as IndexPath) as! ProjectCells
            cell.profileViewController = self
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath as IndexPath) as! FeedCell
        cell.profileViewController = self
        return cell
       
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        menuBar.collectionView.collectionViewLayout.invalidateLayout()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.sliderPosition?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(row: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
        setTitle(index: menuIndex)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let indexPath = IndexPath(item: Int(targetContentOffset.pointee.x / view.frame.width), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        setTitle(index: Int(targetContentOffset.pointee.x / view.frame.width))
    }
    
    private func setTitle(index: Int) {
        navigationItem.title = titles[index]
    }
    
    //MARK - picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (userData?.cursesUsers.count) ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return curriculemNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        curriculumPickerText.text = curriculemNames[row]
        selectedCurriculem = row
        let currentC = Curriculum(data: userData?.cursesUsers[selectedCurriculem] as! NSDictionary?)
        progressBar.progress = Float((currentC?.level)!.truncatingRemainder(dividingBy: 1))
        lblLevel.text = "Level \(floor((currentC?.level)!))"
        self.view.endEditing(true)
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
        topContainter.addSubview(lblCurriculum)
        topContainter.addSubview(curriculumPickerText)
        
        coverImage.topAnchor.constraint(equalTo: topContainter.topAnchor).isActive = true
        coverImage.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        coverImage.trailingAnchor.constraint(equalTo: topContainter.trailingAnchor).isActive = true
        coverImage.heightAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.3).isActive = true
        
        profilePicView.centerXAnchor.constraint(equalTo: topContainter.centerXAnchor).isActive = true
        profilePicView.topAnchor.constraint(equalTo: coverImage.centerYAnchor).isActive = true
        profilePicView.heightAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true
        profilePicView.widthAnchor.constraint(equalTo: topContainter.heightAnchor, multiplier: 0.5).isActive = true
        
        //lblCurriculum.centerXAnchor.constraint(equalTo: topContainter.centerXAnchor).isActive = true
        lblCurriculum.topAnchor.constraint(equalTo: profilePicView.centerYAnchor).isActive = true
        lblCurriculum.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblCurriculum.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        lblCurriculum.trailingAnchor.constraint(equalTo: profilePicView.leadingAnchor).isActive = true
        
        curriculumPickerText.topAnchor.constraint(equalTo: lblCurriculum.bottomAnchor).isActive = true
        curriculumPickerText.heightAnchor.constraint(equalToConstant: 20).isActive = true
        curriculumPickerText.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        curriculumPickerText.trailingAnchor.constraint(equalTo: profilePicView.leadingAnchor).isActive = true
        
        let stackViewNameWalletCorrection = UIStackView(arrangedSubviews: [lblWallet, lblNameSurname, lblCorrectionPoints])
        
        topContainter.addSubview(stackViewNameWalletCorrection)
       
        loading.center = profilePicView.center
        
        stackViewNameWalletCorrection.translatesAutoresizingMaskIntoConstraints = false
        stackViewNameWalletCorrection.distribution = .fillEqually
        stackViewNameWalletCorrection.spacing = 10
        
        stackViewNameWalletCorrection.heightAnchor.constraint(equalToConstant: 20).isActive = true
        stackViewNameWalletCorrection.topAnchor.constraint(equalTo: profilePicView.bottomAnchor).isActive = true
        stackViewNameWalletCorrection.leadingAnchor.constraint(equalTo: topContainter.leadingAnchor).isActive = true
        stackViewNameWalletCorrection.trailingAnchor.constraint(equalTo: topContainter.trailingAnchor).isActive = true
        
        topContainter.addSubview(progressBar)
        
        progressBar.topAnchor.constraint(equalTo: stackViewNameWalletCorrection.bottomAnchor).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
        progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        progressBar.addSubview(lblLevel)
        lblLevel.topAnchor.constraint(equalTo: progressBar.topAnchor).isActive = true
        lblLevel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        lblLevel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lblLevel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        topContainter.addSubview(menuBar)
        
        menuBar.topAnchor.constraint(equalTo: progressBar.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        
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

class CustomUIImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
    }
}

class CustomProgressView: UIProgressView {
    
    var height:CGFloat = 1.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let size:CGSize = CGSize.init(width: self.frame.size.width, height: height)
        
        return size
    }
    
}
