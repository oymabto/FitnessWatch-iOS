//
//  ExerciseView.swift
//  test
//
//  Created by Alireza on 2023-08-14.
//

import SwiftUI

extension Color {
    static let activeButtonColor: Color = .green
    static let inactiveButtonColor: Color = .white
        static let yellowBoxColor: Color = .yellow
    //    static let yellowBoxColor: Color = Color(red: 1.0, green: 1.0, blue: 0.7)
    //    static let yellowBoxColor: Color = Color(red: 0.9, green: 0.9, blue: 0.3)
    //    static let yellowBoxColor: Color = Color(red: 0.7, green: 0.7, blue: 0.4)
    //    static let yellowBoxColor: Color = Color(red: 0.0, green: 1.0, blue: 1.0)
//    static let yellowBoxColor: Color = Color(red: 1.0, green: 1.0, blue: 0.6)
    //    static let yellowBoxColor: Color = Color(red: 1.0, green: 1.0, blue: 0.5)
    
}

enum WorkoutStage: String, CaseIterable {
    case warmup = "Warmup"
    case primary = "Primary"
    case cooldown = "Cooldown"
}

enum ExerciseType: String, CaseIterable, Identifiable {
    case none = ""
    case cardio = "Cardio"
    case strength = "Strength"
    case stretch = "Stretching"
    
    var id: String { rawValue }
}

