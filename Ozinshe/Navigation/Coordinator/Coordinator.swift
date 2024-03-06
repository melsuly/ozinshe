//
//  Coordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import Foundation

protocol Coordinator: AnyObject {
    
    /// Unique identifier for the coordinator.
    var id: UUID { get }
    
    /// A collection of child coordinators managed by this coordinator.
    var childCoordinators: [Coordinator] { get }
    
    /// Router responsible for managing the navigation logic.
    var router: Router { get }
    
    /// Adds a child coordinator to the list of child coordinators.
    ///
    /// - Parameter coordinator: The coordinator to be added as a child.
    func add(child coordinator: Coordinator)
    
    /// Removes a child coordinator from the list of child coordinators.
    ///
    /// - Parameter coordinator: The coordinator to be removed. If `nil`, no action is taken.
    func remove(child coordinator: Coordinator?)
}

extension Array where Element == Coordinator {
    
    /// Subscript to get the first coordinator of a specific type.
    ///
    /// - Parameter type: The type of coordinator to retrieve.
    /// - Returns: The first coordinator of the specified type if found; otherwise, `nil`.
    subscript<T: Coordinator>(type: T.Type) -> T? {
        self.first(where: { $0 is T }) as? T
    }
}
