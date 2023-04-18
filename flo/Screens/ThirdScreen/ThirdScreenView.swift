//
//  ThirdScreenView.swift
//  NewNavigationConcept
//
//  Created by Vasyl Nadtochii on 21.03.2023.
//

import SwiftUI

struct ThirdScreenView: View {
    
    var viewModel: ThirdScreenViewModel

    var body: some View {
        ZStack {
            Color.green.opacity(0.5)
            VStack {
                Button {
                    viewModel.onBackButtonTapped()
                } label: {
                    Text("Go Back")
                        .padding()
                }
                
                Button {
                    viewModel.onAlertButtonTapped()
                } label: {
                    Text("Show me alert!")
                        .padding()
                }
                
                Button {
                    viewModel.onRootButtonTapped()
                } label: {
                    Text("Go Back to the first screen")
                        .padding()
                }
                
                Button {
                    viewModel.onMoveForwardButtonTapped()
                } label: {
                    Text("Move next")
                        .padding()
                }
            }
        }
    }
}
