//
//  NavigationBar.swift
//  flo
//
//  Created by Vasyl Nadtochii on 18.04.2023.
//

import SwiftUI

struct NavigationBarButton: Identifiable {

    var id: UUID = .init()
    
    enum ButtonPlacement {
        case leading
        case trailing
    }
    
    enum ButtonLabel {
        case image(image: Image)
        case string(title: String)
    }
    
    let label: ButtonLabel
    let action: () -> Void
    let placement: ButtonPlacement
    let foregroundColor: Color
}

protocol NavigationBar {

    var buttons: [NavigationBarButton] { get set }
    var title: String { get set }
    var displayMode: NavigationBarItem.TitleDisplayMode { get set }
    var coordinator: Coordinator? { get set }
}

struct NavigationBarImpl: NavigationBar {

    var buttons: [NavigationBarButton]
    var title: String
    var displayMode: NavigationBarItem.TitleDisplayMode
    var coordinator: Coordinator?

    init(
        title: String,
        displayMode: NavigationBarItem.TitleDisplayMode = .inline,
        coordinator: Coordinator?
    ) {
        self.title = title
        self.displayMode = displayMode
        self.coordinator = coordinator
        self.buttons = [
            .init(
                label: .image(image: Image(systemName: "chevron.backward")),
                action: { coordinator?.navigateBack() },
                placement: .leading,
                foregroundColor: .primary
            )
        ]
    }
    
    init(
        title: String,
        displayMode: NavigationBarItem.TitleDisplayMode = .inline,
        coordinator: Coordinator?,
        buttons: [NavigationBarButton]
    ) {
        self.title = title
        self.displayMode = displayMode
        self.coordinator = coordinator
        self.buttons = buttons
    }
}
