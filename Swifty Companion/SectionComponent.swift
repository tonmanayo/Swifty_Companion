import UIKit

class SectionComponent: UIStackView {
	
	init(title: String) {
		super.init(frame: CGRect.init())
		self.translatesAutoresizingMaskIntoConstraints = false
		self.axis = .vertical
		self.alignment = .fill
		self.distribution = .fill
		createSection(sectionTitle: title)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}

	func createSection(sectionTitle: String) {
		let titleLabel = UILabel()
		let sectionContainer = UIView()
		
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		sectionContainer.translatesAutoresizingMaskIntoConstraints = false
		
		titleLabel.text = sectionTitle;
		titleLabel.textAlignment = NSTextAlignment.center
		titleLabel.layer.borderWidth = 1
		titleLabel.layer.borderColor = UIColor.black.cgColor
		titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
		self.addArrangedSubview(titleLabel)
		
		sectionContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
		self.addArrangedSubview(sectionContainer)
	}
}
