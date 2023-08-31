//
//  FitnessAPIListView.swift
//  FitnessAPI
//
//  Created by Alireza on 2023-08-14.
//

import Foundation
import SwiftUI

struct FitnessAPIListView: View {
    @ObservedObject var viewModel = FitnessAPIViewModel()
    
    
    let bodyParts: [String] = [
        "All",
        "back",
        "cardio",
        "chest",
        "lower arms",
        "lower legs",
        "neck",
        "shoulders",
        "upper arms",
        "upper legs",
        "waist"
    ]
    
    var body: some View {
        VStack {
            Text("List of Exercises")
                .font(.title)
                .padding(.bottom, 16)
                .onAppear {
                    print("Title appeared!")
                }
            // Dropdown
            Menu {
                ForEach(bodyParts, id: \.self) { part in
                    Button(action: {
                        viewModel.selectedBodyPart = part
                    }) {
                        Text(part.capitalized)
                    }
                }
            } label: {
                Text("Select body part: \(viewModel.selectedBodyPart)")
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            
            List(viewModel.filterExercises(), id: \.id) { fitnessAPI in
                FitnessView(fitnessAPI: fitnessAPI)
            }.onAppear {
                print("List appeared!")
            }.padding(.bottom, 35)
        }.onAppear(perform: {
            print("Attempting to fetch exercises from the view...")
            viewModel.fetchExercises()
        })
    }
}

