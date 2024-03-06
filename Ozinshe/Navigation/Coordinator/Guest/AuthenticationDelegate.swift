//
//  AuthenticationDelegate.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 06.03.2024.
//

import Foundation

protocol AuthenticationDelegate: AnyObject {
    func didSuccessfullyAuthenticated()
    func showRegistration()
    func showLogin()
}
