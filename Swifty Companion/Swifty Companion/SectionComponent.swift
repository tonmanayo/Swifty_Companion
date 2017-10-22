import UIKit

class SectionComponent: UIStackView {
	
	init(values: [String: Any], container: UIStackView) {
		super.init(frame: CGRect.init())
		self.translatesAutoresizingMaskIntoConstraints = false
		self.axis = .vertical
		self.alignment = .fill
		self.distribution = .fill
		
		self.layer.borderWidth = 1
		self.layer.borderColor = UIColor.black.cgColor
		
		createSection(sectionTitle: values["title"] as! String, inner: values)
		container.addArrangedSubview(self)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func createSection(sectionTitle: String, inner: [String: Any]) {
		let titleLabel = UILabel()
		let sectionContainer = UIStackView()
		
		sectionContainer.axis = .vertical
		sectionContainer.alignment = .fill
		sectionContainer.distribution = .fill
		
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
		
		//Add container data
		
		if let array = inner["infoLabels"] {
			let _ = createInfoComponents(values: array as! [[String : Any]], container: sectionContainer)
		} else if let array = inner["projectLabels"] {
			let _ = createProjectComponents(values: array as! [[String: Any]], container: sectionContainer)
		}
	}
	
	func createInfoComponents(values: [[String: Any]], container: UIStackView) {
		for label in values {
			let _  = InfoComponent(values: label, container: container)
		}
	}
	
	func createProjectComponents(values: [[String: Any]], container: UIStackView) {
		for project in values {
			let _ = ProjectsComponent(values: project, container: container)
		}
	}
}
