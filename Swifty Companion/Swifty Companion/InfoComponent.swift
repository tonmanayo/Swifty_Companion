//
//  InfoLabels.swift
//  Swifty Companion
//
//  Created by Victor Verdun VAN DER WATT on 2017/10/18.
//  Copyright © 2017 janhoon. All rights reserved.
//

import UIKit

class InfoComponent: UILabel {

	init(values: [String: Any], container: UIStackView) {
		super.init(frame: CGRect.init())
		self.text = "\(values["type"] as! String): \(values["value"] as! String)"
		self.heightAnchor.constraint(equalToConstant: 30).isActive = true
		container.addArrangedSubview(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

}
