//
//  ImageView.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import SwiftUI

struct ImageView: View {
	
	let image: UIImage
	
	init?(image: UIImage?) {
		guard let image else { return nil }
		self.image = image
	}
	
    var body: some View {
		Image(uiImage: image)
			.resizable()
			.scaledToFit()
    }
}

struct ImageView_Previews: PreviewProvider {
    
	static var previews: some View {
		ImageView(image: .init(systemName: "globe"))
    }
}