struct ExerciseView: View {
    @State private var exerciseName: String = ""
    @State private var workoutName: String = ""
    @State private var workoutStage = WorkoutStage.primary
    @State private var duration: String = ""
    @State private var exerciseType = ExerciseType.none
    @State private var isCardioActive: Bool = false
    @State private var isStrengthActive: Bool = false
    @State private var isStretchActive: Bool = false
    
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                VStack {
                    Text("Workout Name")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.bottom, 10)
                    
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(Color.yellowBoxColor)
                        .frame(height: 55)
                        .overlay(
                            TextField("Enter exercise name", text: $workoutName)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 40)
                                .padding()
                        )
                }
                .padding(.bottom, 4)
                .background(Color.black)
                
                VStack(spacing: 10) {
                    VStack {
                        Text("Exercise Name")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 10)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(Color.yellowBoxColor)
                            .frame(height: 55)
                            .overlay(
                                TextField("Enter exercise name", text: $exerciseName)
                                    .padding(.horizontal)
                                    .background(Color.white)
                                    .cornerRadius(0)
                                    .font(.headline)
                                    .frame(height: 40)
                                    .padding()
                            )
                    }
                    .padding(.bottom, 4)
                    .background(Color.black)
                    
                    VStack {
                        Text("Workout Stage")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 10)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(Color.yellowBoxColor)
                            .frame(height: 55)
                            .overlay(
                                RadioButtonGroup(selected: $workoutStage)
                            )
                    }
                    .padding(.bottom, 4)
                    .background(Color.black)
                    
                    VStack {
                        Text("Duration")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 10)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(Color.yellowBoxColor)
                            .frame(height: 200)
                            .overlay(
                                VStack{
                                    TextField("Enter exercise name", text: $duration)
                                        .padding(.horizontal)
                                        .background(Color.white)
                                        .cornerRadius(0)
                                        .font(.headline)
                                        .padding()
                                    Text("OR")
                                        .foregroundColor(.black)
                                        .font(.headline)
                                        .padding(.top, 5)
                                    HStack(spacing: 40) {
                                        Button(action: {
                                            //TODO: Start button action
                                        }) {
                                            Text("Start")
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.green)
                                                .cornerRadius(10)
                                        }
                                        
                                        Button(action: {
                                            //TODO: Stop button action
                                        })
                                        {
                                            Text("Stop")
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.red)
                                                .cornerRadius(10)
                                        }
                                        
                                    }
                                    Text("00:00:00.00")
                                        .foregroundColor(.black)
                                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                                        .padding(.top, 5)
                                }
                            )
                    }
                    .padding(.bottom, 4)
                    .background(Color.black)
                    VStack {
                        Text("Category")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.bottom, 10)
                        
                        RoundedRectangle(cornerRadius: 0)
                            .foregroundColor(Color.yellowBoxColor)
                            .frame(height: 150)
                            .overlay(
                                HStack(spacing: 1) {
                                    Button(action: {
                                        exerciseType = .cardio
                                        isCardioActive = true
                                        isStrengthActive = false
                                        isStretchActive = false
                                    }) {
                                        Rectangle()
                                            .frame(width: 120, height: 120)
                                            .foregroundColor(isCardioActive ? .red : .white)
                                            .padding(2)
                                            .overlay(
                                                VStack(spacing: 30){
                                                    Image(systemName: "heart")
                                                        .font(.largeTitle)
                                                        .foregroundColor(.black)
                                                    Text("CARDIO")
                                                        .foregroundColor(.black)
                                                        .font(.headline)
                                                }
                                            )
                                    }
                                    
                                    Button(action: {
                                        exerciseType = .strength
                                        isCardioActive = false
                                        isStrengthActive = true
                                        isStretchActive = false
                                    }) {
                                        Rectangle()
                                            .frame(width: 120, height: 120)
                                            .foregroundColor(isStrengthActive ? .blue : .white)
                                            .padding(2)
                                            .overlay(
                                                VStack(spacing: 30){
                                                    Image(systemName: "dumbbell")
                                                        .font(.largeTitle)
                                                        .foregroundColor(.black)
                                                    Text("STRENGTH")
                                                        .foregroundColor(.black)
                                                        .font(.headline)
                                                }
                                            )
                                    }
                                    Button(action: {
                                        exerciseType = .stretch
                                        isCardioActive = false
                                        isStrengthActive = false
                                        isStretchActive = true
                                    }) {
                                        Rectangle()
                                            .frame(width: 120, height: 120)
                                            .foregroundColor(isStretchActive ? .orange : .white)
                                            .padding(2)
                                            .overlay(
                                                VStack(spacing: 30){
                                                    Image(systemName: "figure.strengthtraining.functional")
                                                        .font(.largeTitle)
                                                        .foregroundColor(.black)
                                                    Text("STRETCHING")
                                                        .foregroundColor(.black)
                                                        .font(.headline)
                                                }
                                            )
                                    }
                                    
                                }
                            )
                    }
                    .padding(.bottom, 4)
                    .background(Color.black)
                    
                    if exerciseType == .cardio {
                        CardioView(
                            workoutName: $workoutName,
                            exerciseName: $exerciseName,
                            workoutStage: $workoutStage,
                            duration: $duration,
                            viewModel: viewModel
                        )
                        
                    } else if exerciseType == .strength {
                        StrengthView(
                                        workoutName: $workoutName,
                                        exerciseName: $exerciseName,
                                        workoutStage: $workoutStage,
                                        duration: $duration,
                                        viewModel: viewModel
                                    )
                    } else if exerciseType == .stretch {
                        StretchView(
                            workoutName: $workoutName,
                            exerciseName: $exerciseName,
                            workoutStage: $workoutStage,
                            duration: $duration,
                            viewModel: viewModel
                        )
                    }
                }
            }
        }
    }
    
}
struct CardioView: View {
    @Binding var workoutName: String
    @Binding var exerciseName: String
    @Binding var workoutStage: WorkoutStage
    @Binding var duration: String
    @State private var minHeartRate: String = ""
    @State private var maxHeartRate: String = ""
    @State private var avgHeartRate: String = ""
    @State private var minSpeed: String = ""
    @State private var maxSpeed: String = ""
    @State private var avgSpeed: String = ""
    @State private var distance: String = ""
    @State private var weight: String = ""
    @State private var reps: String = ""
    @State private var sets: String = ""
    @State private var elevation: String = ""
    @State private var breakTime: String = ""
    
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Heart Rate")
                .foregroundColor(.white)
                .font(.title)
                .padding(.bottom, 10)
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color.yellowBoxColor)
                .frame(height: 120)
                .overlay(
                    VStack {
                        TextField("Minimum", text: $minHeartRate)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 10)
                            .padding(10)
                        
                        TextField("Maximum", text: $maxHeartRate)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 10)
                            .padding(10)
                        
                        TextField("Average", text: $avgHeartRate)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 10)
                            .padding(10)
                    })
        }
        //            .padding()
        .background(Color.black)
        VStack(spacing: 10) {
            Text("Cardio Target")
                .foregroundColor(.white)
                .font(.title)
                .padding(.bottom, 10)
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(Color.yellowBoxColor)
                .frame(height: 290)
                .overlay(
                    VStack {
                        Text("Distance")
                            .font(.headline)
                            .padding(5)
                        TextField("Distance", text: $distance)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 10)
                            .padding(10)
                        Text("OR")
                            .font(.largeTitle)
                            .padding(5)
                        Text("Non - Distance")
                            .font(.headline)
                            .padding(5)
                        TextField("Weight", text: $weight)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 10)
                            .padding(10)
                        
                        TextField("Reps", text: $reps)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 10)
                            .padding(10)
                        TextField("Sets", text: $sets)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 10)
                            .padding(10)
                    })
        }
        //            .padding()
        .background(Color.black)
        VStack(spacing: 10) {
            VStack {
                Text("Change in Elevation")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 10)
                
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellowBoxColor)
                    .frame(height: 55)
                    .overlay(
                        TextField("Change in elevation", text: $elevation)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 40)
                            .padding()
                    )
            }
            .padding(.bottom, 4)
            .background(Color.black)
            VStack(spacing: 10) {
                Text("Speed")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 10)
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellowBoxColor)
                    .frame(height: 120)
                    .overlay(
                        VStack {
                            TextField("Minimum", text: $minSpeed)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                            
                            TextField("Maximum", text: $maxSpeed)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                            
                            TextField("Average", text: $avgSpeed)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                        })
            }
            //            .padding()
            .background(Color.black)
            VStack(spacing: 10) {
                Button("     Add New Exercise                              ") {
                    // TODO: Handle action
                    viewModel.addNewExercise(
                        exerciseName: exerciseName,
                        duration: duration,
                        exerciseType: .cardio, // Assuming Cardio is the type in this view
                        minHeartRate: minHeartRate,
                        maxHeartRate: maxHeartRate,
                        avgHeartRate: avgHeartRate,
                        minSpeed: minSpeed,
                        maxSpeed: maxSpeed,
                        avgSpeed: avgSpeed,
                        distance: distance,
                        weight: weight,
                        reps: reps,
                        sets: sets,
                        elevation: elevation,
                        workoutStage: workoutStage
                    )
                }
                .frame(maxWidth: .infinity)
                .padding()
                //                .buttonStyle(.plain)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(0)
                HStack {
                    Button("Workout Completed") {
                        // TODO: Handle action
                        viewModel.workoutCompleted(
                            workoutName: workoutName,
                            warmupExercises: viewModel.warmupExercises,
                            cooldownExercise: viewModel.cooldownExercise,
                            primaryExercises: viewModel.primaryExercises
                        )
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(0)
                    
                    Button("Save As Template") {
                        // TODO: Handle action
                        viewModel.saveAsTemplate(
                            workoutName: workoutName,
                            warmupExercises: viewModel.warmupExercises,
                            cooldownExercise: viewModel.cooldownExercise,
                            primaryExercises: viewModel.primaryExercises
                        )
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(0)
                }
            }
        }
    }
}

