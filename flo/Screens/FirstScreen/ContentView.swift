//
//  ContentView.swift
//  NewNavigationConcept
//
//  Created by Vasyl Nadtochii on 17.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        VStack {
            Button {
                viewModel.onButtonTapped()
            } label: {
                Text("Start")
                    .padding()
            }
            Button {
                viewModel.onModalButtonTapped()
            } label: {
                Text("Show Modal")
                    .padding()
            }
        }
    }
}
