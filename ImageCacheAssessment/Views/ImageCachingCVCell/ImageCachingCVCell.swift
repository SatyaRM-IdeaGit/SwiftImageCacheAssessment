//
//  ImageCachingCVCell.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 01/05/24.
//

import UIKit

class ImageCachingCVCell: UICollectionViewCell {
	// MARK: - Outlets
	@IBOutlet weak var labelTitle: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var loaderAnim: UIActivityIndicatorView!
	
	// MARK: - Static or Class properties
	static let cellID = "ImageCachingCVCell"
	
	// MARK: - Custom Static or Class Methods
	static func nibOrXib() -> UINib {
		// Self.CellID - kept as same as file name - a better way to reduce code typing
		return UINib(nibName: Self.cellID, bundle: nil)
	}
	
	// MARK: - Overrididng Methods
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		translatesAutoresizingMaskIntoConstraints = false
		
		layer.borderWidth = 1
		layer.borderColor = UIColor.gray.cgColor
		layer.cornerRadius = 3
		
		loaderAnim.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
	}
	
	// MARK: - Custom public Methods
	func updateDetails(with imgCachingCellViewModel: ImageCachingCellViewModel) {
		labelTitle.text = imgCachingCellViewModel.title
		imageView.image = UIImage(named: "image_placeholder")!.withTintColor(.lightGray)
		loaderAnim.startAnimating()
		Task {
			imageView.image = await imgCachingCellViewModel.getImage()
			loaderAnim.stopAnimating()
		}
	}}
