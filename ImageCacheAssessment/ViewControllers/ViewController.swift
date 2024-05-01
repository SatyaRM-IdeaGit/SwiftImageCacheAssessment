//
//  ViewController.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 28/04/24.
//

import UIKit

class ViewController: UIViewController {

	
	/// Collection view to show all the images in cells - 3 celles per row as required
	@IBOutlet weak var imageCachingCV: UICollectionView!
	
	// ViewModelGoesHere
	var imageCachingViewModel = ImageCachingViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Registering the custom UICollectionViewCell
		imageCachingCV.register(ImageCachingCVCell.nibOrXib(),
					    forCellWithReuseIdentifier: ImageCachingCVCell.cellID)
		
		// Stopping cell selection as not required for current asssessment
		imageCachingCV.allowsSelection = false;
		imageCachingCV.translatesAutoresizingMaskIntoConstraints = false
	}
	
	override func viewWillAppear(_ animated: Bool)  {
		super.viewWillAppear(animated)
		
		Task {
			self.imageCachingCV.setEmptyLoading()
			await self.imageCachingViewModel.getData()
			self.imageCachingCV.reloadData()
		}
	}
	
	override func viewWillTransition(to size: CGSize,
					 with coordinator: UIViewControllerTransitionCoordinator) {
		imageCachingCV.collectionViewLayout.invalidateLayout()
		Task {
			self.imageCachingCV.reloadData()
		}
	}
}

// MARK: Collection DataSource + Delegates
// Main delegate to help apply restriction on cell width based on screen/drawable width
extension ViewController: UICollectionViewDataSource {
	// Not overriding this as there are no requirement for more than 1 section for this assessment
	func numberOfSections(in imgCacherCV: UICollectionView) -> Int {
		imageCachingViewModel.numberOfSections()
	}
	
	func collectionView(_ imgCacherCV: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let currentRowCount = imageCachingViewModel.numberOfRows(inSection: section)
		if currentRowCount == 0 {
			imgCacherCV.setEmptyLoading()
		}
		else if  currentRowCount == -1 {
			imgCacherCV.setEmptyMessage(WebServiceError.unknown.describe())
		}
		else {
			imgCacherCV.restore()
		}
		
		return currentRowCount
	}
	
	func collectionView(_ imgCacherCV: UICollectionView,
			    cellForItemAt currIdxPath: IndexPath) -> UICollectionViewCell {
		// Reusable idenified cell
		guard let imgCvCell = imgCacherCV.dequeueReusableCell(withReuseIdentifier: ImageCachingCVCell.cellID, for: currIdxPath) as? ImageCachingCVCell else {
			return UICollectionViewCell()
		}
		
		// Updating current cell with few details
		imgCvCell.updateDetails(with: imageCachingViewModel.imageCachingList[currIdxPath.row])
		
		// return above reusable idenified cell
		return imgCvCell
	}
}


let imgCellPadding = 5.0 // pixel padding from all sides

/// Main delegate to help apply restriction on cell width based on screen/drawable width
extension ViewController: UICollectionViewDelegate {
	func collectionView(_ imgCacherCV: UICollectionView, didSelectItemAt currIdxPath: IndexPath) {
		// add the code here to perform action on the cell
		// No override here, as behaviour was not specified in the assessment document
	}
}

/// Main delegate to help apply restriction on cell width based on screen/drawable width

extension ViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ imgCacherCV: UICollectionView,
			    layout imgCvLayout: UICollectionViewLayout,
			    sizeForItemAt currIdxPath: IndexPath) -> CGSize {
		
		let mainFrameSize  = imgCacherCV.frame.size
		// 4 horizontal padding for 3 cells in a row
		let hPadding = 4.0 * imgCellPadding
		// Individual width for each cell in a row - 3 cells in a row
		let finalCellWidth = (mainFrameSize.width - hPadding) / 3.0
		
		// TextPadding => 2 * imgCellPadding
		let widthForText = finalCellWidth - (2 * imgCellPadding)
		var textHeight = imageCachingViewModel.imageCachingList[currIdxPath.row].title.frameHeight(fromFixedWidth: widthForText,
						      font: UIFont.systemFont(ofSize: UIFont.systemFontSize))
		// For showing maximum 2 lines as there were no specific requirement
		textHeight = textHeight > 30 ? 60 : 30
		
		// Individual height for each cell in a row -
		// imgCellPadding = spacing in stackview
		let finalCellHeight = finalCellWidth + imgCellPadding + textHeight
		
		return CGSize(width: finalCellWidth , height: finalCellHeight)
	}
	
	func collectionView(_ imgCacherCV: UICollectionView,
			    layout imgCvLayout: UICollectionViewLayout,
			    insetForSectionAt imgCvSection: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: imgCellPadding, left: imgCellPadding,
				    bottom: imgCellPadding, right: imgCellPadding)
	}
	
	func collectionView(_ imgCacherCV: UICollectionView,
			    layout imgCvLayout: UICollectionViewLayout,
			    minimumLineSpacingForSectionAt imgCvSection: Int) -> CGFloat {
		return imgCellPadding
	}
	
	func collectionView(_ imgCacherCV: UICollectionView,
			    layout imgCvLayout: UICollectionViewLayout,
			    minimumInteritemSpacingForSectionAt imgCvSection: Int) -> CGFloat {
		return 0
	}
}
