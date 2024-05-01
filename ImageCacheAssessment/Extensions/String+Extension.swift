//
//  String+Extension.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 01/05/24.
//

import Foundation
import UIKit

extension String {
	/// To get height of text for given width
	func frameHeight(fromFixedWidth width: CGFloat, font: UIFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
		return ceil(boundingBox.height)
	}
}
