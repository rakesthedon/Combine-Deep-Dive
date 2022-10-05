//
//  LoadingImageView.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import SwiftUI

struct LoadingImageView: View {
	
	@ObservedObject var viewModel: LoadingImageViewModel
	
	@ViewBuilder
    var body: some View {
		if let image = viewModel.image {
			ImageView(image: image)
		} else {
			ProgressView().onAppear {
//				viewModel.loadImageTheOldSchoolWay()
				viewModel.loadImageWithCombine()
			}
		}
    }
}

struct LoadingImageView_Previews: PreviewProvider {
    static var previews: some View {
		LoadingImageView(viewModel: .init(url: .init(string: "https://unsplash.com/photos/VLpRa5tFdNY/download?ixid=MnwxMjA3fDF8MXxhbGx8MXx8fHx8fDJ8fDE2NjUwMDE4NDA&force=true")))
    }
}
