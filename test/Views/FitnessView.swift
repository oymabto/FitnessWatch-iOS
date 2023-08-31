//
//  FitnessView.swift
//  FitnessAPI
//
//  Created by Alireza on 2023-08-14.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct FitnessView: View {
    var fitnessAPI: FitnessAPI
    @EnvironmentObject var viewModel: FitnessAPIViewModel

    
    var body: some View {
        VStack(alignment: .center) {
            Text(fitnessAPI.name)
                .font(.headline)
                .padding(.bottom, 8)
//                .background(Color.gray.opacity(0.1))
                .onAppear {
                    print("Displayed exercise: \(fitnessAPI.name)")
                }
            
            WebImage(url: URL(string: fitnessAPI.gifUrl))
                .placeholder(Image(systemName: "photo"))
                .frame(height: 200)
                .cornerRadius(10)
                .onAppear {
                    print("Attempting to load image from URL: \(fitnessAPI.gifUrl)")
                }
            Text("Body Part: \(fitnessAPI.bodyPart)")
                .padding(.top, 8)
                .onAppear {
                    print("Displayed body part: \(fitnessAPI.bodyPart)")
                }
            Text("Target: \(fitnessAPI.target)")
//                .padding(.top, 8)
                .onAppear {
                    print("Displayed target: \(fitnessAPI.target)")
                }
            
                Button(action: {
                    viewModel.toggleFavorite(exercise: fitnessAPI)
                }) {
                    Image(systemName: viewModel.favoriteExercises.contains(fitnessAPI.id) ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.favoriteExercises.contains(fitnessAPI.id) ? .red : .gray)
                }
            
        }
        .padding([.leading, .trailing])
    }
}
