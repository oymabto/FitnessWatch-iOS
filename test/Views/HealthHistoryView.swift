//
//  HealthHistoryView.swift
//  test
//
//  Created by david on 2023-08-15.
//

import SwiftUI
import RealmSwift

struct HealthHistoryView: View {
    
    @State private var listOfDailyHealthData = [DailyHealthData]()
    
    @State private var restingHeartRate: Double = 60.0
    @State private var bloodPressure: Double = 120.0
    @State private var weightString: String = "60.1"
    @State private var selectedDate = Date()
    @State private var isDatePickerVisible = false
    
    let intFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()
    let maxDecimalDigits = 1
    
    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Text("HEALTH")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 10)
                
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellowBoxColor)
                    .frame(height: 60)
                    .overlay(
                        HStack{
                            Label("Resting heart rate:", systemImage: "waveform.path").font(.headline).foregroundColor(Color.black)
                            TextField("Enter resting heart rate", value: $restingHeartRate, formatter: intFormatter)
                                .keyboardType(.numberPad)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 40)
                                .padding()
                        }
                    )
                
                
                
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellowBoxColor)
                    .frame(height: 55)
                    .overlay(
                        HStack {
                            Label("Blood pressure:", systemImage: "heart.fill").font(.headline).foregroundColor(Color.black)
                            TextField("Enter blood pressure", value: $bloodPressure, formatter: intFormatter)
                                .keyboardType(.numberPad)
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(0)
                                .font(.headline)
                                .frame(height: 40)
                                .padding()                        }
                        
                    )
                
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(Color.yellowBoxColor)
                    .frame(height: 55)
                    .overlay(
                        HStack {
                            
                            Label("Weight:", systemImage: "w.square").font(.headline).foregroundColor(Color.black)
                        TextField("Enter weight", text: $weightString)
                            .keyboardType(.numberPad)
                            .padding(.horizontal)
                            .background(Color.white)
                            .cornerRadius(0)
                            .font(.headline)
                            .frame(height: 40)
                            .padding()
                            .onChange(of: weightString){ newValue in
                                
                                // Format the input to limit the number of decimal digits
                                if let decimalSeparatorIndex = newValue.firstIndex(of: ".") {
                                    let decimalDigits = newValue[decimalSeparatorIndex...].dropFirst()
                                    if decimalDigits.count > maxDecimalDigits {
                                        let validDecimalPart = decimalDigits.prefix(maxDecimalDigits)
                                        weightString = String(newValue.prefix(upTo: decimalSeparatorIndex)) + "." + validDecimalPart
                                    }
                                }
                                
                            }
                        }
                        
                        
                    )
                
            }
            .padding(.bottom, 4)
            .background(Color.black)
            
            HStack {
            Text("\(selectedDate, formatter: dateFormatter)")
                .padding()
            
            Button(action: {
                isDatePickerVisible.toggle()
            }) {
                Image(systemName: "calendar")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $isDatePickerVisible, content: {
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .navigationBarItems(trailing: Button("Done") {
                        isDatePickerVisible = false
                    })
                
            }) //: end of Button
            }
            
            
            Button("Save") {
                

                do {
                    let realm = try Realm()
                    
                    if let weight = Double(weightString) {
                    let data = DailyHealthData(dateTime: selectedDate, type: "weight", value: weight)
                        listOfDailyHealthData.append(data)
                        try realm.write {
                            realm.add(data)
                        }
                        
                    }
                    if (restingHeartRate > 40 && restingHeartRate < 200) {
                        let data = DailyHealthData(dateTime: selectedDate, type: DailyHealthData.RESTING_HEART_RATE, value: restingHeartRate)
                        listOfDailyHealthData.append(data)
                        try realm.write {
                            realm.add(data)
                        }
                        
                    }
                    if (bloodPressure > 60 && bloodPressure < 200){
                        let data = DailyHealthData(dateTime: selectedDate, type: DailyHealthData.BLOOD_PRESSURE, value: bloodPressure)
                        listOfDailyHealthData.append(data)
                        try realm.write {
                            realm.add(data)
                        }
                        
                    }
                    
                } catch {
                    print("Error initialising new real, \(error)")
                }
                
                
            }.padding() //: end of Button
            
            
            HealthHistoryGraph(
                data: listOfDailyHealthData
            ).onAppear {
                do {
                    let realm = try Realm()
                    let results = realm.objects(DailyHealthData.self).sorted(byKeyPath: "dateTime", ascending: true)
                    
                    listOfDailyHealthData.removeAll()
                    
                    for result in results {
                        listOfDailyHealthData.append(result)
                    }
                    
                } catch {
                    print("\(error)")
                }
            }        } //: end of Vstack
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
}

struct HealthHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HealthHistoryView()
    }
}
