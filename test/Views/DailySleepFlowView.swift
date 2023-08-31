//
//  DailySleepFlowView.swift
//  test
//
//  Created by david on 2023-08-19.
//

import SwiftUI
import RealmSwift

struct DailySleepFlowView: View {
    
    @ObservedObject var dataModel = DailySleepViewModel()
    
    
    @State private var isChecked = true
    
    @State private var selectedDate = Date()
    @State private var isDatePickerVisible = false
    
    @State private var selectedBedTime = Date()
    @State private var isBedTimePickerVisible = false
    
    @State private var selectedRiseTime = Date()
    @State private var isRiseTimePickerVisible = false
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: selectedDate)
    }
    
    var formattedBedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: selectedBedTime)
    }
    
    var formattedRiseTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: selectedRiseTime)
    }
    
    var bedDateTime: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        return calendar.date(bySettingHour: calendar.component(.hour, from: selectedBedTime),
                             minute: calendar.component(.minute, from: selectedBedTime),
                             second: 0,
                             of: calendar.date(from: dateComponents)!)!
    }
    
    var riseDateTime: Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let riseDateTime = calendar.date(bySettingHour: calendar.component(.hour, from: selectedRiseTime),
                                         minute: calendar.component(.minute, from: selectedRiseTime),
                                         second: 0,
                                         of: calendar.date(from: dateComponents)!)!
        return calendar.date(byAdding: .day, value: 1, to: riseDateTime)!
    }
    
    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Text("SLEEP LOG")
                    .foregroundColor(.black)
                    .font(.title)
                    .padding()
                
                HStack {
                    Text(formattedDate)
                        .padding()
                    
                    Button(action: {
                        isDatePickerVisible.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isDatePickerVisible, content: {
                        DatePicker("Select a date", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .navigationBarItems(trailing: Button("Done") {
                                isDatePickerVisible = false
                            })
                    }) //: end of date pikcer Button
                } //: end of h stack
                
                HStack {
                    Text("\(formattedBedTime)")
                        .padding()
                    
                    Button(action: {
                        isBedTimePickerVisible.toggle()
                    }) {
                        Image(systemName: "clock")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isBedTimePickerVisible, content: {
                        DatePicker("Select a date",
                                   selection: $selectedBedTime,
                                   displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .navigationBarItems(trailing: Button("Done") {
                            isBedTimePickerVisible = false
                        })
                        
                    }) //: end of date pikcer Button
                    
                    Text(" --- ")
                    
                    Text("\(formattedRiseTime)")
                        .padding()
                    
                    Button(action: {
                        isRiseTimePickerVisible.toggle()
                    }) {
                        Image(systemName: "clock")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isRiseTimePickerVisible, content: {
                        DatePicker("Select a date",
                                   selection: $selectedRiseTime,
                                   displayedComponents: [.hourAndMinute])
                        .datePickerStyle(.wheel)
                        .navigationBarItems(trailing: Button("Done") {
                            isRiseTimePickerVisible = false
                        })
                    }) //: end of date pikcer Button
                } //: end of h stack
                HStack {
                    Spacer() // Push elements to the center horizontally
                    
                    Toggle("Rested: ", isOn: $isChecked)
                        .frame(width: 140)
                        .padding(.horizontal)
                    Spacer() // Push elements to the center horizontally
                }
                .padding()
                
                Button("Save") {
                    let sleep = DailySleepFlowData(bedTimeDateTime: bedDateTime, riseDateTime: riseDateTime, isRested: isChecked)
                    dataModel.addOrUpdate(sleep)
                }.padding() //: end of Button
                
                
                DailySleepFlowGraph(
                    list: dataModel.list
//                    list: DailySleepFlowData.mockList  //: for preview
                )
                .padding([.leading, .trailing], 30)
                .onAppear {
                    dataModel.getAll()
                } //: end of Daily Sleep FlowGraph
            } //: end of Vstack
        } //: end of v stack
    } //: end of body
} //: end of struct View


struct DailySleepFlowView_Previews: PreviewProvider {
    static var previews: some View {
        DailySleepFlowView()
    }
}
