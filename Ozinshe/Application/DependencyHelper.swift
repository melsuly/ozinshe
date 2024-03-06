//
//  DependencyHelper.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 06.03.2024.
//

import Foundation
import Swinject

class DependencyHelper {
    
    public static let shared = DependencyHelper()
    let container = Container()
    
    private init() {
        bootstrapDependencies()
    }
    
    private func bootstrapDependencies() {
        container.register(NetworkingService.self) { _ in
            AlamofireNetworkingService()
        }
        
        container.register(OnboardingViewModel.self) { _ in
            OnboardingViewModel()
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
}
