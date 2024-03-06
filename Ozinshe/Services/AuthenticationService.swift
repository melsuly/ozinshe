//
//  AuthenticationService.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 30.01.2024.
//

import Foundation
import KeychainSwift

final class AuthenticationService {
	
    /// Shared instance  for singleton access.
	public static let shared = AuthenticationService()
	
    /// Private instance of `KeychainSwift` used for secure storage of the authentication token.
	private let keychain = KeychainSwift()
    
    /// The key used for storing and retrieving the authentication token from the keychain.
	private let key = "token"
	
    /// Public accessor for the authentication token.
    /// The getter retrieves the token from the keychain, returning an empty string if not found.
    /// The setter updates the token value in the keychain.
	var token: String {
		get {
			keychain.get(key) ?? ""
		}
		set {
			keychain.set(newValue, forKey: key)
		}
	}
	
    /// Indicates whether the user is authenticated based on the presence of an authentication token.
	var isAuthenticated: Bool {
		!token.isEmpty
	}
	
    /// Private initializer to enforce singleton usage.
	private init() {}
}
