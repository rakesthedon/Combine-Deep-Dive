//
//  ContentView.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import SwiftUI

struct MainView: View {
	var body: some View {
		NavigationView {
			List {
				
				NavigationLink {
					LoadingImageView(viewModel: .init(url: URL(string: "https://unsplash.com/photos/r27umXAelDc/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8NXx8cG9rZW1vbnxlbnwwfHx8fDE2NjUwMDQ1MDU&force=true")))
				} label: {
					Text("Image Loading")
				}
				
				
				 NavigationLink {
				 LoginView()
				 .edgesIgnoringSafeArea(.all)
				 } label: {
				 Text("Login View")
				 }
				 
				
				NavigationLink {
					ImageGridView(viewModel: .init(urls:
													Array(1...50).compactMap { value -> URL? in
						return URL(string: "https://source.unsplash.com/featured/\(value)")
					}
												  ))
				} label: {
					Text("Image Grid")
				}
			}
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
