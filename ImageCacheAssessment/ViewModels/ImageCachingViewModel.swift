//
//  ImageCachingViewModel.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 01/05/24.
//

import Foundation

class ImageCachingViewModel: ObservableObject {
	
	var imageCachingList: [ImageCachingCellViewModel] = []
	
	// Extra bool to identify empty vs error state - this may be a string to show exact error message
	private var hasError = false
	
	func numberOfSections() -> Int {
		1 // Only 1 as current assessment doesn't reuire more
	}
	
	func numberOfRows(inSection section: Int) -> Int {
		return imageCachingList.count > 0 ? imageCachingList.count : (hasError ? 0 :  -1)
	}
	
	func getData() async  {
		hasError = false
		do {
			let imgCacherList = try await WebServices.getImageCacherCollections()
			imageCachingList = imgCacherList.map(ImageCachingCellViewModel.init)
		} catch _ {
			hasError = true
		}
	}
}
