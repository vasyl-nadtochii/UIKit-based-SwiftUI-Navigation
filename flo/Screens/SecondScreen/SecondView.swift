//
//  SecondView.swift
//  NewNavigationConcept
//
//  Created by Vasyl Nadtochii on 21.03.2023.
//

import SwiftUI
import ScalingHeaderScrollView

struct SecondView: View {

    var viewModel: SecondViewModel
    
    var body: some View {
        ScalingHeaderScrollView {
            ZStack {
                Rectangle()
                    .fill(.red)
                Text("header")
            }
        } content: {
            ZStack {
                Color.cyan.frame(height: UIScreen.main.bounds.height - 100)
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
    }
}
