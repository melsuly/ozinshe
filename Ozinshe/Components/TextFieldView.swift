//
//  TextFieldView.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit
import SnapKit

class TextFieldView: UIView {
	var error: String? {
		didSet {
			errorLabel.text = error
			setupError()
		}
	}
	
	var title: String? {
		didSet {
			titleLabel.text = title
		}
	}
	
	var placeholder: String? {
		didSet {
			textField.placeholder = placeholder
		}
	}
	
	// MARK: - UI Elements
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		
		label.font = .appFont(ofSize: 14, weight: .bold)
		label.textColor = .TextField.label
		
		return label
	}()
	
	lazy var textField: TextField = {
		let textField = TextField()
		
		return textField
	}()
	
	private lazy var errorLabel: UILabel = {
		let label = UILabel()
		
		label.font = .appFont(ofSize: 14)
		label.textColor = .TextField.error
		
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TextFieldView {
	private func setupViews() {
		addSubviews(titleLabel, textField, errorLabel)
		textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
	}
	
	private func setupConstraints() {
		titleLabel.snp.makeConstraints { make in
			make.top.horizontalEdges.equalToSuperview()
		}
		
		textField.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(6)
			make.horizontalEdges.equalToSuperview()
		}

		errorLabel.snp.makeConstraints { make in
			make.top.equalTo(textField.snp.bottom)
			make.bottom.equalToSuperview()
		}
	}
	
	private func setupError() {
		if error != nil {
			textField.layer.borderColor = UIColor.TextField.error.cgColor
			
			errorLabel.snp.remakeConstraints { make in
				make.top.equalTo(textField.snp.bottom).offset(16)
				make.bottom.equalToSuperview()
			}
		} else {
			textField.layer.borderColor = UIColor.TextField.border.cgColor
			
			errorLabel.snp.remakeConstraints { make in
				make.top.equalTo(textField.snp.bottom)
				make.bottom.equalToSuperview()
			}
		}
	}
}

extension TextFieldView {
	@objc
	private func editingChanged() {
		error = nil
	}
}
