//
//  OnboardingCell.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit
import SnapKit

final class OnboardingCell: UICollectionViewCell, ReusableCell {
		
	// MARK: - UI Elements
	
	private lazy var backgroundImageView: UIImageView = {
		let imageView = UIImageView()
		
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		
		return imageView
	}()
	
	private lazy var overlayImageView: UIImageView = {
		let imageView = UIImageView()
		
		imageView.image = .Onboarding.overlay
		imageView.contentMode = .scaleAspectFill
		
		return imageView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		
		label.font = .appFont(ofSize: 24, weight: .bold)
		label.textColor = .Onboarding.title
		label.textAlignment = .center
		
		return label
	}()
	
	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		
		label.font = .appFont(ofSize: 14, weight: .medium)
		label.textColor = .Onboarding.subtitle
		label.textAlignment = .center
		label.numberOfLines = 0
		
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(for item: OnboardingItem) {
		backgroundImageView.image = item.image
		titleLabel.text = item.title
		subtitleLabel.attributedText = NSAttributedString(string: item.subtitle, attributes: [
			.paragraphStyle: {
				let paragraphStyle = NSMutableParagraphStyle()
				
				paragraphStyle.alignment = .center
				paragraphStyle.minimumLineHeight = 22
				
				return paragraphStyle
			}()
		])
	}
}

extension OnboardingCell {
	private func setupView() {
		contentView.addSubviews(backgroundImageView, overlayImageView, titleLabel, subtitleLabel)
	}
	
	private func setupConstraints() {
		backgroundImageView.snp.makeConstraints { make in
			make.top.horizontalEdges.equalToSuperview()
			make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(274)
		}
		
		overlayImageView.snp.makeConstraints { make in
			make.top.equalTo(contentView.safeAreaLayoutGuide).inset(adaptiveSize(for: 190))
			make.horizontalEdges.bottom.equalToSuperview()
		}
		
		titleLabel.snp.makeConstraints { make in
			make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(adaptiveSize(for: 276))
			make.horizontalEdges.equalToSuperview().inset(40)
		}
	
		subtitleLabel.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(24)
			make.horizontalEdges.equalToSuperview().inset(32)
		}
	}
}
