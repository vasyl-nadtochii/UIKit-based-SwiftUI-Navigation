//
//  SecondViewModel.swift
//  NewNavigationConcept
//
//  Created by Vasyl Nadtochii on 21.03.2023.
//

import Foundation
import SwiftUI

class SecondViewModel {
    
    let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func onBackButtonTapped() {
        coordinator.navigateBack()
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
    
    func onModalButtonTapped() {
        coordinator.modal(
            navigationTitle: "Modal title",
            presentationType: .sheet(
                sizeModifiers: [
                    .fixed(height: 400),
                    .relative(maxHeightMultiplier: 0.9),
                    .relative(maxHeightMultiplier: 1)
                ]
            )
        ) { coordinator in
            SecondView(viewModel: .init(coordinator: coordinator))
        }
    }
}
