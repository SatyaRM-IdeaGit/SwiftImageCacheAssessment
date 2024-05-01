//
//  WebService.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 01/05/24.
//

import Foundation
import UIKit


// Case less enum is good for holding constants
/// This hold constants related to web services
enum WebServiceConstant {
	///Main URL given in the assessment -
	/// https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100
	static let baseAPI =  "https://acharyaprashant.org"
	static let apiVersion = "/api/v2"
	// This limit can be managed dynamically
	static let contentEndPoint = "/content/misc/media-coverages?limit="
}

enum WebServiceError: Error {
	case invalidUrl
	case badRequest
	case dataEmpty
	case dataParsingError
	case unsupportedImage
	case unknown
	
	func describe() -> String {
		switch self {
			case .unknown:
				return "Oops!!! Something went Wrong. \n Please come back later..."
			default:
				return self.localizedDescription
		}
	}
}

/// Responsible to make all API calls or connections to the web or internet
 class WebServices {
	private static let imageCacheHolder = URLCache.shared
	
	 /// Gets the collection of items from internet which needs to be rendered on the UI
	static func getImageCacherCollections(limit: Int = 100) async throws -> ImageCachingModel {
		guard let imgListUrl = URL(string: WebServiceConstant.baseAPI + WebServiceConstant.apiVersion + WebServiceConstant.contentEndPoint + "\(limit)")
		else {
			throw WebServiceError.invalidUrl
		}
		
		let (data, response) = try await URLSession.shared.data(from: imgListUrl)
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
		else {
			throw WebServiceError.badRequest
		}

		return try JSONDecoder().decode(ImageCachingModel.self, from: data)
	}
	
	 /// Gets the image from cache if already available, else downlaods a new image and saves back to the cache
	static func getImageFromUrl(_ imgUrl: URL?) async throws -> UIImage {
		
		guard let imgUrl = imgUrl else {
			throw WebServiceError.invalidUrl
		}
		
		var imgRequest = URLRequest(url: imgUrl)
		imgRequest.cachePolicy = .returnCacheDataElseLoad
		
		// Check and Return Image saved in cache
		if let cachedData = Self.imageCacheHolder.cachedResponse(for: imgRequest)?.data {
			guard let cachedImg = UIImage(data: cachedData) else {
				throw WebServiceError.unsupportedImage
			}
			
			return cachedImg
		}
		
		let (imgData, response) = try await URLSession.shared.data(for: imgRequest)
		guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
		else {
			throw WebServiceError.badRequest
		}
		
		if imgData.description.isEmpty {
			throw WebServiceError.dataEmpty
		}
		
		guard let downlaodedImage = UIImage(data: imgData) else {
			throw WebServiceError.unsupportedImage
		}
		
		// Save image in cache and then return
		let cachedImgData = CachedURLResponse(response: httpResponse, data: imgData)
		Self.imageCacheHolder.storeCachedResponse(cachedImgData, for: imgRequest)
		
		return downlaodedImage
	}
}
