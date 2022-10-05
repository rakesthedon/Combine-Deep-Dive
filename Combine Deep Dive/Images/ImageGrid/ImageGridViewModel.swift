//
//  ImageGridViewModel.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import UIKit
import Combine

final class ImageGridViewModel: ObservableObject {

	@Published var images: [UIImage] = []

	private let urls: [URL]
	private var subscription: AnyCancellable?
	
	private var publisher: AnyPublisher<[UIImage], Error>?

	init(urls: [URL]) {
		self.urls = urls
	}

	func loadImages() {
		let publishers = urls.compactMap {
			URLSession.shared.dataTaskPublisher(for: $0)
				.compactMap { data, _ -> UIImage? in
					return UIImage(data: data)
				}
		}
		
		publisher = Publishers.MergeMany(publishers)
			.mapError { $0 as Error }
			/** the `collect` is required in order to wait for all publishers to complete their task */
			.collect()
			.eraseToAnyPublisher()
		
		subscription = publisher?
			.sink { completion in
				debugPrint(completion)
			} receiveValue: { [weak self] output in
				self?.images = output
			}
	}
}
