//
//  CalorieBurnerView.swift
//  test
//
//  Created by Alireza on 2023-08-19.
//

import Foundation
import SwiftUI
import RealmSwift

struct CalorieBurnerView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    @EnvironmentObject var realmViewModel: RealmViewModel
    @State private var calories: String = ""
    @State private var time: String = ""
    @State private var heartRate: String = ""
    @State private var calculatedValue: String = ""
    @State private var displayColor: Color = .black
    @State private var errorMessage: String? = nil
    @State private var showAlert: Bool = false
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Calorie Burner Calculator")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Text("Fill in 2 of the 3 fields and press Calculate!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 60)
            
            TextField("Calories", text: $calories)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .foregroundColor(calories != "" && calculatedValue.contains("Calories burned") ? .green : .black)
            
            TextField("Time (minutes)", text: $time)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .foregroundColor(time != "" && calculatedValue.contains("Time required") ? .green : .black)
            
            TextField("Heart Rate (bpm)", text: $heartRate)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .foregroundColor(heartRate != "" && calculatedValue.contains("Heart rate required") ? .green : .black)
            
            Button("Calculate") {
                calculateValues()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .background(gradient)
            .foregroundColor(.white)
            .cornerRadius(8)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Input Error"), message: Text("Please fill in 2 out of the 3 fields."), dismissButton: .default(Text("Got it!")))
            }
            
        }
        .padding()
        .onAppear{
            if let currentUser = realmViewModel.currentUser, let email = currentUser.profile.email {
                profileViewModel.setProfile(byEmail: email)
            }
        }
    }
    
    func calculateValues() {
        calculatedValue = ""
        let nonEmptyFields = [calories, time, heartRate].filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }.count
        
        if nonEmptyFields != 2 {
            showAlert = true
            return
        }
        
        errorMessage = nil
        guard let selectedProfile = profileViewModel.selectedProfile else {
            errorMessage = "Error: No selected profile."
            return
        }
        
        let gender = selectedProfile.gender ?? .Male
        let weight = selectedProfile.weight ?? 0.0
        let age = getAge()
        
        if calories.isEmpty {
            calculateCaloriesFor(gender: gender, weight: Double(weight), age: age)
        } else if time.isEmpty {
            calculateTimeFor(gender: gender, weight: Double(weight), age: age)
        } else if heartRate.isEmpty {
            calculateHeartRateFor(gender: gender, weight: Double(weight), age: age)
        } else {
            errorMessage = "All fields are filled. Please empty one field for calculation."
        }
    }
    
    func calculateCaloriesFor(gender: Gender, weight: Double, age: Double) {
        guard let timeValue = Double(time), let heartRateValue = Double(heartRate) else {
            errorMessage = "Error converting time or heartRate to Double"
            return
        }
        
        let caloriesBurned: Double
        
        switch gender {
        case .Female:
            caloriesBurned = timeValue * ((0.4472 * heartRateValue - 0.1263 * weight + 0.074 * age - 20.4022) / 4.184)
        default: // Assuming Male
            caloriesBurned = timeValue * ((0.6309 * heartRateValue + 0.1988 * weight + 0.2017 * age - 55.0969) / 4.184)
        }
        
        //        calories = String(format: "%.2f", caloriesBurned)
        calories = String(Int(caloriesBurned))
        calculatedValue = "Calories burned: \(calories)"
    }
    
    func calculateTimeFor(gender: Gender, weight: Double, age: Double) {
        guard let caloriesValue = Double(calories), let heartRateValue = Double(heartRate) else {
            errorMessage = "Error converting calories or heartRate to Double"
            return
        }
        
        let timeRequired: Double
        
        switch gender {
        case .Female:
            timeRequired = caloriesValue * 4.184 / (0.4472 * heartRateValue - 0.1263 * weight + 0.074 * age - 20.4022)
        default: // Assuming Male
            timeRequired = caloriesValue * 4.184 / (0.6309 * heartRateValue + 0.1988 * weight + 0.2017 * age - 55.0969)
        }
        
        //        time = String(format: "%.2f", timeRequired)
        time = String(Int(timeRequired))
        calculatedValue = "Time required: \(time) minutes"
    }
    
    func calculateHeartRateFor(gender: Gender, weight: Double, age: Double) {
        guard let caloriesValue = Double(calories), let timeValue = Double(time) else {
            errorMessage = "Error converting calories or time to Double"
            return
        }
        
        let heartRateRequired: Double
        
        switch gender {
        case .Female:
            heartRateRequired = (caloriesValue * 4.184 / timeValue + 0.1263 * weight - 0.074 * age + 20.4022) / 0.4472
        default: // Assuming Male
            heartRateRequired = (caloriesValue * 4.184 / timeValue - 0.1988 * weight - 0.2017 * age + 55.0969) / 0.6309
        }
        
        heartRate = String(Int(heartRateRequired))
        //        heartRate = String(format: "%.2f", heartRateRequired)
        calculatedValue = "Heart rate required: \(heartRate) bpm"
    }
    
    func getAge() -> Double {
        guard let birthDate = profileViewModel.selectedProfile?.dateOfBirth else { return 0.0 }
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        return Double(ageComponents.year ?? 0)
    }
}

struct CalorieBurnerView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieBurnerView()
    }
}
