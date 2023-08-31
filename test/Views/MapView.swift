//
//  MapView.swift
//  test
//
//  Created by Alireza on 2023-08-15.
//

import Foundation
import SwiftUI
import RealmSwift

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var runViewModel = RunViewModel()
    @StateObject private var exerciseViewModel = ExerciseViewModel()
    @State private var isTracking = false
    @State private var elapsedTime: TimeInterval = 0.0
    @State private var timer: Timer?
    @State private var buttonLabel = "Start"
    @State private var buttonColor = Color.green
    @State private var showActivityButtons = false
    @State private var showHomePage = false
    
    var body: some View {
        VStack {
            GoogleMapView(viewModel: runViewModel)
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.height * 7/12)
            
            Spacer()
            
            VStack {
                HStack {
                    VStack {
                        Text("Time:")
                        Text("\(formattedElapsedTime(elapsedTime))")
                    }
                    Spacer()
                    VStack {
                        Text("Distance:")
                        Text("\(String(format: "%.2f", locationManager.totalDistance)) meters")
                    }
                    Spacer()
                    VStack {
                        Text("Elevation:")
                        Text("\(String(format: "%.2f", locationManager.elevation)) meters")
                    }
                }
                .padding(20)
                VStack{
                    HStack {
                        Button(action: {
                            if isTracking {
                                pauseTracking()
                            } else if timer == nil {
                                startTracking()
                            } else {
                                resumeTracking()
                            }
                        }) {
                            Circle()
                                .frame(width: 70, height: 70)
                                .foregroundColor(buttonColor)
                                .overlay(
                                    Text(buttonLabel)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                )
                        }
                        .padding(.bottom, 10)
                        .disabled(showActivityButtons)
                    }
                    Spacer()
                    HStack{
                        if showActivityButtons {
                            HStack {
                                Button("Save Activity") {
                                    saveRunningActivity()
                                }
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                
                                Button("Resume") {
                                    resumeTracking()
                                }
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                
                                Button("Cancel Activity") {
                                    self.showHomePage = true
                                }
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                }
                .simultaneousGesture(
                    LongPressGesture(minimumDuration: 2.0)
                        .onEnded { _ in
                            if isTracking {
                                stopTracking()
                            }
                            showActivityButtons = true
                        }
                )
            }
            NavigationLink("", destination: HomePageView(), isActive: $showHomePage).hidden()
        }
    }
    private func startTracking() {
        print("Start Tracking method called in MapView")
        isTracking = true
        buttonLabel = "Pause"
        buttonColor = Color.yellow
        showActivityButtons = false
        //MARK: Testing
        locationManager.shouldStopSimulating = false
        locationManager.startTracking()
        startTimer()
    }
    
    private func pauseTracking() {
        print("Pause Tracking method called in MapView")
        isTracking = false
        buttonLabel = "Resume"
        buttonColor = Color.green
        //MARK: Testing
        locationManager.shouldStopSimulating = true
        locationManager.stopTracking()
        stopTimer()
    }
    
    private func resumeTracking() {
        print("Resume Tracking method called in MapView")
        isTracking = true
        buttonLabel = "Pause"
        buttonColor = Color.yellow
        //MARK: Testing
        locationManager.shouldStopSimulating = false
        locationManager.startTracking()
        startTimer()
        showActivityButtons = false
    }
    
    private func stopTracking() {
        print("Stop Tracking method called in MapView")
        isTracking = false
        buttonLabel = "Stop"
        buttonColor = Color.red
        //MARK: Testing
        locationManager.shouldStopSimulating = true
        locationManager.stopTracking()
        stopTimer()
        showActivityButtons = true
    }
    
    private func startTimer() {
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                print("Timer is running!")
                self.elapsedTime += 0.01
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func formattedElapsedTime(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: timeInterval) ?? "00:00:00"
    }
    
    private func formattedStartTime() -> String {
        let startTime = Date().addingTimeInterval(-elapsedTime)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: startTime)
    }
    
    private func formattedEndTime() -> String {
        let endTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: endTime)
    }
    
    private func saveRunningActivity() {
        // Creating an exercise first
        let runningExercise = Exercise()
        runningExercise.profileId = "YOUR_USER_PROFILE_ID"
        let randomSuffix = String(Int.random(in: 100_000...999_999))
        runningExercise.name = "Running-\(randomSuffix)"
        runningExercise.category = .cardio
        runningExercise.workoutStage = .Primary
        runningExercise.startTime = formattedStartTime()
        runningExercise.endTime = formattedEndTime()
        runningExercise.duration = formattedElapsedTime(elapsedTime)
        runningExercise.distance = Float(locationManager.totalDistance)
        exerciseViewModel.createExercise(exercise: runningExercise)
        
        // Creating a workout including the created exercise above
        let runningWorkout = Workout()
        runningWorkout.name = "Running Workout - \(randomSuffix)"
        runningWorkout.isCompleted = true
        runningWorkout.workoutDate = Date()
        runningWorkout.primaryExercises.append(runningExercise)
        
        // Saving the workout using the WorkoutViewModel
        let workoutViewModel = WorkoutViewModel()
        workoutViewModel.workoutCompleted(
            workoutName: runningWorkout.name,
            warmupExercises: List<Exercise>(),
            cooldownExercise: List<Exercise>(),
            primaryExercises: runningWorkout.primaryExercises
        )
    }
}
