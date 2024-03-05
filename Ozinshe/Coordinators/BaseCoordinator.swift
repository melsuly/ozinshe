//
//  BaseCoordinator.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import Foundation

class BaseCoordinator: NSObject, Coordinator {
    var id: UUID = UUID()
    var childCoordinators: [Coordinator] = []
    var router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func add(child coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(child coordinator: Coordinator?) {
        guard let coordinator = coordinator,
              let index = childCoordinators.firstIndex(where: { $0.id == coordinator.id })
        else { return }
        
        childCoordinators.remove(at: index)
    }
}
