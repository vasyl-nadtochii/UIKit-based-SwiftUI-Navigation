//
//  SecondView.swift
//  NewNavigationConcept
//
//  Created by Vasyl Nadtochii on 21.03.2023.
//

import SwiftUI

struct SecondView: View {

    var viewModel: SecondViewModel
    
    var body: some View {
        VStack {
            Button {
                viewModel.onBackButtonTapped()
            } label: {
                Text("Go Back")
                    .padding()
            }
            
            Button {
                viewModel.onModalButtonTapped()
            } label: {
                Text("Show Modal")
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
