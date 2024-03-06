//
//  LoginViewController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let accessToken: String
}

final class LoginViewController: UIViewController {
    
    weak var coordinator: AuthenticationDelegate?
    
	// MARK: - UI Elements
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()

		label.text = "Сәлем"
		label.font = .appFont(ofSize: 24, weight: .bold)
		label.textColor = .Authentication.title
		
		return label
	}()
	
	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		
		label.text = "Аккаунтқа кіріңіз"
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
		textFieldView.textField.textContentType = .password
		
		return textFieldView
	}()
	
	private lazy var forgotPasswordButton: UIButton = {
		let button = BaseButton()
		
		button.setTitle("Құпия сөзді ұмыттыңыз ба?", for: .normal)
		button.titleLabel?.font = .appFont(ofSize: 14, weight: .semiBold)
		button.setTitleColor(.Authentication.forgotPassword, for: .normal)
		button.contentHorizontalAlignment = .trailing
		
		return button
	}()
	
	private lazy var loginButton: UIButton = {
		let button = BaseButton()
		
		button.setTitle("Кіру", for: .normal)
		button.titleLabel?.font = .appFont(ofSize: 16, weight: .semiBold)
		button.layer.cornerRadius = 12
		button.backgroundColor = .Button.Primary.background
		button.tintColor = .Button.Primary.text
		
		button.addTarget(self, action: #selector(login), for: .primaryActionTriggered)
		
		return button
	}()
	
	private lazy var registerView: UIStackView = {
		let stackView = UIStackView()
		let label = {
			let label = UILabel()
				
			label.text = "Аккаунтыныз жоқ па?"
			label.font = .appFont(ofSize: 14)
			label.textColor = .Authentication.noAccountLabel
			
			return label
		}()
		
		let button = {
			let button = BaseButton()
				
			button.setTitle("Тіркелу", for: .normal)
			button.setTitleColor(.Authentication.noAccountButton, for: .normal)
			button.titleLabel?.font = .appFont(ofSize: 14, weight: .semiBold)
			
			button.addTarget(self, action: #selector(showRegister), for: .touchUpInside)
			
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

extension LoginViewController {
	private func setupViews() {
		view.backgroundColor = .appBackground
		
		view.addSubviews(titleLabel, subtitleLabel, formStackView, loginButton, registerView)
		formStackView.addArrangedSubviews(emailTextFieldView, passwordTextFieldView, forgotPasswordButton)
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
		
		loginButton.snp.makeConstraints { make in
			make.top.equalTo(formStackView.snp.bottom).offset(40)
			make.horizontalEdges.equalToSuperview().inset(24)
			make.height.equalTo(56)
		}
		
		registerView.snp.makeConstraints { make in
			make.top.equalTo(loginButton.snp.bottom).offset(24)
			make.centerX.equalToSuperview()
		}
	}
}

extension LoginViewController {
	@objc
	private func login() {
		guard let email = emailTextFieldView.textField.text,
			  !email.isEmpty else {
			emailTextFieldView.error = "Қате формат"
			return
		}
		
		guard let password = passwordTextFieldView.textField.text,
			  !password.isEmpty else {
			passwordTextFieldView.error = "Қате формат"
			return
		}
        
        let parameters = [
            "email": email,
            "password": password
        ]
		
		SVProgressHUD.show(withStatus: "Жүктеу...")
		
        let networkingService = DependencyHelper.shared.resolve(NetworkingService.self)!
        
        networkingService.fetch(endpoint: .login(parameters)) { (result: Result<LoginResponse, Error>) in
            SVProgressHUD.dismiss()
            switch result {
                case .success(let data):
                    AuthenticationService.shared.token = data.accessToken
                    self.showTabBar()
                case .failure(let error):
                    SVProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
	}
	
	@objc
	private func showRegister() {
        coordinator?.showRegistration()
    }
	
	private func showTabBar() {
        coordinator?.didSuccessfullyAuthenticated()
    }
}
