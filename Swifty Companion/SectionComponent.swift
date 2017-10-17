import UIKit

class SectionComponent: UIStackView {
	
	init(btnName: String) {
		super.init(frame: CGRect.init())
		self.translatesAutoresizingMaskIntoConstraints = false
		self.axis = .vertical
		self.alignment = .fill
		self.distribution = .fill
		createSection(name: btnName)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}

	func createSection(name: String) {
		let title = UILabel()
		title.text = name;
		title.heightAnchor.constraint(equalToConstant: 30)
	}
}
