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
    
    var baseURL: String {
       "http://api.ozinshe.com"
    }
    
    var prefix: String {
        switch self {
            case .login, .registration:
                return "/auth/V1"
            default:
                return "/core/V1"
        }
    }
    
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
    
    var fullURL: URL {
        URL(string: "\(baseURL)\(prefix)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }
    
    var method: HTTPMethod {
        switch self {
            case .login, .registration:
                return .post
            default:
                return .get
        }
    }
    
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
    
    var requiresAuth: Bool {
        switch self {
            case .login(_), .registration:
                return false
            default:
                return true
        }
    }
}
