//
//  LoginViewController.swift
//  Combine Deep Dive
//
//  Created by Yannick Jacques on 2022-10-05.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var passwordConfirmationTextField: UITextField!
	
	@IBOutlet weak var emailImageView: UIImageView!
	@IBOutlet weak var passwordImageView: UIImageView!
	@IBOutlet weak var passwordConfirmationImageView: UIImageView!
	
	private var subscriptions: Set<AnyCancellable> = .init()
	
	init() {
		super.init(nibName: "LoginViewController", bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setSubcribers()
	}
}

// MARK: - Subscriptions
private extension LoginViewController {
	
	func setSubcribers() {
		// Here we declare 3 publishers to listen to text changes
		let emailNotificationPubliser: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
		let passwordNotificationPubliser: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
		let passwordConfirmationNotificationPubliser: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordConfirmationTextField)
		
		// since we want to get the text field and the changes made we can transform our current publishers with the `compactMap` operator
		let emailTextfieldPubliser = emailNotificationPubliser.compactMap { $0.object as? UITextField }
		let passwordTextfieldPubliser = passwordNotificationPubliser.compactMap { $0.object as? UITextField }
		let passwordConfirmationTextfieldPubliser = passwordConfirmationNotificationPubliser.compactMap { $0.object as? UITextField }
		
		// Here we want to validate if the email is properly formed
		emailTextfieldPubliser
			.debounce(for: .milliseconds(300), scheduler: RunLoop.main)
			.compactMap { emailTextField -> Bool? in
				guard let email = emailTextField.text else { return nil }
				
				let emailPred = NSPredicate(format:"SELF MATCHES %@", Constants.emailRegex)
				return emailPred.evaluate(with: email)
			}
			.sink { [weak self] isValidEmail in
				self?.validate(imageView: self?.emailImageView, isValid: isValidEmail)
			}
			.store(in: &subscriptions)
		
		let passwordValidationPublisher = Publishers.CombineLatest(passwordTextfieldPubliser, passwordConfirmationTextfieldPubliser)
		
		passwordValidationPublisher
			.filter({ passwordTextfield, validationTextfield in
				return passwordTextfield.text?.isEmpty == false && validationTextfield.text?.isEmpty == false
			})
			.compactMap { passwordTextfield, validationTextfield in
				return passwordTextfield.text == validationTextfield.text
			}
			.sink { [weak self] isValidPassword in
				self?.validate(imageView: self?.passwordImageView, isValid: isValidPassword)
				self?.validate(imageView: self?.passwordConfirmationImageView, isValid: isValidPassword)
			}
			.store(in: &subscriptions)
		
		passwordValidationPublisher
			.compactMap { passwordTextfield, validationTextfield in
				return passwordTextfield.text?.isEmpty == false && validationTextfield.text?.isEmpty == false
			}
			.debounce(for: .milliseconds(500), scheduler: RunLoop.main)
			.sink { [weak self] shouldValidate in
				guard !shouldValidate else { return }
				
				self?.clear(imageView: self?.passwordImageView)
				self?.clear(imageView: self?.passwordConfirmationImageView)
			}
			.store(in: &subscriptions)
	}

	func clear(imageView: UIImageView?) {
		imageView?.image = nil
	}
	
	func validate(imageView: UIImageView?, isValid: Bool) {
		imageView?.image = isValid ? .init(systemName: "checkmark.circle") : .init(systemName: "x.circle")
		imageView?.tintColor = isValid ? .systemGreen : .systemRed
	}
}

// MARK: - Observers
private extension LoginViewController {
	
	func setObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTextDidChange), name: UITextField.textDidChangeNotification, object: emailTextField)
		NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTextDidChange), name: UITextField.textDidChangeNotification, object: passwordTextField)
		NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTextDidChange), name: UITextField.textDidChangeNotification, object: passwordConfirmationTextField)
	}
	
	@objc func didReceiveTextDidChange(notification: Notification) {
		switch (notification.object as? UITextField) {
		case emailTextField: print("Email changed")
		case passwordTextField: print("Password Changed")
		case passwordConfirmationTextField: print("Password Validation Changed")
		default: break
		}
	}
}

private extension LoginViewController {
	
	enum Constants {
		static var emailRegex: String { "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" }
	}
}


