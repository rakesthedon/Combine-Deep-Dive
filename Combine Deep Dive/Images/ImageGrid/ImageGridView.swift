//
//  ImageGridView.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import SwiftUI

struct ImageGridView: View {
    
	@ObservedObject var viewModel: ImageGridViewModel
	
	let columns = [GridItem(.flexible()), GridItem(.flexible())]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns) {
				ForEach(viewModel.images, id: \.self) { image in
					Rectangle()
						.aspectRatio(1, contentMode: .fit)
						.overlay(
							Image(uiImage: image)
								.resizable()
								.scaledToFill()
						)
						.clipShape(Rectangle())
				}
			}
		}
		.onAppear {
			viewModel.loadImages()
		}
    }
}

struct ImageGridView_Previews: PreviewProvider {
    static var previews: some View {
		ImageGridView(viewModel: .init(urls: [
			URL(string: "https://images.unsplash.com/photo-1661956602139-ec64991b8b16?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!,
			URL(string: "https://images.unsplash.com/photo-1664989845570-6f03c42c47f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!,
			URL(string: "https://images.unsplash.com/photo-1661956602139-ec64991b8b16?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!,
			URL(string: "https://images.unsplash.com/photo-1664989845570-6f03c42c47f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!,
			URL(string: "https://images.unsplash.com/photo-1661956602139-ec64991b8b16?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!,
			URL(string: "https://images.unsplash.com/photo-1664989845570-6f03c42c47f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!,
			URL(string: "https://images.unsplash.com/photo-1661956602139-ec64991b8b16?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!,
			URL(string: "https://images.unsplash.com/photo-1664989845570-6f03c42c47f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60")!
		]))
    }
}
