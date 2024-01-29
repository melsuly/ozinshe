//
//  UIFont+Extension.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 29.01.2024.
//

import UIKit

extension UIFont {
	public enum FontWeights: String {
		case light = "Light"
		case regular = "Regular"
		case medium = "Medium"
		case semiBold = "SemiBold"
		case bold = "Bold"
	}
	
	private static let appFontName = "SFProDisplay"
	
	public static func appFont(ofSize size: Double, weight: FontWeights = .regular) -> UIFont {
		guard let font = UIFont(name: "\(appFontName)-\(weight.rawValue)", size: size) else {
			fatalError("Font not found!")
		}
		
		return font
	}
}