struct StrengthView: View {
    @Binding var workoutName: String
    @Binding var exerciseName: String
    @Binding var workoutStage: WorkoutStage
    @Binding var duration: String
    @State private var weight: String = ""
    @State private var reps: String = ""
    @State private var sets: String = ""
    
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 10){
                Text("Weight, Reps and Sets")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 10)
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellowBoxColor)
                    .frame(height: 180)
                    .overlay(
                        VStack {
                            TextField("Weight", text: $weight)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                            
                            TextField("Reps", text: $reps)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                            
                            TextField("Sets", text: $sets)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                            Button("     Add New Weight                              ") {
                                // TODO: Handle action
                            }
                            
                            .frame(maxWidth: .infinity)
                            .padding()
                            //                .buttonStyle(.plain)
                            .background(Color.gray)
                            .foregroundColor(.black)
                            .cornerRadius(0)
                        })
            }
            //            .padding()
            .background(Color.black)
            VStack(spacing: 10) {
                Button("     Add New Exercise                              ") {
                    // TODO: Handle action
                    viewModel.addNewExercise(
                        exerciseName: exerciseName,
                        duration: duration,
                        exerciseType: .strength,
                        minHeartRate: "",
                        maxHeartRate: "",
                        avgHeartRate: "",
                        minSpeed: "",
                        maxSpeed: "",
                        avgSpeed: "",
                        distance: "",
                        weight: weight,
                        reps: reps,
                        sets: sets,
                        elevation: "",
                        workoutStage: workoutStage
                    )
                }
                
                .frame(maxWidth: .infinity)
                .padding()
                //                .buttonStyle(.plain)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(0)
                HStack {
                    Button("Workout Completed") {
                        // TODO: Handle action
                        viewModel.workoutCompleted(
                            workoutName: workoutName,
                            warmupExercises: viewModel.warmupExercises,
                            cooldownExercise: viewModel.cooldownExercise,
                            primaryExercises: viewModel.primaryExercises
                        )
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(0)
                    
                    Button("Save As Template") {
                        // TODO: Handle action
                        viewModel.saveAsTemplate(
                            workoutName: workoutName,
                            warmupExercises: viewModel.warmupExercises,
                            cooldownExercise: viewModel.cooldownExercise,
                            primaryExercises: viewModel.primaryExercises
                        )
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(0)
                }
            }
        }
    }
}

