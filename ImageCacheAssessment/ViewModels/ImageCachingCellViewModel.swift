//
//  ImageCachingCellViewModel.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 01/05/24.
//

import Foundation
import UIKit

struct ImageCachingCellViewModel: Identifiable {
	let id = UUID()
	private var imageCachingItem: ImageCachingItem
	
	init(imageCacher: ImageCachingItem) {
		self.imageCachingItem = imageCacher
	}
	
	var title:String {
		get {
			imageCachingItem.title
		}
	}
		
	var thumbnailUrl: URL? {
		URL(string: imageCachingItem.thumbnail.domain)?.appending(components: imageCachingItem.thumbnail.basePath, "\(imageCachingItem.thumbnail.qualities.first ?? 0)", imageCachingItem.thumbnail.key.rawValue)
	}
	
	/// Function to download individual images from NetworkHandler
	func getImage() async -> UIImage {
		do {
			let downloadedImage = try await WebServices.getImageFromUrl(thumbnailUrl)
			return downloadedImage
		} catch _ {
			return (UIImage(named: "image_not_found")?.withTintColor(.red))!
		}
	}	
}
