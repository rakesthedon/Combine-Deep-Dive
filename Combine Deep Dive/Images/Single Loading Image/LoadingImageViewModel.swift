//
//  LoadingImageViewModel.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import UIKit
import Combine

final class LoadingImageViewModel: ObservableObject {

	enum LoadingError: Error {
		case invalidUrl
		case missingData
		case other(error: Error)
	}
	
	@Published private(set) var image: UIImage?
	
	private let url: URL?
	private var loadingSubscription: AnyCancellable?
	
	init(image: UIImage? = nil, url: URL? = nil) {
		self.image = image
		self.url = url
	}
	
	func loadImageWithCombine() {
		guard let url else { return }
		loadingSubscription?.cancel()
		
		loadingSubscription = URLSession.shared.dataTaskPublisher(for: url)
			.mapError { $0 as Error }
			.compactMap { data, _ in
				return UIImage(optionalData: data)
			}
			.receive(on: RunLoop.main)
			.sink { completion in
				switch completion {
				case .failure(let error):
					NSLog("Failed to load image with error: \(error.localizedDescription)")
				case .finished:
					break
				}
			} receiveValue: { [weak self] image in
				self?.image = image
			}
	}
	
	func loadImageTheOldSchoolWay() {
		guard let url else { return }
		let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, _, _ in
			guard let data,
				  let image = UIImage(data: data) else { return }
			
			DispatchQueue.main.async {
				self?.image = image
			}
		}
		
		task.resume()
	}
}

// MARK: - Private
private extension UIImage {
	
	convenience init?(optionalData: Data?) {
		guard let data = optionalData else { return nil }
		
		self.init(data: data)
	}
}