struct StretchView: View {
    @Binding var workoutName: String
    @Binding var exerciseName: String
    @Binding var workoutStage: WorkoutStage
    @Binding var duration: String
    @State private var repsDuration: String = ""
    @State private var reps: String = ""
    @State private var sets: String = ""
    @State private var isTemplate: Bool = false
    @State private var isCompleted: Bool = false
    
    @ObservedObject var viewModel: WorkoutViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 10){
                Text("Weight, Reps and Sets")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 10)
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellowBoxColor)
                    .frame(height: 180)
                    .overlay(
                        VStack {
                            TextField("Duration", text: $repsDuration)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                            
                            TextField("Reps", text: $reps)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                            
                            TextField("Sets", text: $sets)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 10)
                                .padding(10)
                        })
            }
            //            .padding()
            .background(Color.black)
            VStack(spacing: 10) {
                Button("     Add New Exercise                              ") {
                    viewModel.addNewExercise(
                            exerciseName: exerciseName,
                            duration: duration,
                            exerciseType: .stretch,
                            minHeartRate: "0", // Placeholder
                            maxHeartRate: "0", // Placeholder
                            avgHeartRate: "0", // Placeholder
                            minSpeed: "0",     // Placeholder
                            maxSpeed: "0",     // Placeholder
                            avgSpeed: "0",     // Placeholder
                            distance: "0",     // Placeholder
                            weight: "0",       // Placeholder
                            reps: reps,
                            sets: sets,
                            elevation: "0",   // Placeholder
                            workoutStage: workoutStage
                        )
                }
                
                .frame(maxWidth: .infinity)
                .padding()
                //                .buttonStyle(.plain)
                .background(Color.gray)
                .foregroundColor(.black)
                .cornerRadius(0)
                HStack {
                    Button("Workout Completed") {
                        // TODO: Handle action
                        viewModel.workoutCompleted(
                            workoutName: workoutName,
                            warmupExercises: viewModel.warmupExercises,
                            cooldownExercise: viewModel.cooldownExercise,
                            primaryExercises: viewModel.primaryExercises
                        )
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(0)
                    
                    Button("Save As Template") {
                        // TODO: Handle action
                        viewModel.saveAsTemplate(
                            workoutName: workoutName,
                            warmupExercises: viewModel.warmupExercises,
                            cooldownExercise: viewModel.cooldownExercise,
                            primaryExercises: viewModel.primaryExercises
                        )
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(0)
                }
            }
        }
    }
}

struct RadioButtonGroup: View {
    @Binding var selected: WorkoutStage
    
    var body: some View {
        HStack {
            ForEach(WorkoutStage.allCases, id: \.self) { stage in
                RadioButtonField(id: stage, label: stage.rawValue, selected: $selected)
                if stage != WorkoutStage.allCases.last {
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct RadioButtonField: View {
    let id: WorkoutStage
    let label: String
    @Binding var selected: WorkoutStage
    
    var body: some View {
        Button(action: {
            selected = id
        }) {
            HStack {
                Text(label)
                Spacer()
                Image(systemName: selected == id ? "largecircle.fill.circle" : "circle")
            }
            .foregroundColor(.black)
            
        }
    }
}



