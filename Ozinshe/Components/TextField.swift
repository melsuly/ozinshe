//
//  TextField.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit

class TextField: UITextField {
	
	override var isSecureTextEntry: Bool {
		didSet {
			showButton.isHidden = false
			insets.right = 52
		}
	}
	
	var icon: UIImage? {
		didSet {
			iconImageView.image = icon
		}
	}
	
	var insets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 44, bottom: 16, right: 16)
	
	override var placeholder: String? {
		didSet {
			guard let placeholder else {
				return
			}
			
			attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
				.foregroundColor: UIColor.TextField.placeholder,
				.font: UIFont.appFont(ofSize: 16)
			])
		}
	}
	
	// MARK: - UI Elements
	
	private lazy var iconImageView: UIImageView = {
		let imageView = UIImageView()
		
		imageView.tintColor = .TextField.icon
		imageView.contentMode = .scaleAspectFill
		
		return imageView
	}()
	
	private lazy var showButton: UIButton = {
		let button = BaseButton()
		
		button.setImage(.Icons.eye, for: .normal)
		button.tintColor = .TextField.button
		button.isHidden = true
		
		button.addAction(UIAction(handler: { _ in
			self.isSecureTextEntry.toggle()
		}), for: .primaryActionTriggered)
		
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: insets)
	}
	
	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: insets)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.inset(by: insets)
	}
}

extension TextField {
	private func setupView() {
		backgroundColor = .TextField.background
		textColor = .TextField.text
		layer.cornerRadius = 12
		layer.borderWidth = 1
		layer.borderColor = UIColor.TextField.border.cgColor
		font = .appFont(ofSize: 16, weight: .semiBold)
		tintColor = .accent
		
		addSubviews(iconImageView, showButton)
		
		addTarget(self, action: #selector(editingBegin), for: .editingDidBegin)
		addTarget(self, action: #selector(editingEnd), for: .editingDidEnd)
	}
	
	private func setupConstraints() {
		iconImageView.snp.makeConstraints { make in
			make.left.equalToSuperview().inset(16)
			make.size.equalTo(20)
			make.centerY.equalToSuperview()
		}
		
		showButton.snp.makeConstraints { make in
			make.verticalEdges.right.equalToSuperview()
			make.width.equalTo(52)
		}
	}
}

extension TextField {
	@objc
	private func editingBegin() {
		layer.borderColor = UIColor.TextField.activeBorder.cgColor
	}
	
	@objc
	private func editingEnd() {
		layer.borderColor = UIColor.TextField.border.cgColor
	}
}
