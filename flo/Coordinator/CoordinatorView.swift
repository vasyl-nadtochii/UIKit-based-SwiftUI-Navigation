//
//  CoordinatorView.swift
//  flo
//
//  Created by Vasyl Nadtochii on 05.04.2023.
//

import SwiftUI
import UIKit

class CoordinatorHelper {

    var navigationStack: [UINavigationController]
    var rootNavigationControllerId: String
    var initialNavigationTitle: String
    var navigationBarInitiallyHidden: Bool
    
    init(navigationBarInitiallyHidden: Bool, initialNavigationTitle: String) {
        self.navigationBarInitiallyHidden = navigationBarInitiallyHidden
        self.initialNavigationTitle = initialNavigationTitle
        self.rootNavigationControllerId = String()
        self.navigationStack = []
    }
}

struct CoordinatorView<Screen: View>: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UINavigationController
    typealias AppCoordinator = Coordinator

    @ViewBuilder private let initialScreen: (AppCoordinator) -> Screen
    
    private let coordinator: AppCoordinator
    private let helper: CoordinatorHelper
    
    init(
        navigationBarInitiallyHidden: Bool = false,
        initialNavigationTitle: String,
        initialScreen: @escaping (AppCoordinator) -> Screen
    ) {
        self.initialScreen = initialScreen
        self.coordinator = .init()
        self.helper = .init(
            navigationBarInitiallyHidden: navigationBarInitiallyHidden,
            initialNavigationTitle: initialNavigationTitle
        )
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        let screenViewController = UIHostingController(rootView: initialScreen(coordinator))
        screenViewController.title = helper.initialNavigationTitle

        let navigation = UINavigationController()
        navigation.setNavigationBarHidden(helper.navigationBarInitiallyHidden, animated: false)
        navigation.pushViewController(
            screenViewController,
            animated: false
        )

        setupHelper(navigation: navigation)
        setupCoordinator()
        return navigation
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

// MARK: Navigation Core

private extension CoordinatorView {
    
    func setupHelper(navigation: UINavigationController) {
        helper.rootNavigationControllerId = navigation.stringIdentifier
        helper.navigationStack.append(navigation)
    }

    func setupCoordinator() {
        coordinator.onResult = { result in
            guard let navigation = helper.navigationStack.last else { return }
            switch result {
            case .push(let pushedTitle, let viewBuilder):
                let screen = UIHostingController(rootView: viewBuilder(coordinator))
                screen.title = pushedTitle
                navigation.pushViewController(screen, animated: true)
            case .navigateBack:
                if navigation.viewControllers.count != 1 {
                    navigation.popViewController(animated: true)
                } else {
                    guard navigation.stringIdentifier != helper.rootNavigationControllerId else { return }
                    navigation.dismiss(animated: true)
                }
            case .alert(let title, let message, let actions):
                navigation.present(
                    createAlert(title: title, message: message, actions: actions),
                    animated: true
                )
            case .modal(let navigationTitle, let presentationType, let viewBuilder):
                let screen = UIHostingController(rootView: viewBuilder(coordinator))
                screen.title = navigationTitle

                let viewController = CoordinatorUINavigationController(
                    rootViewController: screen,
                    disappearAction: { helper.navigationStack.removeLast() }
                )
                
                helper.navigationStack.append(viewController)
                setupModal(
                    presentationType: presentationType,
                    viewController: viewController
                )

                navigation.present(viewController, animated: true)
            case .popToRoot:
                navigation.popToRootViewController(animated: true)
            }
        }
    }
}

private extension CoordinatorView {
    
    func setupModal(
        presentationType: AppCoordinator.ModalPresentationType,
        viewController: UIViewController
    ) {
        switch presentationType {
        case .sheet(let sizeModifiers):
            viewController.modalPresentationStyle = .pageSheet

            guard !sizeModifiers.isEmpty else { return }
    
            var detents = [UISheetPresentationController.Detent]()
            for sizeModifier in sizeModifiers {
                switch sizeModifier {
                case .fixed(let size):
                    detents.append(.custom { _ in size })
                case .relative(let multiplier):
                    detents.append(.custom { $0.maximumDetentValue * multiplier })
                }
            }
            
            viewController.sheetPresentationController?.detents = detents
        case .fullScreenCover:
            viewController.modalPresentationStyle = .overFullScreen
        }
    }
    
    func createAlert(
        title: String,
        message: String,
        actions: [UIAlertAction]
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if actions.isEmpty {
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default
                )
            )
        } else {
            for action in actions {
                alert.addAction(action)
            }
        }

        return alert
    }
}
