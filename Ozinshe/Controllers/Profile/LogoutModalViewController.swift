//
//  LogoutModalViewController.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 30.01.2024.
//

import UIKit
import SnapKit
import PanModal

protocol LogoutModalViewControllerDelegate: AnyObject {
    func userDidLogout()
}

final class LogoutModalViewController: UIViewController, PanModalPresentable {
	
	// MARK: - Properties
	
    weak var delegate: LogoutModalViewControllerDelegate?
    
	var panModalBackgroundColor: UIColor = .Modal.background
	var cornerRadius: CGFloat = 32
	var showDragIndicator: Bool = false
	var longFormHeight: PanModalHeight = .intrinsicHeight
	
	// MARK: - UI Elements
	
	var panScrollable: UIScrollView? = nil
	private lazy var grabberView: UIView = {
		let view = UIView()
		
		view.backgroundColor = .Modal.grabber
		view.layer.cornerRadius = 2.5
		
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		
		label.text = "Шығу"
		label.font = .appFont(ofSize: 24, weight: .bold)
		label.textColor = .Modal.content
		
		return label
	}()
	
	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		
		label.text = "Сіз шынымен аккаунтыныздан"
		label.font = .appFont(ofSize: 16)
		label.textColor = .Modal.gray
		
		return label
	}()
	
	private lazy var logoutButton: UIButton = {
		let button = BaseButton()
		
		button.setTitle("Ия, шығу", for: .normal)
		button.titleLabel?.font = .appFont(ofSize: 16, weight: .semiBold)
		button.layer.cornerRadius = 12
		button.backgroundColor = .Button.Primary.background
		button.tintColor = .Button.Primary.text
		
		button.addTarget(self, action: #selector(logout), for: .primaryActionTriggered)
		
		return button
	}()
	
	private lazy var cancelButton: UIButton = {
		let button = BaseButton()
		
		button.setTitle("Жоқ", for: .normal)
		button.setTitleColor(.Button.Primary.stroke, for: .normal)
		button.titleLabel?.font = .appFont(ofSize: 16, weight: .semiBold)
		
		button.addTarget(self, action: #selector(cancel), for: .primaryActionTriggered)
		
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		setupConstraints()
	}
}

extension LogoutModalViewController {
	private func setupViews() {
		view.backgroundColor = .Modal.plate
		view.addSubviews(grabberView, titleLabel, subtitleLabel, logoutButton, cancelButton)
	}
	
	private func setupConstraints() {
		grabberView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(21)
			make.width.equalTo(64)
			make.height.equalTo(5)
			make.centerX.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(grabberView.snp.bottom).offset(32)
			make.horizontalEdges.equalToSuperview().inset(24)
		}
		
		subtitleLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.horizontalEdges.equalToSuperview().inset(24)
		}
		
		logoutButton.snp.makeConstraints { make in
			make.top.equalTo(subtitleLabel.snp.bottom).offset(32)
			make.horizontalEdges.equalToSuperview().inset(24)
			make.height.equalTo(56)
		}
		
		cancelButton.snp.makeConstraints { make in
			make.top.equalTo(logoutButton.snp.bottom).offset(8)
			make.horizontalEdges.equalToSuperview().inset(24)
			make.height.equalTo(56)
			make.bottom.equalToSuperview().inset(32)
		}
	}
}

extension LogoutModalViewController {
	@objc
	private func logout() {
        delegate?.userDidLogout()
    }
	
	@objc
	private func cancel() {
		dismiss(animated: true)
	}
}
