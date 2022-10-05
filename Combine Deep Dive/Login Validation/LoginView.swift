//
//  LoginView.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import SwiftUI

struct LoginView: UIViewControllerRepresentable {
	
	func makeUIViewController(context: Context) -> LoginViewController {
		return LoginViewController()
	}
	
	func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
	}
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
