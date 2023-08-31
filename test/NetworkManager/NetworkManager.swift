//
//  NetworkManager.swift
//  test
//
//  Created by david on 2023-08-15.
//

import Foundation


class NetworkManager : ObservableObject{

    @Published var ingredients = [NinjasIngredient]()
    let apiKey: String = getValueForKey(key: "apikey") ?? ""

    func fetchIngredientData(_ foodTextQuery: String) {
        let query = foodTextQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.calorieninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data {
                    do {
                        let results = try decoder.decode(NinjasCalorieResults.self, from: safeData)
                        DispatchQueue.main.async {
                            print(results.items)
                            self.ingredients = results.items
                        }
                    } catch {
                        print(error)
                    } //: catch parser error
                } //: safeData

            } //: error
        } //: task
        task.resume()
    } //: func


}

