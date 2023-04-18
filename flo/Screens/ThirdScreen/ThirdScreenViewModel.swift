//
//  ThirdScreenViewModel.swift
//  NewNavigationConcept
//
//  Created by Vasyl Nadtochii on 21.03.2023.
//

import SwiftUI

class ThirdScreenViewModel {
    
    let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func onBackButtonTapped() {
        coordinator.navigateBack()
    }
    
    func onAlertButtonTapped() {
        coordinator.alert(
            title: "Third screen alert",
            message: "Some pretty native alert from third screen",
            actions: [
                .init(title: "Action #1", style: .default) { _ in
                    print("Action #1 tapped")
                },
                .init(title: "Cancel", style: .cancel),
                .init(title: "Action #2", style: .destructive)
            ]
        )
    }
    
    func onRootButtonTapped() {
        coordinator.popToRoot()
    }
    
    func onMoveForwardButtonTapped() {
        coordinator.push(
            navigationBar: NavigationBarImpl(
                title: "Third screen",
                displayMode: .inline,
                coordinator: coordinator
            )
        ) { coordinator in
            ThirdScreenView(viewModel: .init(coordinator: coordinator))
        }
    }
}
