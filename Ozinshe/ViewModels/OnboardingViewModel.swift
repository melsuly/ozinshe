//
//  OnboardingViewModel.swift
//  Ozinshe
//
//  Created by Nurasyl Melsuly on 05.03.2024.
//

import Foundation
import Combine

class OnboardingViewModel: NSObject {
    @Published var items: [OnboardingItem] = [
        OnboardingItem(
            title: "ÖZINŞE-ге қош келдің!",
            subtitle: "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары",
            image: .Onboarding.slide1
        ),
        OnboardingItem(
            title: "ÖZINŞE-ге қош келдің!",
            subtitle: "Кез келген құрылғыдан қара\nСүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара",
            image: .Onboarding.slide2
        ),
        OnboardingItem(
            title: "ÖZINŞE-ге қош келдің!",
            subtitle: "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз",
            image: .Onboarding.slide3
        ),
    ]
    
    func itemsCount() -> Int {
        return items.count
    }
    
    func item(for index: Int) -> OnboardingItem {
        return items[index]
    }
}
