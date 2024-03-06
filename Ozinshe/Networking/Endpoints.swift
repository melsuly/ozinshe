//
//  Endpoints.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 06.03.2024.
//

import Foundation
import Alamofire

enum Endpoints {
    case login([String: Any])
    case registration
    case homeMovies
    
    /// The base URL for all API requests.
    var baseURL: String {
       "http://api.ozinshe.com"
    }
    
    /// The URL prefix to be applied based on the endpoint category.
    ///
    /// Authentication-related endpoints use a different prefix from the core functionalities of the app.
    var prefix: String {
        switch self {
            case .login, .registration:
                return "/auth/V1"
            default:
                return "/core/V1"
        }
    }
    
    /// The specific path of the endpoint.
    ///
    /// Combined with `baseURL` and `prefix` to form the full URL for the request.
    var path: String {
        switch self {
            case .login:
                "/signin"
            case .registration:
                "/signup"
            case .homeMovies:
                "/movies/main"
        }
    }
    
    /// The full URL for the endpoint, created by concatenating `baseURL`, `prefix`, and `path`.
    ///
    /// Percent encoding is applied to ensure the URL is valid.
    var fullURL: URL {
        URL(string: "\(baseURL)\(prefix)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    /// The HTTP method used for the request.
    ///
    /// Determines whether the request is a `GET` or `POST` based on the nature of the endpoint.
    var method: HTTPMethod {
        switch self {
            case .login, .registration:
                return .post
            default:
                return .get
        }
    }
    
    /// Parameters to be included in the request.
    ///
    /// For endpoints like login, parameters include user credentials. Other endpoints may not require parameters.
    var parameters: Parameters? {
        switch self {
            case .login(let data):
                return data
            case .registration:
                return [:]
            default:
                return nil
        }
    }
    
    /// Indicates whether the endpoint requires authentication.
    ///
    /// Authentication is not required for login and registration but is needed for other endpoints.
    var requiresAuth: Bool {
        switch self {
            case .login(_), .registration:
                return false
            default:
                return true
        }
    }
}
