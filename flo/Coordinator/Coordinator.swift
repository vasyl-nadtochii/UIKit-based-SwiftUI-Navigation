//
//  Coordinator.swift
//  flo
//
//  Created by Vasyl Nadtochii on 05.04.2023.
//

import SwiftUI
import UIKit

class Coordinator {
    
    enum ModalPresentationType {
        case sheet(sizeModifiers: [SheetSizeModifier] = [])
        case fullScreenCover
    }
    
    enum Result {
        case push(navigationBar: NavigationBar, screen: (Coordinator) -> AnyView)
        case navigateBack
        case alert(title: String, message: String, actions: [UIAlertAction])
        case modal(
            navigationTitle: String,
            presentationType: ModalPresentationType,
            screen: (Coordinator) -> AnyView
        )
        case popToRoot
    }
    
    var onResult: ((Result) -> Void)?

    func push<T: View>(
        navigationBar: NavigationBar,
        screen: @escaping (Coordinator) -> T
    ) {
        self.onResult?(
            .push(navigationBar: navigationBar) { coordinator in
                screen(coordinator).anyView
            }
        )
    }
    
    func navigateBack() {
        self.onResult?(.navigateBack)
    }
    
    func alert(title: String, message: String, actions: [UIAlertAction]) {
        self.onResult?(.alert(title: title, message: message, actions: actions))
    }
    
    func modal<T: View>(
        navigationTitle: String,
        presentationType: ModalPresentationType,
        screen: @escaping (Coordinator) -> T
    ) {
        self.onResult?(
            .modal(navigationTitle: navigationTitle, presentationType: presentationType) { coordinator in
                screen(coordinator).anyView
            }
        )
    }
    
    func popToRoot() {
        self.onResult?(.popToRoot)
    }
}
