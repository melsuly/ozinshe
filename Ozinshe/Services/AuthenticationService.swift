//
//  AuthenticationService.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 30.01.2024.
//

import Foundation
import KeychainSwift

final class AuthenticationService {
	
	public static let shared = AuthenticationService()
	
	private let keychain = KeychainSwift()
	private let key = "token"
	
	var token: String {
		get {
			keychain.get(key) ?? ""
		}
		set {
			keychain.set(newValue, forKey: key)
		}
	}
	
	var isAuthenticated: Bool {
		!token.isEmpty
	}
	
	private init() {}
}
