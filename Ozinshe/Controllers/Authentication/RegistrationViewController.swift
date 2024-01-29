//
//  RegistrationViewController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit
import SnapKit

final class RegistrationViewController: UIViewController {
	// MARK: - UI Elements
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()

		label.text = "Тіркелу"
		label.font = .appFont(ofSize: 24, weight: .bold)
		label.textColor = .Authentication.title
		
		return label
	}()
	
	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		
		label.text = "Деректерді толтырыңыз"
		label.font = .appFont(ofSize: 16)
		label.textColor = .Authentication.subtitle
		
		return label
	}()
	
	private lazy var formStackView: UIStackView = {
		let stackView = UIStackView()
		
		stackView.axis = .vertical
		stackView.spacing = 16
		
		return stackView
	}()
	
	private lazy var emailTextFieldView: TextFieldView = {
		let textFieldView = TextFieldView()
		
		textFieldView.title = "Email"
		textFieldView.placeholder = "Сіздің email"
		textFieldView.textField.icon = .Icons.email
		textFieldView.textField.keyboardType = .emailAddress
		textFieldView.textField.autocapitalizationType = .none
		textFieldView.textField.textContentType = .emailAddress
		
		return textFieldView
	}()
	
	private lazy var passwordTextFieldView: TextFieldView = {
		let textFieldView = TextFieldView()
		
		textFieldView.title = "Құпия сөз"
		textFieldView.placeholder = "Сіздің құпия сөзіңіз"
		textFieldView.textField.icon = .Icons.password
		textFieldView.textField.isSecureTextEntry = true
		textFieldView.textField.autocapitalizationType = .none
		textFieldView.textField.textContentType = .newPassword
		
		return textFieldView
	}()
	
	private lazy var passwordConfirmTextFieldView: TextFieldView = {
		let textFieldView = TextFieldView()
		
		textFieldView.title = "Құпия сөзді қайталаңыз"
		textFieldView.placeholder = "Сіздің құпия сөзіңіз"
		textFieldView.textField.icon = .Icons.password
		textFieldView.textField.isSecureTextEntry = true
		textFieldView.textField.autocapitalizationType = .none
		textFieldView.textField.textContentType = .newPassword
		
		return textFieldView
	}()
	
	private lazy var registerButton: UIButton = {
		let button = BaseButton()
		
		button.setTitle("Тіркелу", for: .normal)
		button.titleLabel?.font = .appFont(ofSize: 16, weight: .semiBold)
		button.layer.cornerRadius = 12
		button.backgroundColor = .Button.Primary.background
		button.tintColor = .Button.Primary.text
		
		button.addTarget(self, action: #selector(register), for: .primaryActionTriggered)
		
		return button
	}()
	
	private lazy var loginView: UIStackView = {
		let stackView = UIStackView()
		let label = {
			let label = UILabel()
				
			label.text = "Сізде аккаунт бар ма?"
			label.font = .appFont(ofSize: 14)
			label.textColor = .Authentication.noAccountLabel
			
			return label
		}()
		
		let button = {
			let button = BaseButton()
				
			button.setTitle("Кіру", for: .normal)
			button.setTitleColor(.Authentication.noAccountButton, for: .normal)
			button.titleLabel?.font = .appFont(ofSize: 14, weight: .semiBold)
			
			return button
		}()
		
		stackView.axis = .horizontal
		stackView.spacing = 3
		stackView.alignment = .center
		
		stackView.addArrangedSubviews(label, button)
		
		return stackView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
	}
}

extension RegistrationViewController {
	private func setupViews() {
		view.backgroundColor = .appBackground
		
		view.addSubviews(titleLabel, subtitleLabel, formStackView, registerButton, loginView)
		formStackView.addArrangedSubviews(emailTextFieldView, passwordTextFieldView, passwordConfirmTextFieldView)
	}
	
	private func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
			make.horizontalEdges.equalToSuperview().inset(24)
		}
		
		subtitleLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(4)
			make.horizontalEdges.equalToSuperview().inset(24)
		}
		
		formStackView.snp.makeConstraints { make in
			make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
			make.horizontalEdges.equalToSuperview().inset(24)
		}
		
		registerButton.snp.makeConstraints { make in
			make.top.equalTo(formStackView.snp.bottom).offset(40)
			make.horizontalEdges.equalToSuperview().inset(24)
			make.height.equalTo(56)
		}
		
		loginView.snp.makeConstraints { make in
			make.top.equalTo(registerButton.snp.bottom).offset(24)
			make.centerX.equalToSuperview()
		}
	}
}

extension RegistrationViewController {
	@objc
	private func register() {
		showTabBar()
	}
	
	private func showTabBar() {
		guard let window = view.window else {
			return
		}
	
		let tabBarController = TabBarController()
		
		window.rootViewController = tabBarController
		
		UIView.transition(with: window, duration: 1.0, options: .transitionFlipFromRight, animations: nil)
	}
}
