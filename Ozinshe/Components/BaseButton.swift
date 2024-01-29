//
//  BaseButton.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit

class BaseButton: UIButton {
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		UIView.animate(withDuration: 0.15) {
			self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		UIView.animate(withDuration: 0.15) {
			self.transform = .identity
		}
	}
}
