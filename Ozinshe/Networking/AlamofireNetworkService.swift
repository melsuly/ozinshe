//
//  AlamofireNetworkingService.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 06.03.2024.
//

import Alamofire
import Combine

class AlamofireNetworkingService: NetworkingService {
    
    // Non combine
    func fetch<T>(endpoint: Endpoints, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let request = makeRequest(for: endpoint)
        request.responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    // Combine
    func fetchWithCombine<T>(endpoint: Endpoints) -> AnyPublisher<T, Error> where T : Decodable {
        let request = makeRequest(for: endpoint)
        return request.publishDecodable(type: T.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    private func makeRequest(for endpoint: Endpoints) -> DataRequest {
        let url = endpoint.fullURL
        let headers: HTTPHeaders? = endpoint.requiresAuth ? [.authorization(bearerToken: AuthenticationService.shared.token)] : nil
        
        return AF.request(url, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default, headers: headers)
    }
}

