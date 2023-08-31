//
//  FitnessAPIViewModel.swift
//  FitnessAPI
//
//  Created by Alireza on 2023-08-14.
//

import Foundation

class FitnessAPIViewModel: ObservableObject {
    @Published var exercises: [FitnessAPI] = []
    @Published var selectedBodyPart: String = "All"
    @Published var favoriteExercises: Set<String> = []
    private let apiExerciseLearnedRepository = APIExerciseLearnedRepository()


    let baseUrl = "https://exercisedb.p.rapidapi.com"
    let apiKey = "c8614cdc1bmshafdc99d9919ada5p1ce3b8jsnd88f55ea574a"
    
    init() {
        loadFavoriteExercises()
    }

    func fetchExercises() {
        print("Attempting to fetch exercises...")
        guard let url = URL(string: "\(baseUrl)/exercises") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("exercisedb.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Network error: \(error)")
            } else if let data = data {
                do {
                    let fetchedExercises = try JSONDecoder().decode([FitnessAPI].self, from: data)
                    DispatchQueue.main.async {
                        self.exercises = fetchedExercises
                    }
                } catch {
                    print("Error decoding: \(error)")
                }
            }
        }
        dataTask.resume()
    }
    func filterExercises() -> [FitnessAPI] {
        if selectedBodyPart == "All" {
            return exercises
        } else {
            return exercises.filter { $0.bodyPart == selectedBodyPart }
        }
    }
    func toggleFavorite(exercise: FitnessAPI) {
        if apiExerciseLearnedRepository.isLearned(exercise) {
            apiExerciseLearnedRepository.deleteExercise(exercise)
            favoriteExercises.remove(exercise.id)
        } else {
            apiExerciseLearnedRepository.createExercise(exercise)
            favoriteExercises.insert(exercise.id)
        }
    }

    func loadFavoriteExercises() {
        let exercises = apiExerciseLearnedRepository.getAllLearnedExercises()
        favoriteExercises = Set(exercises.map { $0._id })
    }
}




