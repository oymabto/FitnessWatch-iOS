//
//  WorkoutView.swift
//  test
//
//  Created by Alireza on 2023-08-14.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject private var workoutViewModel = WorkoutViewModel()
    let items: [Items] = [
        Items(imageName: "figure.strengthtraining.traditional", title: "MANUAL"),
        Items(imageName: "figure.step.training", title: "EXERCISE COACH"),
    ]
    
    var body: some View {
//        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(), count: 2), spacing: 20) {
                        ForEach(items, id: \.title) { item in
                            NavigationLink(destination: destinationView(for: item.title)) {
                                CardsView(item: item).frame(width: 150, height: 150)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle("Home", displayMode: .inline)
//        }
    }
    func destinationView(for title: String) -> some View {
        switch title {
        case "MANUAL":
            return AnyView(ExerciseView(viewModel: workoutViewModel))
        case "EXERCISE COACH":
            return AnyView(FitnessAPIListView().environmentObject(FitnessAPIViewModel()))
        default:
            return AnyView(Text(title))
        }
    }
}

struct CardsView: View {
    let item: Items
    
    var body: some View {
        VStack {
            Image(systemName: item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(item.title)
                .font(.caption)
        }
        .padding()
        .frame(width: 150, height: 150)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct Items {
    let imageName: String
    let title: String
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
