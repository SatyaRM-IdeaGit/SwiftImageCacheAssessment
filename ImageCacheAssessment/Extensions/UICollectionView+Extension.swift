//
//  UICollectionView+Extension.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 01/05/24.
//

import Foundation
import UIKit

extension UICollectionView {
	func setEmptyLoading() {
		let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0,
									     width: self.bounds.size.width,
									     height: self.bounds.size.height))
		loadingIndicator.color = .orange
		loadingIndicator.backgroundColor = .lightGray
		loadingIndicator.transform = CGAffineTransform(scaleX: 3.5, y: 3.5)
		self.backgroundView = loadingIndicator;
		loadingIndicator.startAnimating()
	}
	
	func setEmptyMessage(_ message: String) {
		let messageLabel = UILabel(frame: CGRect(x: 0, y: 0,
							 width: self.bounds.size.width - 40,
							 height: self.bounds.size.height))
		messageLabel.text = message
		messageLabel.textColor = .red
		messageLabel.numberOfLines = 0;
		messageLabel.textAlignment = .center;
		messageLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
		messageLabel.sizeToFit()
		self.backgroundView = messageLabel;
	}
	
	func restore() {
		self.backgroundView = nil
	}
}
