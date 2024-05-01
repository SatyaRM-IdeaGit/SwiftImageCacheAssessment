//
//  ImageCachingModel.swift
//  ImageCacheAssessment
//
//  Created by SatyaRanjan Mohapatra on 01/05/24.
//

import Foundation

// MARK: - JSON Reference to parse into Model
//{
//	"backupDetails": {
//		"pdfLink": "https://paf-web.s3.ap-south-1.amazonaws.com/media/Acharya+Prashant+Engages+with+IIT+Students+on+Mental+Health+and+Spiritual+Well-being+-.pdf",
//		"screenshotURL": "https://cimg.acharyaprashant.org/images/img-92094366-57fd-40a7-91af-d4292c6a2a60/40/image.jpg"
//	},
//	"coverageURL": "https://healthofasia.com/acharya-prashant-engages-with-iit-students-on-mental-health-and-spiritual-well-being/",
//	"id": "coverage-e7ae07",
//	"language": "english",
//	"mediaType": 0,
//	"publishedAt": "2024-04-17",
//	"publishedBy": "Health of Asia",
//	"thumbnail": {
//		"aspectRatio": 1,
//		"basePath": "images/img-f92c4193-2483-4ab7-aefd-854f022d81a8",
//		"domain": "https://cimg.acharyaprashant.org",
//		"id": "img-f92c4193-2483-4ab7-aefd-854f022d81a8",
//		"key": "image.jpg",
//		"qualities": [
//			10,
//			20,
//			30,
//			40
//		],
//		"version": 1
//	},
//	"title": "Acharya Prashant Engages with IIT Students on Mental Health and Spiritual Well-being"
//},


// MARK: - ImageCachingModel
struct ImageCachingItem: Codable {
	let id, title: String
	let language: Language
	let thumbnail: Thumbnail
	let mediaType: Int
	let coverageURL: String
	let publishedAt, publishedBy: String
	let backupDetails: BackupDetails?
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
	let pdfLink: String
	let screenshotURL: String
}

enum Language: String, Codable {
	case english = "english"
	case hindi = "hindi"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
	let id: String
	let version: Int
	let domain: String
	let basePath: String
	let key: Key
	let qualities: [Int]
	let aspectRatio: Int
}

enum Key: String, Codable {
	case imageJpg = "image.jpg"
}

typealias ImageCachingModel = [ImageCachingItem]
