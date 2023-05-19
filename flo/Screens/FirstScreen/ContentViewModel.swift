//
//  ContentViewModel.swift
//  NewNavigationConcept
//
//  Created by Vasyl Nadtochii on 18.03.2023.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func onButtonTapped() {
        coordinator.push(
            navigationBar: NavigationBarImpl(
                title: "Second screen",
                displayMode: .large,
                coordinator: coordinator
            )
        ) { coordinator in
            SecondView(viewModel: .init(coordinator: coordinator))
        }
    }
    
    func onModalButtonTapped() {
        coordinator.modal(
            navigationTitle: "Modal Hardcoded title",
            presentationType: .fullScreenCover
        ) { coordinator in
            Text("Hello World")
                .onTapGesture {
                    coordinator.navigateBack()
                }
        }
    }
}
