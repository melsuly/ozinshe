//
//  NetworkService.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 06.03.2024.
//

import Foundation
import Combine

protocol NetworkingService {
    func fetch<T: Decodable>(endpoint: Endpoints, completion: @escaping (Result<T, Error>) -> Void)
    func fetchWithCombine<T: Decodable>(endpoint: Endpoints) -> AnyPublisher<T, Error>
}
