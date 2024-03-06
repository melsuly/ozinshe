//
//  AlamofireNetworkingService.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 06.03.2024.
//

import Alamofire
import Combine

class AlamofireNetworkingService: NetworkingService {
    
    /// Fetches data from a specified endpoint asynchronously, using a traditional callback mechanism.
    /// The method constructs a request based on the provided endpoint and decodes the response into a specified Decodable type.
    ///
    /// - Parameters:
    ///   - endpoint: The `Endpoints` enum case representing the API endpoint to fetch data from.
    ///   - completion: A closure that gets called upon request completion, returning a Result of the requested Decodable type or an Error.
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
    
    /// Fetches data from a specified endpoint asynchronously, using Combine for reactive programming.
    /// The method constructs a request based on the provided endpoint and decodes the response into a specified Decodable type, returning a publisher.
    ///
    /// - Parameter endpoint: The `Endpoints` enum case representing the API endpoint to fetch data from.
    /// - Returns: A publisher that emits the requested Decodable type or an Error.
    func fetchWithCombine<T>(endpoint: Endpoints) -> AnyPublisher<T, Error> where T : Decodable {
        let request = makeRequest(for: endpoint)
        return request.publishDecodable(type: T.self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    /// Constructs an Alamofire `DataRequest` for a given endpoint, including setting up headers for requests that require authentication.
    ///
    /// - Parameter endpoint: The `Endpoints` enum case representing the API endpoint for which to construct the request.
    /// - Returns: An Alamofire `DataRequest` configured with the endpoint's URL, method, parameters, and headers.
    private func makeRequest(for endpoint: Endpoints) -> DataRequest {
        let url = endpoint.fullURL
        let headers: HTTPHeaders? = endpoint.requiresAuth ? [.authorization(bearerToken: AuthenticationService.shared.token)] : nil
        
        return AF.request(url, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default, headers: headers)
    }
}

