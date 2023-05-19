//
//  floApp.swift
//  flo
//
//  Created by Vasyl Nadtochii on 05.04.2023.
//

import SwiftUI

@main
struct floApp: App {
    var body: some Scene {
        WindowGroup {
//            CoordinatorView(
//                initialNavigationBar: NavigationBarImpl(
//                    title: "Start",
//                    coordinator: nil,
//                    buttons: []
//                )
//            ) { coordinator in
//                ContentView(viewModel: .init(coordinator: coordinator))
//            }
            SecondView(viewModel: .init(coordinator: Coordinator()))
        }
    }
}
