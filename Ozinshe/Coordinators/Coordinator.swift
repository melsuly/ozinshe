//
//  Coordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import Foundation

protocol Coordinator: AnyObject {
    var id: UUID { get }
    var childCoordinators: [Coordinator] { get }
    var router: Router { get }
    
    func add(child coordinator: Coordinator)
    func remove(child coordinator: Coordinator?)
}

extension Array where Element == Coordinator {
    subscript<T: Coordinator>(type: T.Type) -> T? {
        self.first(where: { $0 is T }) as? T
    }
}
